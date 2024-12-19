resource "aws_route53_record" "cert_validation" {
  for_each = { for v in aws_acm_certificate.certificate.domain_validation_options : v.domain_name => v }

  zone_id = var.route53_zone_id
  name    = each.value.resource_record_name
  type    = each.value.resource_record_type
  records = [each.value.resource_record_value]
  ttl     = 300
}
