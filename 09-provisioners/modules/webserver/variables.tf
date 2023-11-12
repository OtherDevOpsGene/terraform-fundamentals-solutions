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

variable "user_data" {
  description = "Contents of the user-data to pass to the webserver."
  type        = string
  default     = ""
}

variable "document_root" {
  description = "Directory to use as the document root of the webserver."
  type        = string
}

variable "index_html" {
  description = "Contents of the index.html to install to the webserver."
  type        = string
  default     = ""
}

variable "key_name" {
  description = "Name of the key pair to associate with the instance."
  type        = string
}

variable "private_key" {
  description = "Private SSH key to use for provisioner connection."
  type        = string
}

variable "security_group" {
  description = "Security Group ID to associate with this instance."
  type        = string
}
