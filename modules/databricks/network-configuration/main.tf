//-----------------------------------
// Databricks Endpoint - Dataplane Relay
//-----------------------------------
resource "databricks_mws_vpc_endpoint" "rest_api" {
  account_id          = var.account_id
  aws_vpc_endpoint_id = var.aws_vpc_endpoint_rest_api_id
  vpc_endpoint_name   = "ept-databricks-rest-interface-${var.environment}-${var.region}"
  region              = var.region
}

//-----------------------------------
// Databricks Endpoint - Rest API
//-----------------------------------
resource "databricks_mws_vpc_endpoint" "dataplane_relay" {
  account_id          = var.account_id
  aws_vpc_endpoint_id = var.aws_vpc_endpoint_relay_id
  vpc_endpoint_name   = "ept-databricks-relay-interface-${var.environment}-${var.region}"
  region              = var.region
}

//-----------------------------------
// Databricks Network Configuration
//-----------------------------------
resource "databricks_mws_networks" "this" {
  account_id         = var.account_id
  network_name       = var.network_name
  security_group_ids = var.aws_security_group_ids
  subnet_ids         = var.aws_subnet_ids
  vpc_id             = var.aws_vpc_id

  vpc_endpoints {
    rest_api        = [databricks_mws_vpc_endpoint.rest_api.vpc_endpoint_id]
    dataplane_relay = [databricks_mws_vpc_endpoint.dataplane_relay.vpc_endpoint_id]
  }
}