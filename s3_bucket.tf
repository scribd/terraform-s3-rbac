# Give an s3 bucket to each bucket name passed to the module
resource "aws_s3_bucket" "s3_buckets" {
  for_each = var.s3_bucket_config

  bucket = each.key
  acl    = lookup(each.value, "acl", "private")
  tags   = var.tags

  dynamic "lifecycle_rule" {
    for_each = lookup(each.value, "lifecycle_rule_inputs", [])

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
    for_each = lookup(each.value, "cors_rule_inputs", [])

    content {
      allowed_headers = cors_rule.value.allowed_headers
      allowed_methods = cors_rule.value.allowed_methods
      allowed_origins = cors_rule.value.allowed_origins
      expose_headers  = cors_rule.value.expose_headers
      max_age_seconds = cors_rule.value.max_age_seconds
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

# Make sure no object could ever be public
resource "aws_s3_bucket_public_access_block" "s3_buckets" {
  for_each = var.s3_bucket_config

  bucket = each.key

  block_public_acls       = lookup(each.value, "block_public_acls", true)
  block_public_policy     = lookup(each.value, "block_public_policy", true)
  restrict_public_buckets = lookup(each.value, "restrict_public_buckets", true)
  ignore_public_acls      = lookup(each.value, "ignore_public_acls", true)

  depends_on = [aws_s3_bucket.s3_buckets]
}
