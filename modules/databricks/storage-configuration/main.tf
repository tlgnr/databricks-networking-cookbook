//-----------------------------------
// Root Bucket
//-----------------------------------
resource "aws_s3_bucket" "this" {
  bucket        = var.bucket
  force_destroy = var.force_destroy

  tags = {
    Name = var.bucket
  }
}

//-----------------------------------
// Root Bucket Encryption
//-----------------------------------
resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

//-----------------------------------
// Root Bucket Public Access Block
//-----------------------------------
resource "aws_s3_bucket_public_access_block" "this" {
  depends_on = [aws_s3_bucket.this]

  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

//-----------------------------------
// Root Bucket Versioning
//-----------------------------------
resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = "Disabled"
  }
}

//-----------------------------------
// Root Bucket Access Policy
//-----------------------------------
data "databricks_aws_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.bucket
}

//-----------------------------------
// Root Bucket Access Policy Binding
//-----------------------------------
resource "aws_s3_bucket_policy" "this" {
  depends_on = [aws_s3_bucket_public_access_block.this]

  bucket = aws_s3_bucket.this.id
  policy = data.databricks_aws_bucket_policy.this.json
}

//-----------------------------------
// Databricks Storage Configuration
//-----------------------------------
resource "databricks_mws_storage_configurations" "this" {
  account_id                 = var.account_id
  bucket_name                = aws_s3_bucket.this.bucket
  storage_configuration_name = var.storage_configuration_name
}
