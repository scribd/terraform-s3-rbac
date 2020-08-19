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
