//-----------------------------------
// Databricks Group
//-----------------------------------
variable "display_name" {
  type = string
}

variable "user_names" {
  type = list(string)
}

variable "service_principal_names" {
  type = list(string)
}