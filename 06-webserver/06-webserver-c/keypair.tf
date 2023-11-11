module "keypair" {
  source  = "terraform-aws-modules/key-pair/aws"
  version = "2.0.2"

  key_name           = "otherdevopsgene-ssh"
  create_private_key = true
}
