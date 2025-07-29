terraform {
  backend "s3" {
    bucket = "ot-cloud-kit-bucket-2"
    key    = "ot/module/Static_container/terraform.tfstate"
    region = "us-east-1"

  }
}