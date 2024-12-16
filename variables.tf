variable "project_name" {
  description = "Name of the project"
  default     = "K-loud"
}

variable "domain_name" {
  description = "The root domain name (e.g., example.com) for the application."
  type        = string
}

variable "record_name" {
  description = "The subdomain name (e.g., www) for the CloudFront distribution."
  type        = string
  default     = "www"
}