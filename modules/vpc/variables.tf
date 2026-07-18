# Customer-specific metadata used in resource names and tags
variable "customer" {
  description = "Customer name used in resource names and tags"
  type        = string
  default     = "folio"
}

# Environment label used in resource names and tags
variable "environment_name" {
  description = "Environment name used in resource names and tags"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# Common tags applied to all VPC resources
variable "tags" {
  description = "Global tags to apply to all resources"
  type        = map(string)
  default     = {
    Terraform = "true"
  }
}

variable "subnet_newbits" {
  description = "Number of additional mask bits used to generate subnets from the VPC CIDR"
  type        = number
  default     = 8
}

