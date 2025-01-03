output "bucket_arn" {
  value       = aws_s3_bucket.bucket.arn
  description = "The ARN of the bucket"
}

output "bucket_name" {
  value       = aws_s3_bucket.bucket.id
  description = "The name of the bucket"
}
