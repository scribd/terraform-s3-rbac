# Give an s3 bucket to each bucket name passed to the module
resource "aws_s3_bucket" "s3_buckets" {
  for_each = var.s3_bucket_names

  bucket = each.value
  acl    = "private"
  tags   = var.tags
}

# Make sure no object could ever be public
resource "aws_s3_bucket_public_access_block" "s3_buckets" {
  for_each = var.s3_bucket_names

  bucket = each.value

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true

  depends_on = [aws_s3_bucket.s3_buckets]
}
