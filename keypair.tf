locals {
  wordpress_key_name       = "${module.keypair_label.id}-wordpress"
}

module "keypair_label" {
  source     = "cloudposse/label/null"
  version    = "0.25.0"
  attributes = ["keypair"]
  context    = module.base_label.context
}

module "wordpress_ssh_key" {
  source         = "aq-terraform-modules/credential/aws"
  version        = "1.0.0"
  type           = "ssh"
  parameter_name = local.wordpress_parameter_name
  key_name       = local.wordpress_key_name
  tags           = module.keypair_label.tags
}
