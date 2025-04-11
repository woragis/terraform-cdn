provider "aws" {
  region = local.aws_region
}

data "aws_route53_zone" "primary" {
  name         = local.root_domain
  private_zone = false
}

resource "aws_acm_certificate" "cert" {
  domain_name       = local.full_domain
  validation_method = "DNS"
  tags              = local.common_tags
}

resource "aws_route53_record" "cert_validation" {
  name    = local.cert_validation.resource_record_name
  type    = local.cert_validation.resource_record_type
  zone_id = data.aws_route53_zone.primary.zone_id
  records = [local.cert_validation.resource_record_value]
  ttl     = 60

  allow_overwrite = true
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [aws_route53_record.cert_validation.fqdn]
}

resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = "OAI for CloudFront to access origin"
}

resource "aws_cloudfront_distribution" "cdn" {
  origin {
    domain_name = var.origin_domain_name
    origin_id   = local.cloudfront_origin_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path
    }
  }

  enabled             = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = local.cloudfront_origin_id
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000

    compress = true

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  custom_error_response {
    error_code         = 404
    response_code      = 200
    response_page_path = "/index.html"
  }

  custom_error_response {
    error_code         = 403
    response_code      = 200
    response_page_path = "/index.html"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate_validation.cert.certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = local.ssl_minimum_protocol_version
  }

  tags = local.common_tags

  depends_on = [aws_acm_certificate_validation.cert]
}
