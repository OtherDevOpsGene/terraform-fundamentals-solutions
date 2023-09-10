output "webserver_private_ip" {
  description = "Private IP address of the webserver instance."
  value       = aws_instance.webserver.public_ip
}

output "webserver_az" {
  description = "The AWS AZ of the webserver instance."
  value       = aws_instance.webserver.availability_zone
}
