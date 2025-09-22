variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default = "static-site-bucket"
}

variable "aliases" {
  description = "CloudFront aliases"
  type        = list(string)
  default     = []
}

variable "force_destroy" {
  description = "Force delete bucket on destroy"
  type        = bool
  default     = true
}

variable "ssl_certificate_arn" {
  description = "ACM certificate ARN for HTTPS"
  type        = string
  default     = ""
}

variable "allowed_ips" {
  description = "IP list allowed to access bucket"
  type        = list(string)
  default     = []
}

variable "web_acl_id" {
  description = "WAF ACL ID"
  type        = string
  default     = ""
}

variable "refer_secret" {
  description = "Custom header for CF access"
  type        = string
  default     = "123-VERY-SECRET-123"
}

variable "cloudfront_price_class" {
  description = "CloudFront price class"
  type        = string
  default     = "PriceClass_100"
}

variable "index_document" {
  description = "S3 index file"
  type        = string
  default     = "index.html"
}

variable "error_document" {
  description = "S3 error file"
  type        = string
  default     = "error.html"
}

variable "error_response_code" {
  description = "CloudFront 404 error response"
  type        = string
  default     = "404"
}

variable "spa_error_response_code" {
  description = "SPA error response (usually 200)"
  type        = string
  default     = "200"
}



variable "lambda_edge_enabled" {
  description = "Enable Lambda@Edge"
  type        = bool
  default     = false
}

variable "cf_ipv6_enabled" {
  description = "Enable IPv6"
  type        = bool
  default     = true
}

variable "single_page_application" {
  description = "Is SPA?"
  type        = bool
  default     = false
}


variable "env" {
  type = string
  default = "dev"
  
} 
variable "owner" {
  type = string
  default = "opstree"
}

variable "app" {
  type = string
  default = "otcloud-kit"
}