variable "alb_name" {
  description = "The name of the ALB to connect to CloudFront."
  type        = string
}

variable "alb_dns_name" {
  description = "The DNS name of the ALB to use as an origin."
  type        = string
}

variable "acm_certificate_arn" {
  description = "The ARN of the ACM certificate to use for CloudFront HTTPS."
  type        = string
}

variable "aliases" {
  description = "Custom domain names (CNAMEs) for the CloudFront distribution."
  type        = list(string)
  default     = ["ms.someone0705.xyz"]
}

variable "default_ttl" {
  description = "Default time-to-live (TTL) for cache."
  type        = number
  default     = 3600
}

variable "max_ttl" {
  description = "Maximum time-to-live (TTL) for cache."
  type        = number
  default     = 86400
}

variable "price_class" {
  description = "Price class for CloudFront distribution."
  type        = string
  default     = "PriceClass_200" # Options: PriceClass_100, PriceClass_200, PriceClass_All
}

variable "tags" {
  description = "Tags to apply to resources."
  type        = map(string)
  default     = {}
}
