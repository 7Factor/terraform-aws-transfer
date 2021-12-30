variable "server_name" {
  description = "The name of the Transfer server"
  type        = string
  default     = "sftp-server"
}

variable "vpc_id" {
  description = "The id of the vpc for the endpoint for the Transfer server"
  type        = string
}

variable "subnet_ids" {
  description = "The ids of the subnets for the Transfer server's vpc endpoint"
  type = list(string)
}

variable "security_group_ids" {
  description = "The ids of the security groups for the Transfer server's vpc endpoint"
  type = list(string)
}
