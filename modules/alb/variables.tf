# ALB Name
variable "name" {
  description = "Name of the ALB"
  type        = string
}

# VPC ID
variable "vpc_id" {
  description = "VPC ID where the ALB will be created."
  type        = string
}

# Subnet IDs
variable "subnet_ids" {
  description = "List of Subnet IDs for ALB."
  type        = list(string)
}

# Security Group IDs
variable "security_group_ids" {
  description = "List of Security Group IDs for ALB."
  type        = list(string)
}

# ALB Configuration
variable "internal" {
  description = "Whether the ALB is internal or external."
  type        = bool
  default     = false
}

variable "load_balancer_type" {
  description = "Type of the load balancer (application or network)."
  type        = string
  default     = "application"
}

# Target Group Configuration
variable "target_group_port" {
  description = "Port for Target Group."
  type        = number
  default     = 80
}

variable "target_group_protocol" {
  description = "Protocol for Target Group."
  type        = string
  default     = "HTTP"
}

# Health Check Configuration
variable "health_check_path" {
  description = "Path for health checks."
  type        = string
  default     = "/"
}

variable "health_check_interval" {
  description = "Interval for health checks."
  type        = number
  default     = 30
}

variable "health_check_timeout" {
  description = "Timeout for health checks."
  type        = number
  default     = 5
}

variable "healthy_threshold" {
  description = "Number of consecutive successful health checks for healthy state."
  type        = number
  default     = 2
}

variable "unhealthy_threshold" {
  description = "Number of consecutive failed health checks for unhealthy state."
  type        = number
  default     = 2
}

# Listener Configuration
variable "listener_port" {
  description = "Port for ALB Listener."
  type        = number
  default     = 80
}

variable "listener_protocol" {
  description = "Protocol for ALB Listener."
  type        = string
  default     = "HTTP"
}

# Tags
variable "tags" {
  description = "Tags to be applied to resources."
  type        = map(string)
  default     = {}
}