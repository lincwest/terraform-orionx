terraform {
  # Require Terraform at exactly version 0.13.2
  required_version = "= 0.13.2"
}

provider "aws" {
  region = "eu-central-1"
}

resource "aws_db_instance" "example" {
  identifier_prefix   = "terraform-linc-db"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  name                = var.db_name
  username            = var.db_username
  password            = var.db_password
  skip_final_snapshot = true
}