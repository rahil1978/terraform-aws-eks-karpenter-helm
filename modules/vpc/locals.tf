# Locals Block
locals {
  customer_prefix     =  "${var.customer}-${var.environment_name}"
  azs             = slice(data.aws_availability_zones.available.names, 0, 3)
  public_subnets  = [for idx, az in local.azs : cidrsubnet(var.vpc_cidr, var.subnet_newbits, idx)]
  private_subnets = [for idx, az in local.azs : cidrsubnet(var.vpc_cidr, var.subnet_newbits, idx + 10)]
}