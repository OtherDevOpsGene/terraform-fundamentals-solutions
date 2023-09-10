variable "instance_type" {
  description = "The AWS EC2 instance type to create."
  type        = string
}

variable "tags" {
  description = "Tags to apply to the webserver."
  type        = map(any)
}

variable "availability_zone" {
  description = "Which availability zone to deploy the webserver to."
  type        = string
}
