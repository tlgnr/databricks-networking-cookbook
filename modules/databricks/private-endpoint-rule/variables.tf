//-----------------------------------
// Databricks Private Endpoint Rule
//-----------------------------------
variable "domain_names" {
  type = list(string)
}

variable "endpoint_service" {
  type = string
}

variable "network_connectivity_config_id" {
  type = string
}
