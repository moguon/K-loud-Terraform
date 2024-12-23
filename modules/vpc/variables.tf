variable "name" {
  description = "Name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "subnet_cidrs" {
  description = "List of CIDR blocks for the subnets"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for the public subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones in the region"
  type        = list(string)
}

# variable "asg_min_size" {
#   description     = "Minimum size of the Auto Scaling group"
#   default         = 1
# }

# variable "asg_max_size" {
#   description     = "Maximum size of the Auto Scaling group"
#   default         = 5
# }

# variable "asg_desired_capacity" {
#   description     = "Desired capacity of the Auto Scaling group"
#   default         = 2
# }