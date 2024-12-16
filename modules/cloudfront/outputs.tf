output "cloudfront_distribution_id" {
  description = "The ID of the CloudFront distribution."
  value       = aws_cloudfront_distribution.alb_distribution.id
}

output "cloudfront_domain_name" {
  description = "The domain name of the CloudFront distribution."
  value       = aws_cloudfront_distribution.alb_distribution.domain_name
}

output "cloudfront_origin_id" {
  description = "The origin ID used in the CloudFront distribution."
  value       = aws_cloudfront_distribution.alb_distribution.origin[0].origin_id
}
