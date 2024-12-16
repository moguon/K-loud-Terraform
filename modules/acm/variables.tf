variable "hosted_zone_id" {
  description = "The ID of the Route53 hosted zone."
  type        = string
}

variable "ttl" {
  description = "TTL for the DNS validation records."
  type        = number
  default     = 300
}

variable "domain_name" {
  description = "The primary domain name for the ACM certificate (e.g., example.com)."
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources."
  type        = map(string)
  default     = {}
}