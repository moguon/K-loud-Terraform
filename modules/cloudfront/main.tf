// ---
// Create the CloudFront Distribution
// ---
resource "aws_cloudfront_distribution" "distribution" {
  enabled = true

  // S3 Origin
  origin {
    domain_name = var.s3_website_endpoint
    origin_id   = "S3-${var.s3_bucket_name}"

    custom_origin_config { 
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2", "TLSv1.1"]
    }
  }

  // API Gateway Origin
  origin {
    domain_name = var.vpc_endpoint_dns_name
    origin_id   = "VPC-Endpoint"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2", "TLSv1.1"]
    }
  }

  // Default Cache Behavior (S3)
  default_cache_behavior {
    target_origin_id       = "S3-${var.s3_bucket_name}"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl = 3600
    max_ttl     = 86400
  }

  // Additional Cache Behavior for API Gateway
  ordered_cache_behavior {
    path_pattern           = "/api/*"
    target_origin_id       = "VPC-Endpoint"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD", "OPTIONS", "POST", "PUT", "DELETE", "PATCH"]
    cached_methods         = ["GET", "HEAD"]

    forwarded_values {
      query_string = true
      cookies {
        forward = "all"
      }
    }

    min_ttl                = 0
    default_ttl = 3600
    max_ttl     = 86400
  }

  aliases    = var.aliases
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
