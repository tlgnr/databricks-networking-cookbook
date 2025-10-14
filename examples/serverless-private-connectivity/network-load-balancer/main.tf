//-----------------------------------
// AWS Network Load Balancer
//-----------------------------------
module "aws_load_balancer" {
  source = "../../modules/aws/load-balancer"

  depends_on = [
    module.aws_rds_postgresql_instance,
  ]

  for_each = local.aws_load_balancers

  enable_cross_zone_load_balancing = each.value.enable_cross_zone_load_balancing
  enable_deletion_protection       = each.value.enable_deletion_protection
  internal                         = each.value.internal
  listeners                        = each.value.listeners
  load_balancer_type               = each.value.load_balancer_type
  name                             = each.value.name
  security_groups                  = [for name in each.value.security_group_names : module.aws_security_group[name].id]
  subnets                          = [for name in each.value.subnet_names : module.aws_subnet[name].id]

  target_groups = {
    for k, v in each.value.target_groups : k => merge(v, {
      vpc_id    = module.aws_vpc[v.vpc_name].id
      target_id = split(":", module.aws_rds_postgresql_instance[v.target_name].endpoint)[0]
    })
  }
}

//-----------------------------------
// AWS VPC Endpoint Service 
//-----------------------------------
module "aws_vpc_endpoint_service" {
  source = "../../modules/aws/vpc-endpoint-service"

  for_each = local.aws_vpc_endpoint_services

  acceptance_required        = each.value.acceptance_required
  allowed_principals         = each.value.allowed_principals
  name                       = each.value.name
  network_load_balancer_arns = [for name in each.value.network_load_balancer_names : module.aws_load_balancer[name].arn]
}




