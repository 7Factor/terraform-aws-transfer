data "aws_iam_policy_document" "transfer_assume_role" {
  statement {
    sid     = "TransferAssumeRole"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["transfer.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "transfer_server_role" {
  name               = "transfer-server-role"
  assume_role_policy = data.aws_iam_policy_document.transfer_assume_role.json
}

data "aws_iam_policy" "transfer_server_logging" {
  name = "AWSTransferLoggingAccess"
}

resource "aws_iam_role_policy_attachment" "transfer_server_logging_policy_attachment" {
  role = aws_iam_role.transfer_server_role.name
  policy_arn = data.aws_iam_policy.transfer_server_logging.arn
}
