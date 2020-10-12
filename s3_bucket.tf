# Give an s3 bucket to each bucket name passed to the module
resource "aws_s3_bucket" "s3_buckets" {
  for_each = var.s3_bucket_names

  bucket = each.value
  acl    = var.acl
  tags   = var.tags

  # dynamic "lifecycle_expiration" {
  #   for_each = var.lifecycle_rule_set
  #   lifecycle_rule {
  #     enabled = true
  #     expiration {
  #       days = var.lifecycle_rule_days
  #     }
  #   }
  # }

  lifecycle_rule = var.lifecycle_rule
}

# Make sure no object could ever be public
resource "aws_s3_bucket_public_access_block" "s3_buckets" {
  for_each = var.s3_bucket_names

  bucket = each.value

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  restrict_public_buckets = var.restrict_public_buckets
  ignore_public_acls      = var.ignore_public_acls

  depends_on = [aws_s3_bucket.s3_buckets]
}
