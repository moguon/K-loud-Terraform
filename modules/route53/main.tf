// ---
// Create a Hosted Zone
// ---
resource "aws_route53_zone" "zone" {
  name = var.domain_name
}

// ---
// Create an A Record for CloudFront
// ---
resource "aws_route53_record" "cloudfront_record" {
  zone_id = aws_route53_zone.zone.zone_id
  name    = "${var.domain_name}"
  type    = "A"

  alias {
    name                   = var.cloudfront_domain_name
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = false
  }
}
