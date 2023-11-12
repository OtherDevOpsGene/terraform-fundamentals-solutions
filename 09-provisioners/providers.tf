terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.25.0"
    }
  }

  required_version = ">= 1.6.2"

  backend "s3" {
    region  = "us-east-2"
    bucket  = "gg-06-multi-1111"
    key     = "09-provisioners"
    profile = ""
    encrypt = "true"

    dynamodb_table = "gg-06-multi-1111-lock"
  }
}

provider "aws" {
  region = var.aws_region
}
