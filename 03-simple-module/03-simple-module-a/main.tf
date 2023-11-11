module "www" {
  source = "./modules/webserver"

  count         = 2
  instance_type = "t4g.nano"

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
