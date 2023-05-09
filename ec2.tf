module "wordpress_label" {
  source     = "cloudposse/label/null"
  version    = "0.25.0"
  attributes = ["wordpress"]
  context    = module.base_label.context
}

data "template_file" "user_data" {
  template = file("./scripts/cloudinit.yaml")
  vars = {
    WORDPRESS_DB_HOST = "${module.mysql.db_instance_endpoint}",
    WORDPRESS_DB_USER = "${var.username}",
    WORDPRESS_DB_PASSWORD = "${module.mysql_password.value}",
    WORDPRESS_DB_NAME = "${var.db_name}"
  }
}

data "aws_ami" "ec2_ami_regex" {
  owners      = [var.ami_owner]
  most_recent = true

  filter {
    name   = "name"
    values = [var.ami_regex_value]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

module "wordpress" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.0.0"
  create  = true

  name                        = module.wordpress_label.id
  ami                         = data.aws_ami.ec2_ami_regex.id
  instance_type               = var.wordpress_instance_type
  key_name                    = local.wordpress_key_name
  monitoring                  = var.enable_monitoring
  vpc_security_group_ids      = [module.sg_wordpress.security_group_id]
  subnet_id                   = module.base_network.public_subnets[0]
  associate_public_ip_address = true
  # user_data                   = data.template_file.user_data.rendered
  tags                        = module.wordpress_label.tags
}

resource "aws_eip" "wordpress" {
  vpc      = true
  instance = module.wordpress.id
  tags     = module.wordpress_label.tags
}