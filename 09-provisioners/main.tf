locals {
  instance_type = "t4g.nano"
}

module "ssh_key_pair" {
  source  = "terraform-aws-modules/key-pair/aws"
  version = "2.0.2"

  key_name           = "${var.server_name}-ssh"
  create_private_key = true

  tags = {
    Owner  = var.owner_email
    Class  = var.class_name
    Server = var.server_name
  }
}

data "aws_security_group" "allow_http_ssh" {
  name = var.security_group
}

module "www" {
  source = "./modules/webserver"

  availability_zone = "us-east-2a"
  instance_type     = local.instance_type
  user_data         = file("${path.root}/user-data.sh")
  document_root     = "/home/ubuntu"
  key_name          = module.ssh_key_pair.key_pair_name
  private_key       = module.ssh_key_pair.private_key_pem
  security_group    = data.aws_security_group.allow_http_ssh.id

  index_html = templatefile("${path.root}/index.html.tftpl",
    {
      class         = var.class_name
      name          = var.server_name
      owner         = var.owner_email
      instance_type = local.instance_type
      created_time  = formatdate("EEEE, MMMM D, YYYY, 'at' H:mm AA", timestamp())
    }
  )

  tags = {
    Name  = var.server_name
    Owner = var.owner_email
    Class = var.class_name
  }
}
