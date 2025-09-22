
variable "bucket_name" {
  type = string
  default = "static-site-bucket"
}

variable "aliases" {
  type    = list(string)
  default = []
}

variable "force_destroy" {
  type    = bool
  default = true
}

variable "ssl_certificate_arn" {
  type    = string
  default = ""
}

variable "allowed_ips" {
  type    = list(string)
  default = []
}

variable "web_acl_id" {
  type    = string
  default = ""
}

variable "refer_secret" {
  type    = string
  default = "123-VERY-SECRET-123"
}

variable "cloudfront_price_class" {
  type    = string
  default = "PriceClass_100"
}

variable "index_document" {
  type    = string
  default = "index.html"
}

variable "error_document" {
  type    = string
  default = "error.html"
}

variable "error_response_code" {
  type    = string
  default = "404"
}

variable "spa_error_response_code" {
  type    = string
  default = "200"
}



variable "lambda_edge_enabled" {
  type    = bool
  default = false
}

variable "cf_ipv6_enabled" {
  type    = bool
  default = true
}

variable "single_page_application" {
  type    = bool
  default = false
}

variable "env" {
  type = string
  default = "dev"
}

variable "app" {
  type = string
  default = "otcloud-kit"
}

variable "owner" {
  type = string
  default = "opstree"
}