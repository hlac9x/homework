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
