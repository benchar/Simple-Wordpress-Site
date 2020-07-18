#VPC
output "main_id" {
  value = module.main_vpc.vpc_id
}

output "public_subnet" {
  value = module.main_vpc.subnet_id
}

output "private_subnet" {
  value = module.main_vpc.private_subnet_id
}

output "igw_main" {
  value = module.main_vpc.igw
}

#ECS
output "ecs_sg" {
  value = module.ecs_wordpress.wordpress-ecs
}
output "ecs_alb" {
  value = module.ecs_wordpress.alb_dns
}

#RDS
output "rds_endpoint" {
  value = module.aurora.rds_endpoint
}
