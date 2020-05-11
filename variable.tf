variable "bucket_name" {
  description = "The bucket_name of the name of the website and also name of the S3 bucket"
  type        = string
}
variable "aliases" {
  description = "Any other domain aliases to add to the CloudFront distribution"
  type        = list(string)
  default     = []
}
variable "force_destroy" {
  description = "The force_destroy argument of the S3 bucket"
  type        = string
  default     = "false"
}
variable "ssl_certificate_arn" {
  description = "ARN of the certificate covering the bucket_name and its apex?"
  type        = string
}
variable "allowed_ips" {
  description = "A list of IPs that can access the S3 bucket directly"
  type        = list(string)
  default     = []
}
variable "web_acl_id" {
  description = "WAF Web ACL ID to attach to the CloudFront distribution, optional"
  type        = string
  default     = ""
}
variable "refer_secret" {
  description = "A secret string to authenticate CF requests to S3"
  type        = string
  default     = "123-VERY-SECRET-123"
}
// variable "routing_rules" {
//   type        = string
//   description = "Routing rules for the S3 bucket"
//   default     = ""
// }
variable "cloudfront_price_class" {
  description = "PriceClass for CloudFront distribution"
  type        = string
  default     = "PriceClass_100"
}
variable "index_document" {
  description = "HTML to show at root"
  type        = string
  default     = "index.html"
}
variable "error_document" {
  description = "HTML to show on error"
  type        = string
  default     = "error.html"
}
variable "error_response_code" {
  description = "Response code to send on 404"
  type        = string
  default     = "404"
}
variable "spa_error_response_code" {
  description = "Response code to send on 404 for a single page application"
  type        = string
  default     = "200"
}
variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}
variable "lambda_edge_arn_version" {
  default = ""
  type = string
}
variable "lambda_edge_enabled" {
  default = false
  type = bool
}
variable "cf_ipv6_enabled" {
  default = true
  type = bool
}
variable "single_page_application" {
  default = false
  type = bool
}
