//-----------------------------------
// Trust Relationship Policy
//-----------------------------------
data "databricks_aws_assume_role_policy" "this" {
  provider    = databricks
  external_id = var.databricks_account_id
}

//-----------------------------------
// Cross Account Policy
//-----------------------------------
data "databricks_aws_crossaccount_policy" "this" {
  provider    = databricks
  policy_type = "customer"
}

//-----------------------------------
// Databricks Role
//-----------------------------------
resource "aws_iam_role" "this" {
  name               = "role-databricks-cross-account-${var.region}"
  assume_role_policy = data.databricks_aws_assume_role_policy.this.json
  tags               = var.tags
}

//-----------------------------------
// Databricks Role Policy Assignment
//-----------------------------------
resource "aws_iam_role_policy" "this" {
  name   = "policy-databricks-cross-account-${var.region}"
  role   = aws_iam_role.this.id
  policy = data.databricks_aws_crossaccount_policy.this.json
}

//-----------------------------------
// Databricks Credential Configuration
//-----------------------------------
resource "databricks_mws_credentials" "this" {
  provider = databricks

  depends_on = [aws_iam_role.this, aws_iam_role_policy.this]

  role_arn         = aws_iam_role.this.arn
  credentials_name = var.credential_name
}