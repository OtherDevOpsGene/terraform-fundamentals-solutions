locals {
  availability_zones = ["us-east-2a", "us-east-2c"]
}

module "www" {
  source = "./modules/webserver"

  for_each          = toset(local.availability_zones)
  availability_zone = each.key
  instance_type     = "t4g.nano"

  tags = {
    Name   = "${var.server_name}-${each.key}"
    Owner  = var.owner_email
    Class  = var.class_name
    Lesson = "lesson-03"
  }
}

output "public_ips_list" {
  description = "Public IP addresses for the webserver instances."
  value       = values(module.www)[*].webserver_public_ip
}

output "public_ips" {
  description = "Public IP addresses by instance."
  value = {
    for az in keys(module.www) : az => module.www[az].webserver_public_ip
  }
}
