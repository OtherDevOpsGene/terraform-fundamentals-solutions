locals {
  canonical_owner_ids = ["099720109477"]
}

data "aws_ec2_instance_type" "webserver" {
  instance_type = var.instance_type
}

data "aws_ami" "ubuntu_focal" {
  most_recent = true
  owners      = local.canonical_owner_ids

  filter {
    name   = "name"
    values = ["ubuntu/images/*-ssd/ubuntu-*-20.04-*-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = data.aws_ec2_instance_type.webserver.supported_virtualization_types
  }

  filter {
    name   = "architecture"
    values = data.aws_ec2_instance_type.webserver.supported_architectures
  }
}

resource "aws_instance" "webserver" {
  ami           = data.aws_ami.ubuntu_focal.id
  instance_type = var.instance_type

  availability_zone = var.availability_zone

  ebs_optimized = true
  monitoring    = true

  metadata_options {
    http_tokens = "required"
  }

  root_block_device {
    encrypted = true
  }

  tags = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_ec2_instance_state" "running" {
  instance_id = aws_instance.webserver.id
  state       = "running"
}
