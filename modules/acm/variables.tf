variable "domain_name" {
  description = "The domain name to create the ACM certificate for"
  type        = string
}

variable "route53_zone_id" {
  description = "The ID of the Route53 Hosted Zone used for DNS validation"
  type        = string
}

variable "tags" {
  description = "Tags for the ACM certificate"
  type        = map(string)
  default     = {}
}