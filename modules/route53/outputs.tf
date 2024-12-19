output "route53_zone_name" {
  description = "The name of the Route53 hosted zone"
  value       = aws_route53_zone.zone.name
}

output "route53_cloudfront_alias" {
  description = "The alias record for CloudFront"
  value       = aws_route53_record.cloudfront_record.name
}

output "zone_id" {
  description = "The ID of the Route53 Hosted Zone"
  value       = aws_route53_zone.zone.zone_id
}