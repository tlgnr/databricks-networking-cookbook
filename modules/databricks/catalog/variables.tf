//-----------------------------------
// Databricks Catalog
//-----------------------------------
variable "comment" {
  type = string
}

variable "connection_name" {
  type = string
}

variable "isolation_mode" {
  type = string
}

variable "name" {
  type = string
}

variable "options" {
  type = map(string)
}
