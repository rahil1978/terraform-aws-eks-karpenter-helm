# Output Block
output "s3_bucket_name" {
  value = aws_s3_bucket.devops_training_bucket.bucket
}

output "s3_bucket_id" {
  value = aws_s3_bucket.devops_training_bucket.id
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.devops_training_bucket.arn
  description = "S3 Bucket ARN"
}