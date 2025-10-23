//-----------------------------------
// Databricks Account Level Permission Assignment
//-----------------------------------
variable "permissions" {
  type = list(string)
}

variable "principal_ids" {
  type = list(string)
}

variable "workspace_id" {
  type = string
}