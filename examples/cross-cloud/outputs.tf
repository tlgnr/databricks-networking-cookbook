//-----------------------------------
// AWS RDS PostgreSQL Instances
//-----------------------------------
output "aws_rds_postgresql_instance_passwords" {
  value     = values(module.aws_rds_postgresql_instance)[*].password
  sensitive = true
}