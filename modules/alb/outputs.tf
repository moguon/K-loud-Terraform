output "alb_arn" {
  description = "The ARN of the ALB."
  value       = aws_lb.application.arn
}


output "alb_dns_name" {
  description = "The DNS name of the ALB."
  value       = aws_lb.application.dns_name
}

output "target_group_arn" {
  description = "The ARN of the Target Group."
  value       = aws_lb_target_group.default.arn
}
