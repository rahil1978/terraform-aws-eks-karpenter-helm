# Terraform Block
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
  
  #Remote back 
  backend "s3" {
      bucket = "tfstate-dev-ap-southeast-2-iv3jwo"
      key = "vpc/dev/terraform.tfstate"
      region = "ap-southeast-2"
      encrypt = true
      use_lockfile = true
 }
}

# Provider Block
provider "aws" {
  region = var.aws_region
  profile = "training"
}



