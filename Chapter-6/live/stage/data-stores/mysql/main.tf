terraform {
  # Require Terraform at exactly version 0.13.2
  required_version = "= 0.13.2"
}

provider "aws" {
  region = "eu-central-1"
}

terraform {
  backend "s3" {
    bucket         = "terraform-linc-state"
    key            = "home/lincwest/Terraform-Uprun/Chapter-6/live/prod/data-stores/mysql/.terraform/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-linc-state-locks"
    encrypt        = true
  }
}

module "mysql" {
  source = "/home/lincwest/Terraform-Uprun/Chapter-6/modules/data-stores/mysql"

  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password
}