terraform {
  # Require Terraform at exactly version 0.13.2
  required_version = "= 0.13.2"
}

provider "aws" {
  region = "eu-central-1"
}

module "asg" {
  source = "/home/lincwest/Terraform-Uprun/Chapter-6/modules/cluster/asg-rolling-deploy"

  cluster_name  = var.cluster_name

  ami           = "ami-0a6dc7529cd559185"
  instance_type = "t2.micro"

  min_size           = 1
  max_size           = 1
  enable_autoscaling = false

  subnet_ids         = data.aws_subnet_ids.default.ids
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}