# Resouruce Block: Random String
resource "random_string" "suffix" {
  length = 6
  special = false
  upper = false
}

# Resource Block: AWS S3 Bucket
resource "aws_s3_bucket" "devops_training_bucket" {
  bucket = "ds-${var.customer_prefix}-${random_string.suffix.result}"

  tags = {
    Name        = "DevOps-Training-Bucket"
    Environment = "Dev"
    Owner = "Raheel Aslam"
    Organization = "DataStack"
    localization = true
  }
} 