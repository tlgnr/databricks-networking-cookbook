//-----------------------------------
// Databricks Permission Assignment
//-----------------------------------
variable "permissions" {
  type = list(string)
}

variable "principal_id" {
  type = string
}

variable "principal_type" {
  type = string
}

variable "workspace_id" {
  type = string
}