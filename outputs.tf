output "iam_role_arn" {
  description = "IAM role arn created to be assumed by remote principal(s)"
  value       = aws_iam_role.s3_rbac.arn
}

output "s3_bucket_arns" {
  description = "Your S3 bucket ARNS"
  value       = [for v in aws_s3_bucket.s3_buckets : v.arn]
}
