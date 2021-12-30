output "transfer_server" {
  description = "The details of the Transfer server"
  value = object({
    arn      = aws_transfer_server.transfer_server.arn
    id       = aws_transfer_server.transfer_server.id
    endpoint = aws_transfer_server.transfer_server.endpoint
  })
}
