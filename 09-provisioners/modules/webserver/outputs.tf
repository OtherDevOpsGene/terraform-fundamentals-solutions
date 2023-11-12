output "webserver_private_ip" {
  description = "Private IP address of the webserver instance."
  value       = aws_instance.webserver.private_ip
}

output "webserver_public_dns" {
  description = "Public DNS address of the webserver instance."
  value       = aws_instance.webserver.public_dns
}

output "webserver_az" {
  description = "The AWS AZ of the webserver instance."
  value       = aws_instance.webserver.availability_zone
}
