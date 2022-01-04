resource "aws_transfer_server" "transfer_server" {
  endpoint_type = "VPC"

  endpoint_details {
    vpc_id             = var.vpc_id
    subnet_ids         = var.subnet_ids
    security_group_ids = var.security_group_ids
  }

  tags = {
    Name = var.server_name
  }
}
