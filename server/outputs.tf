output "transfer_server" {
  description = "The details of the Transfer server"
  value = {
    arn      = aws_transfer_server.transfer_server.arn
    id       = aws_transfer_server.transfer_server.id
    endpoint = aws_transfer_server.transfer_server.endpoint
  }
}

output "transfer_server_vpc_endpoint" {
  description = "The details of the associated VPC endpoint"
  value = {
    id        = data.aws_vpc_endpoint.transfer_endpoint.id
    dns_entry = data.aws_vpc_endpoint.transfer_endpoint.dns_entry
  }
}
