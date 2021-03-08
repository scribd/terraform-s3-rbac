resource "aws_iam_role" "s3_rbac" {
  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.s3_bucket_access_role.json

  tags = var.tags
}

data "aws_iam_policy_document" "s3_bucket_access_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    sid     = "terraform0"
    principals {
      type        = "AWS"
      identifiers = [for a in var.remote_principals_arns : "${a}"]
    }
  }
}

data "aws_iam_policy_document" "s3_bucket_access" {
  statement {
    resources = [for s in keys(var.s3_bucket_config) : "arn:aws:s3:::${s}"]
    effect    = "Allow"
    actions   = ["s3:*"]
    sid       = "terraform0"
  }

  statement {
    resources = [for s in keys(var.s3_bucket_config) : "arn:aws:s3:::${s}/*"]
    effect    = "Allow"
    actions   = ["s3:*"]
    sid       = "terraform1"
  }
}

resource "aws_iam_policy" "s3_bucket_access" {
  name   = "s3_bucket_access"
  path   = "/"
  policy = data.aws_iam_policy_document.s3_bucket_access.json
}

resource "aws_iam_role_policy_attachment" "s3_bucket_access" {
  role       = aws_iam_role.s3_rbac.name
  policy_arn = aws_iam_policy.s3_bucket_access.arn
}
