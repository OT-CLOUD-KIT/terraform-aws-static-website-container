## Static Container

A reusable Terraform module to deploy a static website using Amazon S3 and CloudFront, optionally protected via custom headers and secured with AWS WAF and ACM SSL certificates

## Features

- Creates an S3 bucket configured for static website hosting

- Adds index.html and error.html configuration

- Applies public access controls based on IP/User-Agent

- Sets up CloudFront distribution with optional SSL



## Providers

| Name                                              | Version  |
|---------------------------------------------------|----------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.82.2   |
| <a name="terraform_module"></a> [Terraform](Terraform\module) | >= 1.12.1|

___

## Architecture



## Usage

```hcl

module "static_site" {
  source = "OT-CLOUD-KIT/terraform-aws-static-website-container"

  bucket_name             = "static-site-bucket"
  aliases                 = []
  force_destroy           = true
  ssl_certificate_arn     = ""
  allowed_ips             = []
  region                  = "us-east-1"
  web_acl_id              = ""
  refer_secret            = "custom-user-agent"
  cloudfront_price_class  = "PriceClass_100"
  index_document          = "index.html"
  error_document          = "error.html"
  error_response_code     = "404"
  spa_error_response_code = "200"
  
  lambda_edge_enabled     = false
  cf_ipv6_enabled         = true
  single_page_application = true
}


```


## Resources


| Name | Description |
|------|-------------|
| <a name="aws_s3_bucket_main"></a> [aws\_s3\_bucket.main](#aws_s3_bucket_main) | Creates the main S3 bucket for static website hosting |
| <a name="aws_s3_bucket_website_configuration_main"></a> [aws\_s3\_bucket\_website\_configuration.main](#aws_s3_bucket_website_configuration_main) | Configures the S3 bucket for static website hosting with index and error documents |
| <a name="aws_s3_bucket_public_access_block_s3_access_block"></a> [aws\_s3\_bucket\_public\_access\_block.s3\_access\_block](#aws_s3_bucket_public_access_block_s3_access_block) | Controls public access to the S3 bucket |
| <a name="aws_s3_bucket_policy_bucket"></a> [aws\_s3\_bucket\_policy.bucket](#aws_s3_bucket_policy_bucket) | Bucket policy allowing read access from specific IPs and CloudFront user-agent |
| <a name="data_aws_iam_policy_document_bucket_policy"></a> [data\_aws\_iam\_policy\_document.bucket\_policy](#data_aws_iam_policy_document_bucket_policy) | IAM policy document used for the S3 bucket policy |
| <a name="aws_cloudfront_distribution_main"></a> [aws\_cloudfront\_distribution.main](#aws_cloudfront_distribution_main) | Creates a CloudFront distribution pointing to the S3 website endpoint |





## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket_name](#input_bucket_name) | Name of the S3 bucket to host the static website | `string` | `"static-site-bucket"` | yes |
| <a name="input_aliases"></a> [aliases](#input_aliases) | Additional domain names for the CloudFront distribution | `list(string)` | `[]` | no |
| <a name="input_force_destroy"></a> [force_destroy](#input_force_destroy) | Whether to forcefully delete the bucket even if it contains objects | `bool` | `true` | no |
| <a name="input_ssl_certificate_arn"></a> [ssl_certificate_arn](#input_ssl_certificate_arn) | ARN of the ACM SSL certificate for HTTPS support | `string` | `""` | no |
| <a name="input_allowed_ips"></a> [allowed_ips](#input_allowed_ips) | List of IPs allowed to access the site (optional IP restriction) | `list(string)` | `[]` | no |
| <a name="input_web_acl_id"></a> [web_acl_id](#input_web_acl_id) | AWS WAF Web ACL ID to associate with CloudFront | `string` | `""` | no |
| <a name="input_refer_secret"></a> [refer_secret](#input_refer_secret) | Custom user-agent or header for request validation | `string` | `"custom-user-agent"` | no |
| <a name="input_cloudfront_price_class"></a> [cloudfront_price_class](#input_cloudfront_price_class) | Price class for CloudFront (e.g., PriceClass_100) | `string` | `"PriceClass_100"` | no |
| <a name="input_index_document"></a> [index_document](#input_index_document) | Default document for S3 static website hosting | `string` | `"index.html"` | no |
| <a name="input_error_document"></a> [error_document](#input_error_document) | Custom error page for S3 static hosting | `string` | `"error.html"` | no |
| <a name="input_error_response_code"></a> [error_response_code](#input_error_response_code) | HTTP error response code (e.g., 404) | `string` | `"404"` | no |
| <a name="input_spa_error_response_code"></a> [spa_error_response_code](#input_spa_error_response_code) | Response code for SPA fallback errors | `string` | `"200"` | no |
| <a name="input_random_alphanumeric_len"></a> [random_alphanumeric_len](#input_random_alphanumeric_len) | Length of random suffix used for naming | `number` | `4` | no |




___

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_name"></a> [bucket_name](#output_bucket_name) | Name of the created S3 bucket used for static website hosting |
| <a name="output_website_url"></a> [website_url](#output_website_url) | Public URL of the static website hosted on the S3 bucket |
| <a name="output_cloudfront_domain_name"></a> [cloudfront_domain_name](#output_cloudfront_domain_name) | Domain name of the CloudFront distribution (if created) |


___

## Contributors

- [Piyush Upadhyay](https://github.com/piiiyuushh)
- [Nikita Joshi](https://github.com/jnikita19)

