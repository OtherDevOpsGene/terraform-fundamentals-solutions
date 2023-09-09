terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.16.1"
    }
  }

  required_version = ">= 1.5.6"
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "hello_world" {
  # AMI ID from https://cloud-images.ubuntu.com/locator/ec2/
  ami           = "ami-02ee5a6c04de8002a"
  instance_type = "t4g.nano"

  ebs_optimized = true
  monitoring    = true

  metadata_options {
    http_tokens = "required"
  }

  tags = {
    Name  = "hello_world"
    Owner = "otherdevopsgene@portinfo.com"
    Class = "Terraform Fundamentals"
  }
}
