locals {
  instance_type       = "t4g.nano"
  canonical_owner_ids = ["099720109477"]
}

data "aws_ec2_instance_type" "webserver" {
  instance_type = local.instance_type
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
  count = 3

  ami           = data.aws_ami.ubuntu_focal.id
  instance_type = "t4g.nano"

  ebs_optimized = true
  monitoring    = true

  metadata_options {
    http_tokens = "required"
  }

  tags = {
    Name  = "${var.server_name}-${count.index}"
    Owner = var.owner_email
    Class = var.class_name
  }

  lifecycle {
    create_before_destroy = true
  }
}

output "webserver_public_ips" {
  description = "Public IP addresses of the webserver instances."
  value       = aws_instance.webserver[*].public_ip
}

output "webserver_public_dns" {
  description = "Public DNS names of the webserver instances."
  value       = aws_instance.webserver[*].public_dns
}

output "third_az" {
  description = "The AWS AZ of the third new instance."
  value       = aws_instance.webserver[2].availability_zone
}

