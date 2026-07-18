# Data source to retrieve available AWS Availability Zones
# This is used to place subnets across AZs for the VPC

data "aws_availability_zones" "available" {
  state = "available"
}
