output "private_ip" {
  description = "Private IP address for the webserver instance."
  value       = module.www.webserver_private_ip
}

output "public_dns" {
  description = "Public DNS address of the webserver instance."
  value       = module.www.webserver_public_dns
}

output "public_url" {
  description = "Public URL of the webserver instance."
  value       = "http://${module.www.webserver_public_dns}:8080"
}
