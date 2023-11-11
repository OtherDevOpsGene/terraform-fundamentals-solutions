locals {
  availability_zones = ["us-east-2a", "us-east-2c"]
}

module "www" {
  source = "./modules/webserver"

  count             = length(local.availability_zones)
  availability_zone = local.availability_zones[count.index]
  instance_type     = "t4g.nano"

  tags = {
    Name   = "${var.server_name}-${count.index}"
    Owner  = var.owner_email
    Class  = var.class_name
    Lesson = "lesson-03"
  }
}

output "public_ips" {
  description = "Public IP addresses for the webserver instances."
  value       = module.www[*].webserver_public_ip
}
