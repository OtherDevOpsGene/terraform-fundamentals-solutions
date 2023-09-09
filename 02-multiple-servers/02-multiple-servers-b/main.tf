resource "aws_instance" "webserver" {
  count = 2

  # AMI ID from https://cloud-images.ubuntu.com/locator/ec2/
  ami           = "ami-02ee5a6c04de8002a"
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
