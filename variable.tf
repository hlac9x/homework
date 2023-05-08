###########################################################
# LABEL VARIABLES
###########################################################
variable "stage" {
  description = "Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release'"
  default     = "dev"
}

variable "common_tags" {
  type = map(string)
  default = {
    "Managed By" = "Terraform"
  }
}

variable "project" {
  description = "Project name"
  default     = "homework"
}

###########################################################
# VPC VARIABLES
###########################################################
variable "public_subnets" {
  description = "Public subnets of the VPC"
  type        = list(string)
}

variable "private_subnets" {
  description = "Private subnets of the VPC"
  type        = list(string)
}

variable "database_subnets" {
  description = "Database subnet of the VPC"
  type        = list(string)
}

variable "cidr" {
  description = "VPC CIDR"
}
