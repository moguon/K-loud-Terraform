provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}


resource "aws_acm_certificate" "certificate" {
  provider          = aws.us-east-1
  domain_name       = var.domain_name
  validation_method = "DNS"

  tags = var.tags
}


resource "aws_acm_certificate_validation" "certificate_validation" {
  provider              = aws.us-east-1
  certificate_arn         = aws_acm_certificate.certificate.arn
}