variable "domain_name" {
  description = "The domain name to create the Hosted Zone for."
  type        = string
}

variable "record_name" {
  description = "The record name (e.g., www) to create in the Hosted Zone."
  type        = string
  default     = "www"
}

variable "cloudfront_domain_name" {
  description = "The CloudFront domain name (e.g., d12345.cloudfront.net) to alias."
  type        = string
}

variable "cloudfront_zone_id" {
  description = "The Route53 zone ID for CloudFront distributions."
  type        = string
  default     = "Z2FDTNDATAQYW2" # CloudFront's default zone ID (global)
}

variable "tags" {
  description = "Tags to apply to all resources."
  type        = map(string)
  default     = {}
}
