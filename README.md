# static_website_container

[![Opstree Solutions][opstree_avatar]][opstree_homepage]<br/>[Opstree Solutions][opstree_homepage] 

  [opstree_homepage]: https://opstree.github.io/
  [opstree_avatar]: https://img.cloudposse.com/150x150/https://github.com/opstree.png

- This repository contains a terraform module for hosting Static website with AWS S3 and cloudfront.
- This project is a part of opstree's ot-aws initiative for terraform modules.

## Usage

```sh
$   cat main.tf
/*-------------------------------------------------------*/
module "s3_website" {
  source                 = "../"
  bucket_name            = var.bucket_name
  ssl_certificate_arn    = aws_acm_certificate_validation.cert.certificate_arn
  allowed_ips            = var.allowed_ips
  index_document         = "index.html"
  error_document         = "error.html"
  force_destroy          = "true"
  cloudfront_price_class = "PriceClass_200"
  providers = {
    aws.main             = aws.main
    aws.cloudfront       = aws.cloudfront
  }
  #web_acl_id = data.terraform_remote_state.site.waf-web-acl-id
}

# ACM Certificate generation
resource "aws_acm_certificate" "cert" {
  provider                = aws.cloudfront
  domain_name             = var.bucket_name
  validation_method       = "DNS"
}

resource "aws_route53_record" "cert_validation" {
  provider                = aws.cloudfront
  name                    = aws_acm_certificate.cert.domain_validation_options.0.resource_record_name
  type                    = aws_acm_certificate.cert.domain_validation_options.0.resource_record_type
  zone_id                 = data.aws_route53_zone.main.id
  records                 = [aws_acm_certificate.cert.domain_validation_options.0.resource_record_value]
  ttl                     = 60
}

resource "aws_acm_certificate_validation" "cert" {
  provider                = aws.cloudfront
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [aws_route53_record.cert_validation.fqdn]
}

# Route 53 record for the static site
data "aws_route53_zone" "main" {
  provider                = aws.main
  name                    = var.domain
  private_zone            = false
}

resource "aws_route53_record" "web" {
  provider                 = aws.main
  zone_id                  = data.aws_route53_zone.main.zone_id
  name                     = var.bucket_name
  type                     = "A"

  alias {
    name                   = module.s3_website.cf_domain_name
    zone_id                = module.s3_website.cf_hosted_zone_id
    evaluate_target_health = false
  }
}

/*-------------------------------------------------------*/
```
```sh
$   cat variable.tf
/*-------------------------------------------------------*/
# AWS Region for S3 and other resources
provider "aws" {
  region = "us-east-1"
  alias = "main"
}

# AWS Region for Cloudfront
provider "aws" {
  region = "us-east-1"
  alias = "cloudfront"
}

###### S3 bucket name
variable "bucket_name" {
  default     = "opstree.shwetaopstree.tk"
}
####### domain name
variable "domain" {
  description = "The domain name."
  default     = "shwetaopstree.tk"
}

###Allowed IPs that can directly access the S3 bucket
variable "allowed_ips" {
  type = list
  default = [
    "0.0.0.0/0"            # public access
  ]
}
/*-------------------------------------------------------*/
```

```sh
$   cat output.tf
/*-------------------------------------------------------*/
output "s3_bucket_id" {
  value = module.s3_website.s3_bucket_id
}
output "s3_bucket_arn" {
  value = module.s3_website.s3_bucket_arn
}
output "s3_domain" {
  value = module.s3_website.s3_website_endpoint
}
output "s3_hosted_zone_id" {
  value = module.s3_website.s3_hosted_zone_id
}
output "cloudfront_domain" {
  value = module.s3_website.cf_domain_name
}
output "acm_certificate_arn" {
  value = aws_acm_certificate_validation.cert.certificate_arn
}
/*-------------------------------------------------------*/
```
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| bucket_name | The bucket_name of the name of the website and also name of the S3 bucket. | `string` | `null` | yes |
| domain | The domain name. | `string` | `null` | yes |
| allowed_ips | A list of IPs that can access the S3 bucket directly. | `string` | `null` | yes |


## Outputs

| Name | Description |
|------|-------------|
| id | The identifier for the distribution. For example: EDFDVBD632BHDS5. |
| arn | The ARN (Amazon Resource Name) for the distribution. |
| domain_name | The domain name corresponding to the distribution |

## Related Projects

Check out these related projects.

- [network_skeleton](https://gitlab.com/ot-aws/terrafrom_v0.12.21/network_skeleton) - Terraform module for providing a general purpose Networking solution
- [security_group](https://gitlab.com/ot-aws/terrafrom_v0.12.21/security_group) - Terraform module for creating dynamic Security groups
- [eks](https://gitlab.com/ot-aws/terrafrom_v0.12.21/eks) - Terraform module for creating elastic kubernetes cluster.
- [HA_ec2_alb](https://gitlab.com/ot-aws/terrafrom_v0.12.21/ha_ec2_alb.git) - Terraform module for creating a Highly available setup of an EC2 instance with quick disater recovery.
- [HA_ec2](https://gitlab.com/ot-aws/terrafrom_v0.12.21/ha_ec2.git) - Terraform module for creating a Highly available setup of an EC2 instance with quick disater recovery.
- [rolling_deployment](https://gitlab.com/ot-aws/terrafrom_v0.12.21/rolling_deployment.git) - This terraform module will orchestrate rolling deployment.

### Contributors

[![Shweta Tyagi][shweta_avatar]][shweta_homepage]<br/>[Shweta Tyagi][shweta_homepage] 

  [shweta_homepage]: https://github.com/shwetatyagi-ot
  [shweta_avatar]: https://img.cloudposse.com/75x75/https://github.com/shwetatyagi-ot.png
