output "cloudfront_distribution_id" {
  description = "The ID of the CloudFront distribution"
  value       = aws_cloudfront_distribution.distribution.id
}

output "cloudfront_domain_name" {
  description = "The domain name of the CloudFront distribution"
  value       = aws_cloudfront_distribution.distribution.domain_name
}

output "s3_bucket_name" {
  description = "The name of the S3 bucket used for static website hosting"
  value       = var.s3_bucket_name
}

output "vpc_endpoint_dns_name" {
  description = "The DNS name of the VPC Endpoint connected to the API Gateway"
  value       = var.vpc_endpoint_dns_name
}
