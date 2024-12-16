output "certificate_arn" {
  description = "The ARN of the ACM certificate."
  value       = aws_acm_certificate.certificate.arn
}

output "validation_status" {
  description = "The validation status of the ACM certificate."
  value       = aws_acm_certificate.certificate.status
}