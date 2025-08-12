module "standard_tags" {
  source = "git@github.com:OT-CLOUD-KIT/terraform-aws-standard-tagging.git?ref=dev"

  bu      = var.bu
  program = var.program
  app     = var.app
  team    = var.team
  region  = var.region
  env     = var.env
}

module "naming" {
  source   = "git@github.com:OT-CLOUD-KIT/terraform-aws-naming.git?ref=dev"
  bu       = var.bu
  env      = var.env
  app      = var.app
  resource = var.resource
}


module "static_site" {
  source = "git@github.com:OT-CLOUD-KIT/terraform-aws-static-website-container.git?ref=Feature"
  bucket_name             = var.bucket_name
  aliases                 = var.aliases
  force_destroy           = var.force_destroy
  ssl_certificate_arn     = var.ssl_certificate_arn
  allowed_ips             = var.allowed_ips
  bu                      = var.bu
  program                 = var.program
  app                     = var.app
  env                     = var.env
  team                    = var.team
  region                  = var.region
  web_acl_id              = var.web_acl_id
  refer_secret            = var.refer_secret
  cloudfront_price_class  = var.cloudfront_price_class
  index_document          = var.index_document
  error_document          = var.error_document
  error_response_code     = var.error_response_code
  spa_error_response_code = var.spa_error_response_code
  lambda_edge_enabled     = var.lambda_edge_enabled
  cf_ipv6_enabled         = var.cf_ipv6_enabled
  single_page_application = var.single_page_application
}
