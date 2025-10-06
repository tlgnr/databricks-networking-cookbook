//-----------------------------------
// RDS Instance
//-----------------------------------
output "password" {
  value     = random_password.this.result
  sensitive = true
}

output "endpoint" {
  value     = aws_db_instance.this.endpoint
  sensitive = true
}