resource "aws_ecs_service" "main" {
  name            = "wordpress"
  cluster         = aws_ecs_cluster.wordpress.id
  task_definition = aws_ecs_task_definition.task.id
  desired_count   = var.desired_count
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = var.subnet_id
    assign_public_ip = true
    security_groups  = [aws_security_group.wordpress-ecs.id]
  }
  load_balancer {
    target_group_arn = aws_alb_target_group.main.arn
    container_name   = "wordpress"
    container_port   = 80
  }
  depends_on = [aws_lb.main]
}

resource "aws_ecs_cluster" "wordpress" {
  name = "Wordpress-cluster"
}

resource "aws_ecs_task_definition" "task" {
  network_mode          = "awsvpc"
  family                = "wordpress"
  container_definitions = file("${path.module}/config.json")
  cpu                   = 256
  memory                = 512

}



#Load Balancer
resource "aws_lb" "main" {
  name               = "Wordpress-LB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.wordpress-alb.id]
  subnets            = var.subnet_id
}

resource "aws_alb_listener" "main" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.main.arn
  }
}
resource "aws_alb_target_group" "main" {
  name        = "wordpress-target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id
  health_check {
    matcher = "200,302"
  }
}

#Security Groups
resource "aws_security_group" "wordpress-ecs" {
  vpc_id = var.vpc_id
  name   = "wordpress-ecs"
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.wordpress-alb.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "wordpress-alb" {
  vpc_id = var.vpc_id
  name   = "wordpress-alb"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
