variable "owner_email" {
  description = "The email address of the person responsible for the resources."
  type        = string
}

variable "class_name" {
  description = "The name of the class this was created for."
  type        = string
  default     = "Terraform Fundamentals"
}
