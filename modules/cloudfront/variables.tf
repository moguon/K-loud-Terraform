variable "aliases" {
  description = "CloudFront distribution domain aliases"
  type        = list(string)
  default     = []
}

variable "price_class" {
  description = "CloudFront price class"
  type        = string
  default     = "PriceClass_200"
}

// S3 Configuration
variable "s3_bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "s3_website_endpoint" {
  description = "The S3 website endpoint for static content"
  type        = string
}

// VPC Endpoint Configuration
variable "vpc_endpoint_dns_name" {
  description = "DNS name of the VPC Endpoint for API Gateway"
  type        = string
}

// ACM Certificate
variable "acm_certificate_arn" {
  description = "ACM Certificate ARN for CloudFront SSL"
  type        = string
}

// Tags
variable "tags" {
  description = "Tags to apply to the CloudFront distribution"
  type        = map(string)
  default     = {}
}
