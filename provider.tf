terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.63.0"
    }
    tls = {
      version = "~> 4.0.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  # Make it faster by skipping something
  skip_get_ec2_platforms      = true
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true

  # skip_requesting_account_id should be disabled to generate valid ARN in apigatewayv2_api_execution_arn
  skip_requesting_account_id = false

  # shared_credentials_files = ["/Users/tuananh.quach/.aws/credentials"]
  # profile                  = var.aws_profile
}

# Get current AWS account id to add to Kubernetes Addons
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}