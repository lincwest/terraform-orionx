provider "aws" {
    region = "eu-central-1"
}

resource "aws_db_instance" "example" {
    identifier_prefix = "terraform-linc"
    engine            = "mysql"
    allocated_storage = 10
    instance_class    = "db.t2.micro"
    name              = "example_database"
    username          = "admin"
    password          = data.aws_secretsmanager_secret_version.db_password_stage.secret_string

    skip_final_snapshot = true
}

resource "aws_secretsmanager_secret" "db_password_stage" {
  name = "db_password_stage"
}

resource "aws_secretsmanager_secret_version" "db_password_stage" {
  secret_id     = aws_secretsmanager_secret.db_password_stage.id
  secret_string = random_password.db_password_stage.result
}

resource "random_password" "db_password_stage" {
  length      = 20
  special     = false
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
}

data "aws_secretsmanager_secret_version" "db_password_stage" {
  secret_id = aws_secretsmanager_secret.db_password_stage.id
}

terraform { 
    backend "s3" {
        # Replace this with your bucket name!
        bucket         = "terraform-linc-state"
        key            = "stage/data-stores/mysql/terraform.tfstate"
        region         = "eu-central-1"

        # Replace this with your DynamoDB table name!
        dynamodb_table = "terraform-linc-state-locks"
        encrypt        = true
    }
}