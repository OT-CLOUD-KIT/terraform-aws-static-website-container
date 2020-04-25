resource "aws_cloudfront_distribution" "main" {
  count = var.lambda_edge_enabled ? 0 : 1

  is_ipv6_enabled = var.cf_ipv6_enabled

  provider     = aws.cloudfront
  http_version = "http2"

  origin {
    origin_id   = "origin-${var.fqdn}"
    domain_name = aws_s3_bucket.main.website_endpoint
    custom_origin_config {
      origin_protocol_policy = "http-only"
      http_port  = "80"
      https_port = "443"
      origin_ssl_protocols = ["TLSv1.2"]
    }
    custom_header {
      name  = "User-Agent"
      value = var.refer_secret
    }
  }

  enabled             = true
  default_root_object = var.index_document

  custom_error_response {
    error_code            = "404"
    error_caching_min_ttl = "300"
    response_code         = var.single_page_application ? var.spa_error_response_code : var.error_response_code
    response_page_path    = "/${var.single_page_application ? var.index_document : var.error_document}"
  }

  aliases = concat([var.fqdn], var.aliases)

  price_class = var.cloudfront_price_class

  default_cache_behavior {
    target_origin_id = "origin-${var.fqdn}"
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    compress         = true

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 300
    max_ttl                = 1200
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = var.ssl_certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1"
  }

  web_acl_id = var.web_acl_id

//  is_ipv6_enabled (Optional) - Whether the IPv6 is enabled for the distribution.

}

resource "aws_cloudfront_distribution" "main-lambda-edge" {
  count = var.lambda_edge_enabled ? 1 : 0

  is_ipv6_enabled = var.cf_ipv6_enabled

  provider     = aws.cloudfront
  http_version = "http2"

  origin {
    origin_id = "origin-${var.fqdn}"
    domain_name = aws_s3_bucket.main.website_endpoint
    custom_origin_config {
      origin_protocol_policy = "http-only"
      http_port              = "80"
      https_port             = "443"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
    custom_header {
      name  = "User-Agent"
      value = var.refer_secret
    }
  }

  enabled             = true
  default_root_object = var.index_document

  custom_error_response {
    error_code            = "404"
    error_caching_min_ttl = "300"
    response_code         = var.single_page_application ? var.spa_error_response_code : var.error_response_code
    response_page_path    = "/${var.single_page_application ? var.index_document : var.error_document}"
  }

  aliases = concat([var.fqdn], var.aliases)

  price_class = "PriceClass_100"

  default_cache_behavior {
    target_origin_id = "origin-${var.fqdn}"
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    compress         = true

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 300
    max_ttl                = 1200

    lambda_function_association {
      event_type = "viewer-request"
      lambda_arn = var.lambda_edge_arn_version
    }

    lambda_function_association {
      event_type = "viewer-response"
      lambda_arn = var.lambda_edge_arn_version
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = var.ssl_certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1"
  }

  web_acl_id = var.web_acl_id
}
