// ---
// Create the CloudFront Distribution
// ---
resource "aws_cloudfront_distribution" "alb_distribution" {
  enabled = true

  origin {
    domain_name = var.alb_dns_name
    origin_id   = "ALB-${var.alb_name}"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
    }
  }


  default_cache_behavior {
    target_origin_id       = "ALB-${var.alb_name}"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]

    forwarded_values {
      query_string = true
      cookies {
        forward = "all"
      }
    }

    min_ttl                = 0
    default_ttl = var.default_ttl
    max_ttl     = var.max_ttl
  }

  aliases = var.aliases
  price_class = var.price_class

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = var.acm_certificate_arn
    ssl_support_method  = "sni-only"
  }

  tags = var.tags
}
