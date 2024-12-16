// ---
// Create a Hosted Zone
// ---
resource "aws_route53_zone" "hosted_zone" {
  name = var.domain_name
  tags = var.tags
}

// ---
// Create an A Record for CloudFront
// ---
resource "aws_route53_record" "cloudfront_record" {
  zone_id = aws_route53_zone.hosted_zone.zone_id
  name    = var.record_name
  type    = "A"

  alias {
    name                   = var.cloudfront_domain_name
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = true
  }
}
