data "aws_vpc_endpoint" "transfer_endpoint" {
  id = aws_transfer_server.transfer_server.endpoint_details[0].vpc_endpoint_id
}
