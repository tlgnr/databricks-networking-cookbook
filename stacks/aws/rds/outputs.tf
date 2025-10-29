//-----------------------------------
// AWS RDS Instances
//-----------------------------------
output "aws_rds_instances" {
  value     = module.aws_rds_instance
  sensitive = true
}

output "aws_rds_instance_fqdns" {
  value     = module.aws_rds_instance
  sensitive = true
}

output "aws_rds_instance_passwords" {
  value     = module.aws_rds_instance
  sensitive = true
}