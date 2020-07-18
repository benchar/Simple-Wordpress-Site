resource "aws_rds_cluster" "main" {
  cluster_identifier     = "wordpress-aurora"
  db_subnet_group_name   = aws_db_subnet_group.default.id
  vpc_security_group_ids = [aws_security_group.allow-aurora.id]
  engine                 = var.engine
  engine_version         = var.engine_version
  skip_final_snapshot    = true



  database_name   = var.database_name
  master_username = var.master_username
  master_password = var.master_password
  engine_mode     = "serverless"


  scaling_configuration {
    auto_pause               = true
    max_capacity             = 2
    min_capacity             = 1
    seconds_until_auto_pause = 300
    timeout_action           = "ForceApplyCapacityChange"
  }
}

resource "aws_security_group" "allow-aurora" {
  vpc_id = var.vpc_id
  name   = "allow-aurora"
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.ecs_security_group]
  }
}

resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = var.subnet_id

  tags = {
    Name = "My DB subnet group"
  }
}
