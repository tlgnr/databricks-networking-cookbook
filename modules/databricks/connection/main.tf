//-----------------------------------
// Databricks Connection
//-----------------------------------
resource "databricks_connection" "this" {
  name            = var.name
  connection_type = var.connection_type
  comment         = var.comment

  options = {
    host     = var.host
    port     = var.port
    user     = var.user
    password = var.password
  }
}