# --------------------------------------------------------------------
# Read VPC remote state from the shared VPC project
# --------------------------------------------------------------------
data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "tfstate-dev-ap-southeast-2-iv3jwo"     # S3 bucket storing the VPC remote state
    key    = "vpc/dev/terraform.tfstate"              # Remote state file path for the VPC module
    region = var.aws_region                             # Region where the backend resources are located
  }
}

# --------------------------------------------------------------------
# Expose the VPC ID from the remote VPC state
# --------------------------------------------------------------------
output "vpc_id" {
  value = data.terraform_remote_state.vpc.outputs.vpc_id
}

# --------------------------------------------------------------------
# Expose private subnet IDs from the VPC remote state
# --------------------------------------------------------------------
output "private_subnet_ids" {
  value = data.terraform_remote_state.vpc.outputs.private_subnet_ids
}

# --------------------------------------------------------------------
# Expose public subnet IDs from the VPC remote state
# --------------------------------------------------------------------
output "public_subnet_ids" {
  value = data.terraform_remote_state.vpc.outputs.public_subnet_ids
}

