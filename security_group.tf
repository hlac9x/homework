module "sg_label" {
  source     = "cloudposse/label/null"
  version    = "0.25.0"
  attributes = ["sg"]
  context    = module.base_label.context
}

module "sg_database" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.17.2"

  name        = "${module.sg_label.id}-database"
  description = "Security group for Database"
  vpc_id      = module.base_network.vpc_id

  ingress_with_source_security_group_id = [
    {
      from_port                = 3306
      to_port                  = 3306
      protocol                 = "tcp"
      description              = "Allow 3306 only from EC2"
      source_security_group_id = module.sg_wordpress.security_group_id
    }
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "Allow all to VPC CIDR"
      cidr_blocks = module.base_network.vpc_cidr_block
    }
  ]

  tags = module.sg_label.tags
}

module "sg_wordpress" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.17.2"

  name        = "${module.sg_label.id}-wordpress"
  description = "Security group for wordpress"
  vpc_id      = module.base_network.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "Allow SSH from Internet"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "Allow traffic from Local"
      cidr_blocks = module.base_network.vpc_cidr_block
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "Allow HTTPS from Internet"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "-1"
      description = "Allow HTTP from Internet"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "Allow Output to All"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  tags = module.sg_label.tags
}
