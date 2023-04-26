# create S3 bucket
resource "aws_s3_bucket" "bucket-eabrahym" {
  bucket        = "bucket-eabrahym"
  force_destroy = true
  tags = {
    Name        = "lock bucket"
    Environment = "State lock"
  }
}
# Enabling Bucket versioning
resource "aws_s3_bucket_versioning" "versioning_s3_bucket" {
  bucket = aws_s3_bucket.bucket-eabrahym.id
  versioning_configuration {
    status = "Enabled"
  }
}

# server-side configuration
resource "aws_s3_bucket_server_side_encryption_configuration" "server_bucket_encryption" {
  bucket = aws_s3_bucket.bucket-eabrahym.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
# create a DynamoDB in AWS 
resource "aws_dynamodb_table" "state-lock-table1789s" {
  name           = "State-lock1789s"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"


  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "dynamodb-table-For-state-lock"
    Environment = "production"
  }
}
