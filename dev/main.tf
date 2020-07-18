provider "aws" {
  region = "us-east-1"
}

module "main_vpc" {
  source       = "../modules/vpc"
  subnet_count = 2
  tags         = "Public"
  tags2        = "Private"
}

module "ecs_wordpress" {
  source        = "../modules/ecs"
  desired_count = 2
  vpc_id        = module.main_vpc.vpc_id
  subnet_id     = module.main_vpc.subnet_id
}

module "aurora" {
  source             = "../modules/rds"
  database_name      = "wordpress"
  vpc_id             = module.main_vpc.vpc_id
  subnet_id          = module.main_vpc.private_subnet_id
  ecs_security_group = module.ecs_wordpress.wordpress-ecs
}
