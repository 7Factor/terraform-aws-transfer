data "aws_iam_policy_document" "transfer_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["transfer.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "s3_read_write" {
  Statement = {
    effect    = "Allow"
    actions   = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:DeleteObjectVersion",
      "s3:GetObjectVersion",
      "s3:ListBucket",
      "s3:GetBucketLocation"
    ]
    resources = [
      var.s3_bucket_arn,
      "${var.s3_bucket_arn}/*"
    ]
  }
}

data "aws_iam_policy_document" "s3_read_only" {
  Statement = {
    effect    = "Allow"
    actions   = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:ListBucket",
      "s3:GetBucketLocation"
    ]
    resources = [
      var.s3_bucket_arn,
      "${var.s3_bucket_arn}/*"
    ]
  }
}

resource "aws_iam_role" "s3_read_write_role" {
  count              = var.read_write_users ? 1 : 0
  name               = "${var.service_name}_transfer-s3-read-write-role"
  assume_role_policy = data.aws_iam_policy_document.transfer_assume_role.json
}

resource "aws_iam_role_policy" "transfer_s3_read_write_policy" {
  count  = var.read_write_users ? 1 : 0
  name   = "${var.service_name}_transfer-s3-read-write-policy"
  policy = data.aws_iam_policy_document.s3_read_write.json
  role   = aws_iam_role.s3_read_write_role.name
}

resource "aws_iam_role" "s3_read_only_role" {
  count              = var.read_only_users ? 1 : 0
  name               = "${var.service_name}_transfer-s3-read-only-role"
  assume_role_policy = data.aws_iam_policy_document.transfer_assume_role.json
}

resource "aws_iam_role_policy" "transfer_s3_read_only_policy" {
  count  = var.read_only_users ? 1 : 0
  name   = "${var.service_name}_transfer-s3-read-only-policy"
  policy = data.aws_iam_policy_document.s3_read_only.json
  role   = aws_iam_role.s3_read_only_role.name
}