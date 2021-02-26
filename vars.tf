variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-2"
}

variable "s3_bucket_config" {
  type = map(object({
    cors_rule_inputs = list(object({
      allowed_headers = list(string)
      allowed_methods = list(string)
      allowed_origins = list(string)
      expose_headers  = list(string)
      max_age_seconds = number
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

variable "acl" {
  type        = string
  default     = "private"
  description = "The canned ACL to apply."
}

variable "block_public_acls" {
  type        = string
  default     = true
  description = "PUT Object calls will fail if the request includes an object ACL."
}

variable "block_public_policy" {
  type        = string
  default     = true
  description = "Reject calls to PUT Bucket policy if the specified bucket policy allows public access."
}

variable "restrict_public_buckets" {
  type        = string
  default     = true
  description = "Ignore public ACLs on this bucket and any objects that it contains."
}

variable "ignore_public_acls" {
  type        = string
  default     = true
  description = "Only the bucket owner and AWS Services can access this buckets if it has a public policy."
}

variable "lifecycle_rule_inputs" {
  type = list(object({
    enabled                                = string
    abort_incomplete_multipart_upload_days = string
    expiration_inputs = list(object({
      days = number
    }))
  }))
  default = null
}

variable "cors_rule_inputs" {
  type = list(object({
    allowed_headers = list(string)
    allowed_methods = list(string)
    allowed_origins = list(string)
    expose_headers  = list(string)
    max_age_seconds = number
  }))
  default = null
}