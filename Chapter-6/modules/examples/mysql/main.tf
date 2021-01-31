terraform {
  # Require Terraform at exactly version 0.13.2
  required_version = "= 0.13.2"
}

provider "aws" {
  region = "eu-central-1"
}

module "mysql" {
  source = "/home/lincwest/Terraform-Uprun/Chapter-6/modules/data-stores/mysql"

  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password
}