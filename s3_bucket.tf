# Give an s3 bucket to each bucket name passed to the module
resource "aws_s3_bucket" "s3_buckets" {
  for_each = var.s3_bucket_names

  bucket = each.value
  acl    = var.acl
  tags   = var.tags

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rule_inputs == null ? [] : var.lifecycle_rule_inputs

    content {
      enabled                                = lifecycle_rule.value.enabled
      abort_incomplete_multipart_upload_days = lifecycle_rule.value.abort_incomplete_multipart_upload_days

      dynamic "expiration" {
        for_each = lifecycle_rule.value.expiration_inputs == [] ? null : lifecycle_rule.value.expiration_inputs

        content {
          days = expiration.value.days
        }
      }
    }
  }

  dynamic "cors_rule" {
    for_each = var.cors_rule_inputs == null ? [] : var.cors_rule_inputs

    content {
      allowed_headers = cors_rule.value.allowed_headers
      allowed_methods = cors_rule.value.allowed_methods
      allowed_origins = cors_rule.value.allowed_origins
      expose_headers  = cors_rule.value.expose_headers
      max_age_seconds = cors_rule.value.max_age_seconds
    }
  }
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
