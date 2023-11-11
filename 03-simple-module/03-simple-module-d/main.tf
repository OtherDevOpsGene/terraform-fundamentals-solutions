data "aws_availability_zones" "available" {
  state = "available"
}

module "www" {
  source = "./modules/webserver"

  for_each          = toset(data.aws_availability_zones.available.names)
  availability_zone = each.key
  instance_type     = "t4g.nano"

  tags = {
    Name   = "${var.server_name}-${each.key}"
    Owner  = var.owner_email
    Class  = var.class_name
    Lesson = "lesson-03"
  }
}

output "private_ips_list" {
  description = "Private IP addresses for the webserver instances."
  value       = values(module.www)[*].webserver_private_ip
}

output "private_ips" {
  description = "Private IP addresses by instance."
  value = {
    for az in keys(module.www) : az => module.www[az].webserver_private_ip
  }
}
