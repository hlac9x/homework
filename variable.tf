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

###########################################################
# RDS VARIABLES
###########################################################
variable "mysql_version" {
  description = "Version of the mysql DB that will be created"
  default     = "8.0.32"
}

variable "mysql_family" {
  description = "The family of the DB parameter group"
  default     = "mysql8.0"
}

variable "mysql_major_engine_version" {
  description = "Specifies the major version of the engine that this option group should be associated with"
  default     = "8.0"
}

variable "instance_class" {
  description = "The instance type of the RDS instance"
  default     = "db.t3.small"
}

variable "allocated_storage" {
  description = "The allocated storage in gigabytes"
  default     = 30
}

variable "max_allocated_storage" {
  description = "Specifies the value for Storage Autoscaling"
  default     = 0
}

variable "storage_type" {
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'gp2' if not"
  default     = "gp2"
}

variable "username" {
  description = "Username for the master DB user"
  default     = "mysql_admin"
}

variable "multi_az" {
  description = "Enable multi az for RDS instance or not"
  type        = bool
  default     = true
}

variable "maintenance_window" {
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'"
  default     = "Sun:00:00-Sun:03:00"
}

variable "backup_window" {
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window"
  default     = "03:00-06:00"
}

variable "backup_retention_period" {
  description = "The days to retain backups for"
  default     = "7"
}

variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted"
  type        = bool
  default     = false
}

variable "deletion_protection" {
  description = "The database can't be deleted when this value is set to true"
  type        = bool
  default     = true
}

variable "storage_encrypted" {
  description = "Specifies whether the DB instance is encrypted"
  type        = bool
  default     = true
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "homework"
}

###########################################################
# AMI VARIABLES
###########################################################
variable "ami_owner" {
  description = "Owner of the AMI that need to be searched"
}

variable "ami_regex_value" {
  description = "Regex of the AMI name that need to be searched"
}

###########################################################
# EC2 wordpress VARIABLES
###########################################################
variable "wordpress_instance_type" {
  description = "Instance type of the wordpress VM"
  default     = "t3.small"
}

variable "enable_monitoring" {
  description = "Enable monitoring for wordpress or not"
  type        = bool
  default     = false
}
