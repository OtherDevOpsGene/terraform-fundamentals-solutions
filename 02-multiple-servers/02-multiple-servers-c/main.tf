locals {
  # AMI ID from https://cloud-images.ubuntu.com/locator/ec2/
  ubuntu_ami_id = "ami-02ee5a6c04de8002a"
}

resource "aws_instance" "webserver" {
  count = 2

  ami           = local.ubuntu_ami_id
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
