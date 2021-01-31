terraform {
  # Require Terraform at exactly version 0.13.2
  required_version = "= 0.13.2"
}

provider "aws" {
  region = "eu-central-1"
}

module "alb" {
  source = "/home/lincwest/Terraform-Uprun/Chapter-6/modules/networking/alb"

  alb_name   = var.alb_name
  subnet_ids = data.aws_subnet_ids.default.ids
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}
