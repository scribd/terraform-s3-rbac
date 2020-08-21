# terraform-s3-rbac

## Description

This Terraform module allow users to easily create buckets in their own account and then give access to said buckets via AWS IAM principals.

Principals are defined in the AWS docs here: [https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_principal.html](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_principal.html)

#### NOTE

Currently only `AWS` principals are supported this includes:
* IAM Users
* IAM Roles
* AWS Accounts
* Assumed-Role Sessions

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

## Contribution

If you wish to contribute please do the following:

* First create an issue for a new feature, where Scribd will look to review if it is within the scope of this project
* Ensure your work abides by terraform best practices
* Choose simplicity over saving a few lines
* `terraform fmt` and `terraform validate` before opening a PR
