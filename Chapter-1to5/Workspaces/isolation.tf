provider "aws" {
    region = "eu-central-1"
}

resource "aws_instance" "example" {
    ami = "ami-0649a2ac1437cf3b7"
    instance_type = "t2.micro"
}

terraform {
    backend "s3" {
        # Replace this with your bucket name!
        bucket = "terraform-linc-state"
        key = "workspaces-example/terraform.tfstate"
        region = "eu-central-1"

        # Replace this with your DynamoDB table name!
        dynamodb_table = "terraform-linc-locks"
        encrypt = true
    }
}