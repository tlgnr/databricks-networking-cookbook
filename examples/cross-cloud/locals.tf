//-----------------------------------
// Locals General
//-----------------------------------
locals {
  azure_private_sevice_connection_types = {
    databricks = module.azure_databricks_workspace
  }

  aws_route_propagations_raw = flatten([
    for k, v in local.aws_virtual_private_gateway_route_propagations : [
      for _, vv in v : { virtual_private_gateway = k, route_table = vv
  }]])

  aws_route_propagations = {
    for _, v in local.aws_route_propagations_raw : v.route_table => v.virtual_private_gateway
  }
}

//-----------------------------------
// Locals AWS
//-----------------------------------
locals {
  aws_vpcs                                       = yamldecode(templatefile("../../configs/cross-cloud/aws/vpcs.yaml", { environment = var.environment, region = var.region }))
  aws_subnets                                    = yamldecode(templatefile("../../configs/cross-cloud/aws/subnets.yaml", { environment = var.environment, region = var.region }))
  aws_route_tables                               = yamldecode(templatefile("../../configs/cross-cloud/aws/route-tables.yaml", { environment = var.environment, region = var.region }))
  aws_internet_gateways                          = yamldecode(templatefile("../../configs/cross-cloud/aws/internet-gateways.yaml", { environment = var.environment, region = var.region }))
  aws_virtual_private_gateways                   = yamldecode(templatefile("../../configs/cross-cloud/aws/virtual-private-gateways.yaml", { environment = var.environment, region = var.region }))
  aws_customer_gateways                          = yamldecode(templatefile("../../configs/cross-cloud/aws/customer-gateways.yaml", { environment = var.environment, region = var.region, location = var.location }))
  aws_virtual_private_gateway_connections        = yamldecode(templatefile("../../configs/cross-cloud/aws/virtual-private-gateway-connections.yaml", { environment = var.environment, region = var.region, location = var.location }))
  aws_route_table_rules                          = yamldecode(templatefile("../../configs/cross-cloud/aws/route-table-rules.yaml", { environment = var.environment, region = var.region }))
  aws_security_groups                            = yamldecode(templatefile("../../configs/cross-cloud/aws/security-groups.yaml", { environment = var.environment, region = var.region }))
  aws_rds_postgresql_instances                   = yamldecode(templatefile("../../configs/cross-cloud/aws/rds-postgresql-instances.yaml", { environment = var.environment, region = var.region }))
  aws_virtual_private_gateway_route_propagations = yamldecode(templatefile("../../configs/cross-cloud/aws/virtual-private-gateway-route-propagations.yaml", { environment = var.environment, region = var.region }))
}

//-----------------------------------
// Locals Azure
//-----------------------------------
locals {
  azure_resource_groups                              = yamldecode(templatefile("../../configs/cross-cloud/azure/resource-groups.yaml", { environment = var.environment, location = var.location }))
  azure_virtual_networks                             = yamldecode(templatefile("../../configs/cross-cloud/azure/virtual-networks.yaml", { environment = var.environment, location = var.location }))
  azure_subnets                                      = yamldecode(templatefile("../../configs/cross-cloud/azure/subnets.yaml", { environment = var.environment, location = var.location }))
  azure_network_security_groups                      = yamldecode(templatefile("../../configs/cross-cloud/azure/network-security-groups.yaml", { environment = var.environment, location = var.location }))
  azure_route_tables                                 = yamldecode(templatefile("../../configs/cross-cloud/azure/route-tables.yaml", { environment = var.environment, location = var.location }))
  azure_public_ips                                   = yamldecode(templatefile("../../configs/cross-cloud/azure/public-ips.yaml", { environment = var.environment, location = var.location }))
  azure_virtual_network_gateways                     = yamldecode(templatefile("../../configs/cross-cloud/azure/virtual-network-gateways.yaml", { environment = var.environment, location = var.location }))
  azure_local_network_gateways                       = yamldecode(templatefile("../../configs/cross-cloud/azure/local-network-gateways.yaml", { environment = var.environment, location = var.location, region = var.region }))
  azure_virtual_network_gateway_connections_tunnel_1 = yamldecode(templatefile("../../configs/cross-cloud/azure/virtual-network-gateway-connections-tunnel-1.yaml", { environment = var.environment, location = var.location, region = var.region }))
  azure_virtual_network_gateway_connections_tunnel_2 = yamldecode(templatefile("../../configs/cross-cloud/azure/virtual-network-gateway-connections-tunnel-2.yaml", { environment = var.environment, location = var.location, region = var.region }))
  azure_network_security_group_rules                 = yamldecode(templatefile("../../configs/cross-cloud/azure/network-security-group-rules.yaml", { environment = var.environment, location = var.location }))
  azure_databricks_workspaces                        = yamldecode(templatefile("../../configs/cross-cloud/azure/databricks-workspaces.yaml", { environment = var.environment, location = var.location }))
  azure_route_table_associations                     = yamldecode(templatefile("../../configs/cross-cloud/azure/route-table-associations.yaml", { environment = var.environment, location = var.location }))
  azure_network_security_group_associations          = yamldecode(templatefile("../../configs/cross-cloud/azure/network-security-group-associations.yaml", { environment = var.environment, location = var.location }))
  azure_private_dns_zones                            = yamldecode(templatefile("../../configs/cross-cloud/azure/private-dns-zones.yaml", { environment = var.environment, location = var.location }))
  azure_private_endpoints                            = yamldecode(templatefile("../../configs/cross-cloud/azure/private-endpoints.yaml", { environment = var.environment, location = var.location }))
}