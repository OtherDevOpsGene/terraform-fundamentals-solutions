module "www" {
  source = "./webserver"

  count         = 2
  instance_type = "t4g.nano"

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
