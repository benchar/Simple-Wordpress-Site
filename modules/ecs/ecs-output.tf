output "wordpress-ecs" {
  value = aws_security_group.wordpress-ecs.id
}

output "alb_dns" {
  value = aws_lb.main.dns_name
}
