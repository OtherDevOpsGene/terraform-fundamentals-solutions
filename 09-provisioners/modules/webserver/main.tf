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
  ami                    = data.aws_ami.ubuntu_focal.id
  availability_zone      = var.availability_zone
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [var.security_group]

  ebs_optimized = true
  monitoring    = true

  metadata_options {
    http_tokens = "required"
  }

  root_block_device {
    encrypted = true
  }

  user_data = var.user_data

  tags = var.tags

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = var.private_key
    host        = self.private_ip
  }

  provisioner "file" {
    content     = var.index_html
    destination = "${var.document_root}/index.html"
  }

  lifecycle {
    create_before_destroy = true
  }
}
