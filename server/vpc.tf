data "aws_region" "current" {}

resource "aws_vpc_endpoint" "transfer_server_vpc_endpoint" {
  vpc_id             = var.vpc_id
  service_name       = "com.amazonaws.${data.aws_region.current.name}.transfer.server"
  vpc_endpoint_type  = "Interface"
  subnet_ids         = var.subnet_ids
  security_group_ids = var.security_group_ids
}
