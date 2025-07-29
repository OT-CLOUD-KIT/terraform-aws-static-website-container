output "bucket_name" {
  description = "The name of the S3 bucket used for the static site"
  value       = module.static_site.bucket_name
}

output "website_url" {
  description = "The website endpoint of the S3 bucket"
  value       = module.static_site.website_url
}

output "cloudfront_domain_name" {
  description = "The domain name of the CloudFront distribution"
  value       = module.static_site.cloudfront_domain_name
}
