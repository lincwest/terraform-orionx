terraform {
  backend "s3" {
    bucket         = "terraform-linc-state"
    key            = "stage/data-stores/mysql/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-linc-locks"
    encrypt        = true
  }
}

resource "aws_db_instance" "example" {
  identifier_prefix   = "terraform-linc"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  name                = var.db_name
  username            = "admin"
  password            = var.db_password
  
  skip_final_snapshot = true
}