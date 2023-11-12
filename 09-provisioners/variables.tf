variable "owner_email" {
  description = "The email address of the person responsible for the resources."
  type        = string
}

variable "class_name" {
  description = "The name of the class this was created for."
  type        = string
  default     = "Terraform Fundamentals"
}

variable "server_name" {
  description = "Base name for the webserver instances."
  type        = string
}

variable "security_group" {
  description = "Name of the security group to assign to the webserver."
  type        = string
}

variable "aws_region" {
  description = "AWS region to work in."
  type        = string
  default     = "us-east-2"

  validation {
    condition     = contains(["us-east-1", "us-east-2", "us-west-1", "us-west-2"], var.aws_region)
    error_message = "Only US regions are allowed."
  }
}
