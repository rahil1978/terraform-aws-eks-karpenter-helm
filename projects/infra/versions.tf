# Terraform configuration settings
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 6.0"
    }
    /*
    random = {
      source = "hashicorp/random"
      version = "~> 3.0"
    } 
    */
  }
  
  # Remote state backend configuration using S3
  backend "s3" {}  

}

# AWS provider configuration
provider "aws" {
  region = var.aws_region
  profile = "training"
}



