//-----------------------------------
// Route Table
//-----------------------------------
variable "location" {
  type = string
}

variable "name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "tags" {
  type = map(string)
}
