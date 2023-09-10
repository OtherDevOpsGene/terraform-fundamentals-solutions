data "aws_availability_zones" "available" {
  state = "available"
}

module "www" {
  source = "./webserver"

  for_each          = toset(data.aws_availability_zones.available.names)
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
