variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-2"
}

variable "s3_bucket_names" {
  type        = set(string)
  description = "one or many of your s3 bucket name(s)"
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