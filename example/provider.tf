terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.5"
    }
  }
}

provider "aws" {
  alias  = "main"
  region = "us-east-1"
}

provider "aws" {
  alias  = "cloudfront"
  region = "us-east-1"
}