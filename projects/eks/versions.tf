terraform {
  # Minimum Terraform CLI version required by this module
  required_version = ">= 1.12.0"

  # Provider configuration and version constraints
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0"
    }
  }

  # Remote state backend configuration using S3
  backend "s3" {
    bucket         = "tfstate-dev-ap-southeast-2-iv3jwo"         
    key            = "eks/dev/terraform.tfstate"            
    region         = "ap-southeast-2"                            
    encrypt        = true                                   
    use_lockfile   = true      
  }
}

provider "aws" {
  # AWS region to use for all resources (from variables)
  region = var.aws_region
}