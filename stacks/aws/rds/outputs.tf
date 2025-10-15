//-----------------------------------
// AWS RDS Instances
//-----------------------------------
output "aws_rds_instances" {
  value     = module.aws_rds_instance
  sensitive = true
}