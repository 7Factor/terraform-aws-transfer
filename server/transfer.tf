resource "aws_transfer_server" "transfer_server" {
  endpoint_type = "VPC_ENDPOINT"

  endpoint_details {
    vpc_endpoint_id = aws_vpc_endpoint.transfer_server_vpc_endpoint.id
  }

  tags = {
    Name = var.server_name
  }
}
