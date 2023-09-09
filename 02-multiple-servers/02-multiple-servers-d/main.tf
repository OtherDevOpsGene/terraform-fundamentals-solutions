data "aws_ami" "ubuntu_focal" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-20.04-arm64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "webserver" {
  count = 2

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
}

output "webserver_public_ips" {
  description = "Public IP addresses of the webserver instances."
  value       = aws_instance.webserver[*].public_ip
}
