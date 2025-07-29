################################## S3 ###################################33

resource "aws_s3_bucket" "main" {
  bucket        = "${local.base_name}-${var.bucket_name}"
  force_destroy = var.force_destroy

    tags          = merge(local.common_tags, 
    { Name = "${local.base_name}-${var.bucket_name}" 
    })

}

resource "aws_s3_bucket_website_configuration" "main" {
  bucket = aws_s3_bucket.main.id

  index_document {
    suffix = var.index_document
  }

  error_document {
    key = var.error_document
  }

  routing_rules = <<EOF
    [{
      "Condition": { "KeyPrefixEquals": "docs/" },
      "Redirect": { "ReplaceKeyPrefixWith": "documents/" }
    }]
  EOF
}

resource "aws_s3_bucket_public_access_block" "s3_access_block" {
  bucket = aws_s3_bucket.main.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = true
  restrict_public_buckets = false
}


resource "aws_s3_bucket_policy" "bucket" {
  bucket = aws_s3_bucket.main.id
  policy = data.aws_iam_policy_document.bucket_policy.json
    depends_on = [aws_s3_bucket_public_access_block.s3_access_block]

}

data "aws_iam_policy_document" "bucket_policy" {
  statement {
    sid       = "AllowedIPReadAccess"
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${var.bucket_name}/*"]

    condition {
      test     = "IpAddress"
      variable = "aws:SourceIp"
      values   = var.allowed_ips
    }

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }

  statement {
    sid       = "AllowCFOriginAccess"
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${var.bucket_name}/*"]

    condition {
      test     = "StringEquals"
      variable = "aws:UserAgent"
      values   = [var.refer_secret]
    }
    

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}


##############################  Cloudfront  ##################################


resource "aws_cloudfront_distribution" "main" {
  count               = var.lambda_edge_enabled ? 0 : 1
  is_ipv6_enabled     = var.cf_ipv6_enabled
  http_version        = "http2"
  enabled             = true
  default_root_object = var.index_document
  web_acl_id          = var.web_acl_id

  origin {
    origin_id   = "origin-${var.bucket_name}"
    domain_name = aws_s3_bucket_website_configuration.main.website_endpoint

    custom_origin_config {
      origin_protocol_policy = "http-only"
      http_port              = 80
      https_port             = 443
      origin_ssl_protocols   = ["TLSv1.2"]
    }

    custom_header {
      name  = "User-Agent"
      value = var.refer_secret
    }
  }

  aliases     = var.aliases
  price_class = var.cloudfront_price_class

  default_cache_behavior {
    target_origin_id       = "origin-${var.bucket_name}"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 300
    max_ttl                = 1200

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  custom_error_response {
    error_code            = 404
    error_caching_min_ttl = 300
    response_code         = var.single_page_application ? var.spa_error_response_code : var.error_response_code
    response_page_path    = "/${var.single_page_application ? var.index_document : var.error_document}"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn            = var.ssl_certificate_arn != "" ? var.ssl_certificate_arn : null
    ssl_support_method             = var.ssl_certificate_arn != "" ? "sni-only" : null
    minimum_protocol_version       = var.ssl_certificate_arn != "" ? "TLSv1" : null
    cloudfront_default_certificate = var.ssl_certificate_arn == "" ? true : false
  }
  
  tags = merge(local.common_tags, {
    Name = "${local.base_name}-cf"
  })
}
