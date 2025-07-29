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


###########################
# Naming & Tags
###########################
variable "env" {
  description = "Environment short name."
  type        = string
  default     = "d"
  validation {
    condition     = contains(["d", "p", "q", "s", "g"], var.env)
    error_message = "env must be one of 'd', 'p', 'q', 's', 'g'."
  }
}

variable "bu" {
  description = "Business unit name."
  type        = string
  default     = "ot"
  validation {
    condition     = length(var.bu) <= 5
    error_message = "The business unit name must be less than or equal to 5 characters."
  }
}

variable "app" {
  description = "Application name."
  type        = string
  default     = "bp"
  validation {
    condition     = length(var.app) <= 6
    error_message = "The app name must be less than or equal to 6 characters."
  }
}

variable "resource" {
  description = "Resource name."
  type        = string
  default     = "KMS"
  validation {
    condition     = length(var.resource) <= 15
    error_message = "The resource name must be less than or equal to 15 characters."
  }
}

variable "tenant" {
  description = "Tenant name."
  type        = string
  default     = ""
  validation {
    condition     = length(var.tenant) <= 6
    error_message = "The tenant name must be less than or equal to 6 characters."
  }
}

variable "random_alphanumeric_len" {
  description = "Length of random alphanumeric string."
  type        = number
  default     = 4
  validation {
    condition     = var.random_alphanumeric_len >= 1 && var.random_alphanumeric_len <= 4
    error_message = "The length must be between 1 and 4."
  }
}

variable "special" {
  type    = bool
  default = false
}

variable "upper" {
  type    = bool
  default = false
}

variable "number" {
  type    = bool
  default = true
}

variable "gen_no_of_names" {
  type    = number
  default = 1
}

variable "team" {
  type    = string
  default = "infra"
}

variable "program" {
  type    = string
  default = "ot"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "enabled_features" {
  type    = list(string)
  default = []
}
