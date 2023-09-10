locals {
  availability_zones = ["us-east-2a", "us-east-2c"]
}

module "www" {
  source = "./webserver"

  count             = length(local.availability_zones)
  availability_zone = local.availability_zones[count.index]
  instance_type     = "t4g.nano"

  tags = {
    Name  = "${var.server_name}-${count.index}"
    Owner = var.owner_email
    Class = var.class_name
  }
}

output "private_ips" {
  description = "Private IP addresses for the webserver instances."
  value       = module.www[*].webserver_private_ip
}
