output "vpc_id4" {
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

output "cloudfront_distribution_id" {
  description = "The ID of the CloudFront distribution"
  value       = module.cloudfront.cloudfront_distribution_id
}

output "cloudfront_domain_name" {
  description = "The domain name of the CloudFront distribution"
  value       = module.cloudfront.cloudfront_domain_name
}

# output "s3_bucket_name" {
#   value = module.s3.bucket_name
# }

# output "dynamodb_table_name" {
#   value = module.dynamodb.table_name
# }

# output "lambda_function_name" {
#   value = module.lambda.function_name
# }

# output "api_gateway_url" {
#   value = module.api_gateway.api_url
# }
