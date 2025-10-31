//-----------------------------------
// AWS Elastic Load Balancer
//-----------------------------------
module "aws_elastic_load_balancer" {
  source = "../../../../../../modules/aws/elastic-load-balancer"

  for_each = var.aws_elastic_load_balancers

  enable_cross_zone_load_balancing                             = each.value.enable_cross_zone_load_balancing
  enable_deletion_protection                                   = each.value.enable_deletion_protection
  enforce_security_group_inbound_rules_on_private_link_traffic = each.value.enforce_security_group_inbound_rules_on_private_link_traffic
  internal                                                     = each.value.internal
  listeners                                                    = each.value.listeners
  load_balancer_type                                           = each.value.load_balancer_type
  name                                                         = each.value.name
  security_groups                                              = [for security_group_name in each.value.security_group_names : var.aws_security_group_ids[security_group_name].id]
  subnets                                                      = [for subnet_name in each.value.subnet_names : var.aws_subnet_ids[subnet_name].id]

  target_groups = {
    for k, v in each.value.target_groups : k => merge(v, {
      vpc_id    = var.aws_vpc_ids[v.vpc_name].id
      target_id = split(":", var.aws_rds_instance_endpoints[v.target_name].endpoint)[0]
    })
  }
}

//-----------------------------------
// AWS VPC Endpoint Service 
//-----------------------------------
module "aws_vpc_endpoint_service" {
  source = "../../../../../../modules/aws/vpc-endpoint-service"

  for_each = var.aws_vpc_endpoint_services

  acceptance_required        = each.value.acceptance_required
  allowed_principals         = each.value.allowed_principals
  name                       = each.value.name
  network_load_balancer_arns = [for elastic_load_balancer_name in each.value.elastic_load_balancer_names : module.aws_elastic_load_balancer[elastic_load_balancer_name].arn]
}




