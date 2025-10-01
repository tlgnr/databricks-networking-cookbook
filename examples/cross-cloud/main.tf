//-----------------------------------
// AWS VPCs
//-----------------------------------
module "aws_vpc" {
  source = "../../modules/aws/vpc"

  for_each = local.aws_vpcs

  name                 = each.value.name
  cidr_block           = each.value.cidr_block
  enable_dns_hostnames = each.value.enable_dns_hostnames
  enable_dns_support   = each.value.enable_dns_support
}

//-----------------------------------
// AWS Internet Gateways
//-----------------------------------
module "aws_internet_gateway" {
  source = "../../modules/aws/internet-gateway"

  for_each = local.aws_internet_gateways

  name   = each.value.name
  vpc_id = module.aws_vpc[each.value.vpc_name].id
}

//-----------------------------------
// AWS Route Tables
//-----------------------------------
module "aws_route_table" {
  source = "../../modules/aws/route-table"

  for_each = local.aws_route_tables

  name   = each.value.name
  vpc_id = module.aws_vpc[each.value.vpc_name].id
}

//-----------------------------------
// AWS Subnets
//-----------------------------------
module "aws_subnet" {
  source = "../../modules/aws/subnet"

  for_each = local.aws_subnets

  name              = each.value.name
  vpc_id            = module.aws_vpc[each.value.vpc_name].id
  route_table_id    = module.aws_route_table[each.value.route_table_name].id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone
}

//-----------------------------------
// AWS Route Table Rules
//-----------------------------------
module "aws_route_table_rule" {
  source = "../../modules/aws/route-table-rule"

  for_each = local.aws_route_table_rules

  route_table_id         = module.aws_route_table[each.value.route_table_name].id
  gateway_id             = module.aws_internet_gateway[each.value.internet_gateway_name].id
  destination_cidr_block = each.value.destination_cidr_block
}

//-----------------------------------
// AWS Security Groups
//-----------------------------------
module "aws_security_group" {
  source = "../../modules/aws/security-group"

  for_each = local.aws_security_groups

  name                         = each.value.name
  description                  = each.value.description
  region                       = var.region
  vpc_id                       = module.aws_vpc[each.value.vpc_name].id
  security_group_ingress_rules = each.value.security_group_ingress_rules
  security_group_egress_rules  = each.value.security_group_egress_rules
}

//-----------------------------------
// Azure Resource Groups
//-----------------------------------
module "azure_resource_group" {
  source = "../../modules/azure/resource-group"

  for_each = local.azure_resource_groups

  name     = each.value.name
  location = var.location
  tags     = var.tags
}

//-----------------------------------
// Azure Virtual Networks
//-----------------------------------
module "azure_virtual_network" {
  source = "../../modules/azure/virtual-network"

  depends_on = [
    module.azure_resource_group,
  ]

  for_each = local.azure_virtual_networks

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  address_space       = each.value.address_space
  dns_servers         = each.value.dns_servers
  location            = var.location
  tags                = var.tags
}

//-----------------------------------
// Azure Network Security Groups
//-----------------------------------
module "azure_network_security_group" {
  source = "../../modules/azure/network-security-group"

  depends_on = [
    module.azure_resource_group,
  ]

  for_each = local.azure_network_security_groups

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = var.location
  tags                = var.tags
}

//-----------------------------------
// Azure Network Security Group Rules
//-----------------------------------
module "azure_network_security_group_rule" {
  source = "../../modules/azure/network-security-group-rule"

  depends_on = [
    module.azure_resource_group,
    module.azure_network_security_group
  ]

  for_each = local.azure_network_security_group_rules

  name                        = each.value.name
  network_security_group_name = each.value.network_security_group_name
  resource_group_name         = each.value.resource_group_name
  source_port_range           = each.value.source_port_range
  protocol                    = each.value.protocol
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  access                      = each.value.access
  priority                    = each.value.priority
  direction                   = each.value.direction
}

//-----------------------------------
// Azure Network Security Group Associations
//-----------------------------------
module "azure_network_security_group_association" {
  source = "../../modules/azure/network-security-group-association"

  for_each = local.azure_network_security_group_associations

  network_security_group_id = module.azure_network_security_group[each.value.network_security_group_name].id
  subnet_id                 = module.azure_subnet[each.value.subnet_name].id
}

//-----------------------------------
// Azure Route Tables
//-----------------------------------
module "azure_route_table" {
  source = "../../modules/azure/route-table"

  depends_on = [
    module.azure_resource_group,
  ]

  for_each = local.azure_route_tables

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = var.location
  tags                = var.tags
}

//-----------------------------------
// Azure Subnets
//-----------------------------------
module "azure_subnet" {
  source = "../../modules/azure/subnet"

  depends_on = [
    module.azure_resource_group,
    module.azure_virtual_network,
  ]

  for_each = local.azure_subnets

  address_prefixes          = each.value.address_prefixes
  delegation                = each.value.delegation
  name                      = each.value.name
  network_security_group_id = try(module.azure_network_security_group[each.value.network_security_group_name].id, null)
  resource_group_name       = each.value.resource_group_name
  route_table_id            = module.azure_route_table[each.value.route_table_name].id
  service_endpoints         = each.value.service_endpoints
  virtual_network_name      = each.value.virtual_network_name
}

//-----------------------------------
// Azure Route Table Associations
//-----------------------------------
module "azure_route_table_association" {
  source = "../../modules/azure/route-table-association"

  for_each = local.azure_route_table_associations

  route_table_id = module.azure_route_table[each.value.route_table_name].id
  subnet_id      = module.azure_subnet[each.value.subnet_name].id
}

//-----------------------------------
// Azure Public IP Addresses
//-----------------------------------
module "azure_public_ip" {
  source = "../../modules/azure/public-ip"

  depends_on = [
    module.azure_resource_group,
  ]

  for_each = local.azure_public_ips

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  allocation_method   = each.value.allocation_method
  sku                 = each.value.sku
  location            = var.location
  tags                = var.tags
}

//-----------------------------------
// AWS Virtual Private Gateways
//-----------------------------------
module "aws_virtual_private_gateway" {
  source = "../../modules/aws/virtual-private-gateway"

  for_each = local.aws_virtual_private_gateways

  name            = each.value.name
  vpc_id          = module.aws_vpc[each.value.vpc_name].id
  route_table_ids = values(module.aws_route_table).*.id
}

//-----------------------------------
// AWS Virtual Private Gateway Route Propagation
//-----------------------------------
module "aws_virtual_private_gateway_route_propagation" {
  source = "../../modules/aws/virtual-private-gateway-route-propagation"

  for_each = local.aws_route_propagations

  route_table_id = module.aws_route_table[each.key].id
  vpn_gateway_id = module.aws_virtual_private_gateway[each.value].id
}

//-----------------------------------
// Azure Virtual Network Gateways
//-----------------------------------
module "azure_virtual_network_gateway" {
  source = "../../modules/azure/virtual-network-gateway"

  for_each = local.azure_virtual_network_gateways

  name                                          = each.value.name
  resource_group_name                           = each.value.resource_group_name
  ip_configurations_name                        = each.value.ip_configurations_name
  ip_configurations_first_public_ip_address_id  = module.azure_public_ip[each.value.ip_configurations_first_public_ip_address_name].id
  ip_configurations_second_public_ip_address_id = module.azure_public_ip[each.value.ip_configurations_second_public_ip_address_name].id
  ip_configurations_subnet_id                   = module.azure_subnet[each.value.ip_configurations_subnet_name].id
  type                                          = each.value.type
  vpn_type                                      = each.value.vpn_type
  active_active                                 = each.value.active_active
  enable_bgp                                    = each.value.enable_bgp
  sku                                           = each.value.sku
  asn                                           = each.value.asn
  apipa_addresses                               = each.value.apipa_addresses
  location                                      = var.location
  tags                                          = var.tags
}

//-----------------------------------
// AWS Customer Gateways
//-----------------------------------
module "aws_customer_gateway" {
  source = "../../modules/aws/customer-gateway"

  for_each = local.aws_customer_gateways

  name       = each.value.name
  bgp_asn    = module.azure_virtual_network_gateway[each.value.peer_gateway_name].asn
  ip_address = one(module.azure_virtual_network_gateway[each.value.peer_gateway_name].tunnel_ip_addresses[each.value.ip_address])
}

//-----------------------------------
// AWS Virtual Private Gateway Connections
//-----------------------------------
module "aws_virtual_private_gateway_connection" {
  source = "../../modules/aws/virtual-private-gateway-connection"

  for_each = local.aws_virtual_private_gateway_connections

  name                = each.value.name
  vpn_gateway_id      = module.aws_virtual_private_gateway[each.value.virtual_private_gateway_name].id
  customer_gateway_id = module.aws_customer_gateway[each.value.customer_gateway_name].id
  tunnel1_inside_cidr = each.value.tunnel1_inside_cidr
  tunnel2_inside_cidr = each.value.tunnel2_inside_cidr
}

//-----------------------------------
// Azure Local Network Gateway - Tunnel 1
//-----------------------------------
module "azure_local_network_gateway_tunnel_1" {
  source = "../../modules/azure/local-network-gateway"

  for_each = local.azure_local_network_gateways

  name                = "${each.value.name}-001"
  resource_group_name = each.value.resource_group_name
  asn                 = module.aws_virtual_private_gateway[each.value.peer_gateway_name].asn
  gateway_address     = module.aws_virtual_private_gateway_connection[each.value.connection_name].tunnel1_address
  bgp_peering_address = module.aws_virtual_private_gateway_connection[each.value.connection_name].tunnel1_vgw_inside_address
  tags                = var.tags
  location            = var.location
}

//-----------------------------------
// Azure Local Network Gateway - Tunnel 2
//-----------------------------------
module "azure_local_network_gateway_tunnel_2" {
  source = "../../modules/azure/local-network-gateway"

  for_each = local.azure_local_network_gateways

  name                = "${each.value.name}-002"
  resource_group_name = each.value.resource_group_name
  asn                 = module.aws_virtual_private_gateway[each.value.peer_gateway_name].asn
  gateway_address     = module.aws_virtual_private_gateway_connection[each.value.connection_name].tunnel2_address
  bgp_peering_address = module.aws_virtual_private_gateway_connection[each.value.connection_name].tunnel2_vgw_inside_address
  tags                = var.tags
  location            = var.location
}

//-----------------------------------
// Azure Virtual Network Gateway Connection - Tunnel 1
//-----------------------------------
module "azure_virtual_network_gateway_connection_tunnel_1" {
  source = "../../modules/azure/virtual-network-gateway-connection"

  for_each = local.azure_virtual_network_gateway_connections_tunnel_1

  name                         = "${each.value.name}-001"
  resource_group_name          = each.value.resource_group_name
  enable_bgp                   = each.value.enable_bgp
  shared_key                   = module.aws_virtual_private_gateway_connection[each.value.connection_name].tunnel1_preshared_key
  virtual_network_gateway_id   = module.azure_virtual_network_gateway[each.value.virtual_network_gateway_name].id
  local_network_gateway_id     = module.azure_local_network_gateway_tunnel_1[each.value.local_network_gateway_name].id
  primary_custom_bgp_address   = module.azure_virtual_network_gateway[each.value.virtual_network_gateway_name].custom_bgp_addresses[each.value.primary_custom_bgp_address]
  secondary_custom_bgp_address = module.azure_virtual_network_gateway[each.value.virtual_network_gateway_name].custom_bgp_addresses[each.value.secondary_custom_bgp_address]
  tags                         = var.tags
  location                     = var.location
}

//-----------------------------------
// Azure Virtual Network Gateway Connection - Tunnel 2
//-----------------------------------
module "azure_virtual_network_gateway_connection_tunnel_2" {
  source = "../../modules/azure/virtual-network-gateway-connection"

  for_each = local.azure_virtual_network_gateway_connections_tunnel_2

  name                         = "${each.value.name}-002"
  resource_group_name          = each.value.resource_group_name
  enable_bgp                   = each.value.enable_bgp
  shared_key                   = module.aws_virtual_private_gateway_connection[each.value.connection_name].tunnel2_preshared_key
  virtual_network_gateway_id   = module.azure_virtual_network_gateway[each.value.virtual_network_gateway_name].id
  local_network_gateway_id     = module.azure_local_network_gateway_tunnel_2[each.value.local_network_gateway_name].id
  primary_custom_bgp_address   = module.azure_virtual_network_gateway[each.value.virtual_network_gateway_name].custom_bgp_addresses[each.value.primary_custom_bgp_address]
  secondary_custom_bgp_address = module.azure_virtual_network_gateway[each.value.virtual_network_gateway_name].custom_bgp_addresses[each.value.secondary_custom_bgp_address]
  tags                         = var.tags
  location                     = var.location
}

//-----------------------------------
// Azure Private DNS Zones
//-----------------------------------
module "azure_private_dns_zone" {
  source = "../../modules/azure/private-dns-zone"

  depends_on = [
    module.azure_resource_group,
  ]

  for_each = local.azure_private_dns_zones

  name                      = each.value.name
  resource_group_name       = each.value.resource_group_name
  virtual_network_id        = module.azure_virtual_network[each.value.virtual_network_name].id
  virtual_network_link_name = "to-${each.value.virtual_network_name}"
  tags                      = var.tags
}

//-----------------------------------
// Azure Databricks Workspace
//-----------------------------------
module "azure_databricks_workspace" {
  source = "../../modules/azure/databricks-workspace"

  for_each = local.azure_databricks_workspaces

  name                                                 = each.value.name
  resource_group_name                                  = each.value.resource_group_name
  managed_resource_group_name                          = each.value.managed_resource_group_name
  sku                                                  = each.value.sku
  virtual_network_id                                   = module.azure_virtual_network[each.value.virtual_network_name].id
  public_subnet_name                                   = each.value.public_subnet_name
  private_subnet_name                                  = each.value.private_subnet_name
  public_subnet_network_security_group_association_id  = module.azure_network_security_group_association[each.value.public_network_security_group_name].id
  private_subnet_network_security_group_association_id = module.azure_network_security_group_association[each.value.private_network_security_group_name].id
  no_public_ip                                         = each.value.no_public_ip
  public_network_access_enabled                        = each.value.public_network_access_enabled
  network_security_group_rules_required                = each.value.network_security_group_rules_required
  location                                             = var.location
  tags                                                 = var.tags
}

//-----------------------------------
// Azure Private Endpoints
//-----------------------------------
module "azure_private_endpoint" {
  source = "../../modules/azure/private-endpoint"

  for_each = local.azure_private_endpoints

  name                            = each.value.name
  resource_group_name             = each.value.resource_group_name
  subnet_id                       = module.azure_subnet[each.value.subnet_name].id
  private_dns_zone_id             = module.azure_private_dns_zone[each.value.private_dns_zone_name].id
  private_dns_zone_group_name     = each.value.private_dns_zone_group_name
  private_service_connection_name = each.value.private_service_connection_name
  private_connection_resource_id  = lookup(lookup(local.azure_private_sevice_connection_types, each.value.private_sevice_connection_type), each.value.private_connection_resource_name).id
  subresource_name                = each.value.subresource_name
  tags                            = var.tags
  location                        = var.location
}

//-----------------------------------
// AWS RDS PostgreSQL Instance
//-----------------------------------
module "aws_rds_postgresql_instance" {
  source = "../../modules/aws/rds-instance"

  for_each = local.aws_rds_postgresql_instances

  identifier                          = each.value.identifier
  allocated_storage                   = each.value.allocated_storage
  engine                              = each.value.engine
  apply_immediately                   = each.value.apply_immediately
  engine_version                      = each.value.engine_version
  instance_class                      = each.value.instance_class
  username                            = each.value.username
  parameter_group_name                = each.value.parameter_group_name
  skip_final_snapshot                 = each.value.skip_final_snapshot
  storage_encrypted                   = each.value.storage_encrypted
  max_allocated_storage               = each.value.max_allocated_storage
  iam_database_authentication_enabled = each.value.iam_database_authentication_enabled
  copy_tags_to_snapshot               = each.value.copy_tags_to_snapshot
  vpc_security_group_ids              = [for name in each.value.vpc_security_group_names : module.aws_security_group[name].id]
  subnet_group_name                   = each.value.subnet_group_name
  subnet_ids                          = [for name in each.value.subnet_names : module.aws_subnet[name].id]
}



