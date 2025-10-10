//-----------------------------------
// Random Password
//-----------------------------------
resource "random_password" "this" {
  length  = 16
  special = false
}

//-----------------------------------
// RDS Instance
//-----------------------------------
resource "aws_db_instance" "this" {
  allocated_storage                   = var.allocated_storage
  apply_immediately                   = var.apply_immediately
  copy_tags_to_snapshot               = var.copy_tags_to_snapshot
  db_subnet_group_name                = var.subnet_group_name
  engine                              = var.engine
  engine_version                      = var.engine_version
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  identifier                          = var.identifier
  instance_class                      = var.instance_class
  max_allocated_storage               = var.max_allocated_storage
  parameter_group_name                = var.parameter_group_name
  password                            = random_password.this.result
  skip_final_snapshot                 = var.skip_final_snapshot
  storage_encrypted                   = var.storage_encrypted
  username                            = var.username
  vpc_security_group_ids              = var.vpc_security_group_ids

  tags = {
    Name = var.identifier
  }
}
