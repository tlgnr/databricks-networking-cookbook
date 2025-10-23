//-----------------------------------
// Locals
//-----------------------------------
locals {
  user_ids              = [for user in data.databricks_user.this : user.id]
  application_ids       = flatten([for service_principal in var.service_principal_names : data.databricks_service_principals.this[service_principal].application_ids])
  service_principal_ids = [for application_id in local.application_ids : data.databricks_service_principal.this[application_id].sp_id]
  member_ids            = concat(local.user_ids, local.service_principal_ids)
}

//-----------------------------------
// Databricks Group
//-----------------------------------
resource "databricks_group" "this" {
  display_name = var.display_name
}

//-----------------------------------
// Databricks User
//-----------------------------------
data "databricks_user" "this" {
  for_each = toset(var.user_names)

  user_name = each.value
}

//-----------------------------------
// Databricks Service Principal - Name
//-----------------------------------
data "databricks_service_principals" "this" {
  for_each = toset(var.service_principal_names)

  display_name_contains = each.value
}

//-----------------------------------
// Databricks Service Principal - ID
//-----------------------------------
data "databricks_service_principal" "this" {
  for_each = toset(local.application_ids)

  application_id = each.value
}

//-----------------------------------
// Databricks Group Member
//-----------------------------------
resource "databricks_group_member" "this" {
  for_each = toset(local.member_ids)

  group_id  = databricks_group.this.id
  member_id = each.value
}