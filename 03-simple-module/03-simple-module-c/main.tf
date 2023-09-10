locals {
  availability_zones = ["us-east-2a", "us-east-2c"]
}

module "www" {
  source = "./webserver"

  for_each          = toset(local.availability_zones)
  availability_zone = each.key
  instance_type     = "t4g.nano"

  tags = {
    Name  = "${var.server_name}-${each.key}"
    Owner = var.owner_email
    Class = var.class_name
  }
}

output "private_ips" {
  description = "Private IP addresses for the webserver instances."
  value       = values(module.www)[*].webserver_private_ip
}
