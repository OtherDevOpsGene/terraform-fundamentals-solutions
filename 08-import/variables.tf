variable "aws_region" {
  description = "AWS region to work in."
  type        = string
  default     = "us-east-2"

  validation {
    condition     = contains(["us-east-1", "us-east-2", "us-west-1", "us-west-2"], var.aws_region)
    error_message = "Only US regions are allowed."
  }
}
