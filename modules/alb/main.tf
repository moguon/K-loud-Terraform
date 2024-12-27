# ALB 생성
resource "aws_lb" "application" {
  name               = "${var.name}-alb"
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups    = var.security_group_ids
  subnets            = var.subnet_ids

  tags = var.tags
}


# Target Group 생성
resource "aws_lb_target_group" "default" {
  name     = "${var.name}-tg"
  port     = var.target_group_port
  protocol = var.target_group_protocol
  vpc_id   = var.vpc_id

  health_check {
    interval            = var.health_check_interval
    path                = var.health_check_path
    timeout             = var.health_check_timeout
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
  }

  tags = var.tags
}

# Listener 생성
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.application.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.default.arn
  }
}