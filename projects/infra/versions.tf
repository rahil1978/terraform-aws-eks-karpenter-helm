# Terraform configuration settings
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 6.0"
    }
    random = {
      source = "hashicorp/random"
      version = "~> 3.0"
    } 
  }
  
  # Remote backend configuration
  backend "s3" {
      bucket = "tfstate-dev-ap-southeast-2-iv3jwo"
      key = "vpc/dev/terraform.tfstate"
      region = "ap-southeast-2"
      encrypt = true
      use_lockfile = true
 }
}

# AWS provider configuration
provider "aws" {
  region = var.aws_region
  profile = "training"
}



