variable "role_name" {
  description = "Name of the IAM role"
  type        = string
}

variable "managed_policies" {
  description = "List of AWS managed policies to attach"
  type        = list(string)
  default     = []
}