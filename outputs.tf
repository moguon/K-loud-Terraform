output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = module.vpc.private_subnet_ids
}

output "public_route_table_id" {
  description = "Route table ID for public subnets"
  value       = module.vpc.public_route_table_id
}


output "private_route_table_id" {
  description = "Route table IDs for private subnets"
  value       = module.vpc.private_route_table_id
}

output "nat_gateway_id" {
  description = "List of NAT Gateway ID"
  value       = module.vpc.nat_gateway_id
}

output "acm_certificate_arn" {
  description = "The ARN of the ACM certificate"
  value       = module.acm.certificate_arn
}

output "vpc_endpoint_dns_name" {
  description = "The DNS name of the VPC Endpoint for API Gateway"
  value       = aws_vpc_endpoint.api_gateway_endpoint.dns_entry[0].dns_name
}

output "cloudfront_distribution_id" {
  description = "The ID of the CloudFront distribution"
  value       = module.cloudfront.cloudfront_distribution_id
}

output "cloudfront_domain_name" {
  description = "The domain name of the CloudFront distribution"
  value       = module.cloudfront.cloudfront_domain_name
}

output "route53_hosted_zone_id" {
  description = "The ID of the Route53 hosted zone"
  value       = module.route53.hosted_zone_id
}

output "route53_record_fqdn" {
  description = "The fully qualified domain name of the Route53 record"
  value       = module.route53.record_fqdn
}

# output "lambda_function_name" {
#   value = module.lambda.function_name
# }

# output "api_gateway_url" {
#   value = module.api_gateway.api_url
# }
