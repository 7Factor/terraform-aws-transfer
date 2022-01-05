resource "aws_transfer_user" "transfer_server_read_write_user" {
  count          = length(var.read_write_users)
  server_id      = var.transfer_server_id
  user_name      = element(var.read_write_users.*.user_name, count.index)
  role           = aws_iam_role.s3_read_write_role[0].arn
  home_directory = "/${element(var.read_write_users.*.home_directory, count.index)}"
}

resource "aws_transfer_user" "transfer_server_read_only_user" {
  count          = length(var.read_only_users)
  server_id      = var.transfer_server_id
  user_name      = element(var.read_only_users.*.user_name, count.index)
  role           = aws_iam_role.s3_read_only_role[0].arn
  home_directory = "/${element(var.read_only_users.*.home_directory, count.index)}"
}

resource "aws_transfer_ssh_key" "transfer_server_read_write_user_ssh_key" {
  count     = length(var.read_write_users)
  server_id = var.transfer_server_id
  user_name = element(var.read_write_users.*.user_name, count.index)
  body      = element(var.read_write_users.*.ssh_public_key, count.index)
}

resource "aws_transfer_ssh_key" "transfer_server_read_only_user_ssh_key" {
  count     = length(var.read_only_users)
  server_id = var.transfer_server_id
  user_name = element(var.read_only_users.*.user_name, count.index)
  body      = element(var.read_only_users.*.ssh_public_key, count.index)
}
