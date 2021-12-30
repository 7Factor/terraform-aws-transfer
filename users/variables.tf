variable "transfer_server_id" {
  description = "The id of the Transfer server"
  type        = string
}

variable "s3_bucket_arn" {
  description = "ARN of the service-provided S3 bucket to be used by the Transfer server"
  type        = string
}
variable "service_name" {
  description = "Name of the service using the Transfer server to be used as a prefix for IAM resource names"
  type        = string
}

variable "read_write_users" {
  description = "User details for read-write Transfer users. Home directory should start with the S3 bucket name"
  type = list(object({
    user_name      = string
    ssh_public_key = string
    home_directory = string
  }))
  default = []
}

variable "read_only_users" {
  description = "User details for read-only Transfer users. Home directory should start with the S3 bucket name"
  type = list(object({
    user_name      = string
    ssh_public_key = string
    home_directory = string
  }))
  default = []
}
