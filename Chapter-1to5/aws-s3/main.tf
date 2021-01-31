provider "aws" {
    region = "eu-central-1"
}

resource "aws_s3_bucket" "terraform_state" {
    bucket = "terraform-linc-state"
    force_destroy = true

    versioning {
        enabled = true
    }

    # Enable server-side encyription by default
    server_side_encryption_configuration {
        rule {
            apply_server_side_encryption_by_default {
                sse_algorithm = "AES256"
            }
        }
    }
}

resource "aws_dynamodb_table" "terraform_locks" {
    name = "terraform-linc-state-locks"
    billing_mode = "PROVISIONED"
    read_capacity = 5
    write_capacity = 5
    hash_key = "LockID"

    attribute {
      name = "LockID"
      type = "S"
    }
}

output "s3_bucket_arn" {
    value = aws_s3_bucket.terraform_state.arn
    description = "The ARN of the S3 bucket"
}

output "dynamodb_table_name" {
    value = aws_dynamodb_table.terraform_locks.name
    description = "The name of the DynamoDB table"
}