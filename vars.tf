variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-2"
}

variable "s3_bucket_config" {
  type = map(object({
    acl                     = string
    block_public_acls       = bool
    block_public_policy     = bool
    restrict_public_buckets = bool
    ignore_public_acls      = bool
    cors_rule_inputs = list(object({
      allowed_headers = list(string)
      allowed_methods = list(string)
      allowed_origins = list(string)
      expose_headers  = list(string)
      max_age_seconds = number
    }))
    lifecycle_rule_inputs = list(object({
      enabled                                = string
      abort_incomplete_multipart_upload_days = string
      expiration_inputs = list(object({
        days = number
      }))
    }))
  }))
  default = null
}

variable "remote_principals_arns" {
  type        = list(string)
  description = "one or many arns for your remote principals"
}

variable "tags" {
  type        = map(string)
  default     = { "terraform" : "true" }
  description = "custom tags you want to provide for the resources created here"
}

variable "role_name" {
  type        = string
  description = "name to give your role that will be able to be assume by remote principal(s)"
}