module "tfstate-backend" {
  source  = "cloudposse/tfstate-backend/aws"
  version = "1.1.1"

  namespace = var.initials
  name      = var.name
}

output "terraform_backend_config" {
  value = module.tfstate-backend.terraform_backend_config
}
