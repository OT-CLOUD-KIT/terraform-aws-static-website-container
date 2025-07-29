output "bucket_name" {
  value = aws_s3_bucket.main.bucket
}

output "website_url" {
  value = aws_s3_bucket_website_configuration.main.website_endpoint
}

output "cloudfront_domain_name" {
  value = try(aws_cloudfront_distribution.main[0].domain_name, null)
}
