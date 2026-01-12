
//-----------------------------------
// Locals
//-----------------------------------
locals {
  role_arn = "arn:aws:iam::${data.aws_caller_identity.this.account_id}:role/${var.role_name}"
}

//-----------------------------------
// S3 Bucket
//-----------------------------------
resource "aws_s3_bucket" "this" {
  bucket        = var.bucket
  force_destroy = var.force_destroy

  tags = {
    Name = var.bucket
  }
}

//-----------------------------------
// S3 Bucket Folder
//-----------------------------------
resource "aws_s3_object" "this" {
  bucket = aws_s3_bucket.this.id
  key    = "data/"
}

//-----------------------------------
// Bucket Encryption
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
// Bucket Public Access Block
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
// Bucket Versioning
//-----------------------------------
resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = "Disabled"
  }
}

//-----------------------------------
// Service Principal Caller Identity
//-----------------------------------
data "aws_caller_identity" "this" {}

//-----------------------------------
// Databricks Role Assumption Policy
//-----------------------------------
data "aws_iam_policy_document" "this" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["arn:aws:iam::414351767826:role/unity-catalog-prod-UCMasterRole-14S5ZJVKOTYTL"]
      type        = "AWS"
    }
    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = [var.databricks_account_id]
    }
  }

  statement {
    sid     = "ExplicitSelfRoleAssumption"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
    principals {
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.this.account_id}:root"]
      type        = "AWS"
    }
    condition {
      test     = "ArnLike"
      variable = "aws:PrincipalArn"
      values   = [local.role_arn]
    }
  }
}

//-----------------------------------
// Databricks S3 Access Policy
//-----------------------------------
resource "aws_iam_policy" "this" {
  name = var.policy_name
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "${var.role_name}"
    Statement = [
      {
        "Action" : [
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:PutObject",
          "s3:PutObjectAcl",
          "s3:DeleteObject",
          "s3:ListBucket",
          "s3:GetBucketLocation"
        ],
        "Resource" : [
          aws_s3_bucket.this.arn,
          "${aws_s3_bucket.this.arn}/*"
        ],
        "Effect" : "Allow"
      },
      {
        "Action" : [
          "sts:AssumeRole"
        ],
        "Resource" : [
          "${local.role_arn}"
        ],
        "Effect" : "Allow"
      },
    ]
  })
  tags = var.tags
}

//-----------------------------------
// Databricks IAM Role
//-----------------------------------
resource "aws_iam_role" "this" {
  depends_on = [aws_iam_policy.this]

  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.this.json
  tags               = var.tags
}

//-----------------------------------
// Databricks IAM Role Policy Attachment
//-----------------------------------
resource "aws_iam_role_policy_attachment" "this" {
  role       = var.role_name
  policy_arn = aws_iam_policy.this.arn
}

//-----------------------------------
// Sleep Timer
//-----------------------------------
resource "time_sleep" "this" {
  depends_on = [
    aws_iam_role.this,
    aws_iam_policy.this
  ]

  create_duration = "30s"
}

//-----------------------------------
// Databricks Storage Credential
//-----------------------------------
resource "databricks_storage_credential" "this" {
  depends_on = [time_sleep.this, aws_iam_role.this]

  name         = aws_iam_role.this.name
  metastore_id = var.metastore_id

  aws_iam_role {
    role_arn = aws_iam_role.this.arn
  }
}

//-----------------------------------
// Databricks External Location
//-----------------------------------
resource "databricks_external_location" "this" {
  depends_on = [aws_iam_role.this, databricks_storage_credential.this]

  name            = var.bucket
  url             = "s3://${var.bucket}/data"
  credential_name = databricks_storage_credential.this.id
}

//-----------------------------------
// Databricks Grants
//-----------------------------------
resource "databricks_grants" "this" {
  external_location = databricks_external_location.this.id

  grant {
    principal  = "account users"
    privileges = ["MANAGE", "CREATE_EXTERNAL_TABLE", "CREATE_MANAGED_STORAGE", "READ_FILES", "WRITE FILES"]
  }
}

