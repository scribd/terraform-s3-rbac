# terraform-s3-rbac

## Purpose

Terraform module to allow users to easily create buckets in their own account that gives another account's principal(s) full read/write access to their buckets.

## Usage

```terraform
module "s3_rbac" {
  source = "https://github.com:scribd/terraform-s3-rbac.git"

  role_name              = "remote_s3_rbac"
  s3_bucket_names        = ["somename-00", "somename-01", "somename-nn"]
  remote_principals_arns = ["arn:aws:iam::1234567890:user/someuser", "arn:aws:iam::1234567890:role/somerole"]
  
  tags = {"key": "value"}
}
```
