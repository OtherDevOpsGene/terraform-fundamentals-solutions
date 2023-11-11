terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.25.0"
    }
  }

  required_version = ">= 1.6.2"
}

provider "aws" {
  region = var.aws_region
}
