//-----------------------------------
// AWS RDS Subnet Groups
//-----------------------------------
module "aws_rds_subnet_group" {
  source = "../../../../../../modules/aws/subnet-group"

  for_each = var.aws_subnet_groups

  name       = each.value.name
  subnet_ids = [for subnet_name in each.value.subnet_names : var.aws_subnet_ids[subnet_name].id]
}

//-----------------------------------
// AWS RDS PostgreSQL Instances
//-----------------------------------
module "aws_rds_postgresql_instance" {
  source = "../../../../../../modules/aws/rds-instance"

  for_each = var.aws_rds_postgresql_instances

  allocated_storage                   = each.value.allocated_storage
  apply_immediately                   = each.value.apply_immediately
  copy_tags_to_snapshot               = each.value.copy_tags_to_snapshot
  engine                              = each.value.engine
  engine_version                      = each.value.engine_version
  iam_database_authentication_enabled = each.value.iam_database_authentication_enabled
  identifier                          = each.value.identifier
  instance_class                      = each.value.instance_class
  max_allocated_storage               = each.value.max_allocated_storage
  parameter_group_name                = each.value.parameter_group_name
  skip_final_snapshot                 = each.value.skip_final_snapshot
  storage_encrypted                   = each.value.storage_encrypted
  subnet_group_name                   = each.value.subnet_group_name
  username                            = each.value.username
  vpc_security_group_ids              = [for security_group_name in each.value.vpc_security_group_names : var.aws_security_group_ids[security_group_name].id]
}