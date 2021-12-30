# AWS Transfer via Terraform

This repo contains two modules for deploying an AWS Transfer server and associated users. It has been created under the
expectation that you want to create a single Transfer server that can be reused across many apps, each with their own
set of users.

## Prerequisites

First, you need a decent understanding of how to use Terraform. 
[Hit the docs](https://www.terraform.io/intro/index.html) for that. Once you're good, import this module and pass the
appropriate variables. Then, plan your run and deploy.

## Example Usage

### Setting up the server

You like only want to do this once for all of your services. Since it will be backed by S3, you will have a lot of
freedom in how you control the data storage. See the [part about setting up](#setting-up-the-users) users for that.

```hcl
module "sftp_server" {
  source = "git@github.com:7Factor/terraform-aws-transfer//server"

  server_name        = "sftp-server"
  vpc_id             = var.vpc_id
  aws_region         = var.aws_region
  subnet_ids         = var.web_private_subnets
  security_group_ids = [var.web_security_group_id]
}
```

### Setting up the users

This part you will probably want to do per service. You can define as many or few (or 0) read only or read/write users
as you want. They can each have their own home directory or share one. However, home directories must start with the
name of the S3 bucket. You must provide the S3 bucket yourself.

```hcl
resource "aws_s3_bucket" "sftp_bucket" {
  bucket = "sftp_bucket"
}

module "sftp_users" {
  source = "git@github.com:7Factor/terraform-aws-transfer//users"

  transfer_server_id = var.transfer_server_id // This will come from the output of the server module
  s3_bucket_arn      = aws_s3_bucket.sftp_bucket.arn
  service_name       = "my-service"

  read_write_users = [
    {
      user_name      = "batman"
      ssh_public_key = "ssh-rsa AAAA..."
      home_directory = "/${aws_s3_bucket.sftp_bucket.id}/batcave"
    }
  ]

  read_only_users = [
    {
      user_name      = "robin"
      ssh_public_key = "ssh-rsa AAAA..."
      home_directory = "/${aws_s3_bucket.sftp_bucket.id}/batcave"
    }
  ]
}
```
