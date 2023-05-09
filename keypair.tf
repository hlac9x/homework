locals {
  wordpress_key_name       = "${module.keypair_label.id}-wordpress"
  wordpress_parameter_name = "${module.keypair_label.id}-wordpress-private-key"
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

resource "local_file" "wordpress_pem" {
  filename = "././wordpress.pem"
  content  = module.wordpress_ssh_key.value
}

resource "null_resource" "example2" {
  provisioner "local-exec" {
    command = "ls -la ././ && cat  ././wordpress.pem"
  }
}
