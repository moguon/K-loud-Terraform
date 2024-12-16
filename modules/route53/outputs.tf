output "hosted_zone_id" {
  description = "The ID of the Route53 hosted zone."
  value       = aws_route53_zone.hosted_zone.zone_id
}

output "record_fqdn" {
  description = "The fully qualified domain name of the record."
  value       = aws_route53_record.cloudfront_record.fqdn
}
