locals {
  aws_region         = var.aws_region
  root_domain        = var.root_domain
  full_domain        = "${var.subdomain}.${var.root_domain}"
  environment        = lower(var.environment)
  cloudfront_origin_id = "${replace(local.full_domain, ".", "-")}-origin"

  cert_validation = tolist(aws_acm_certificate.cert.domain_validation_options)[0]

  common_tags = merge(
    {
      Project     = coalesce(trimspace(var.project_name), "App")
      Environment = local.environment
      ManagedBy   = "Terraform"
      Purpose     = "Static Website"
    },
    var.tags != null ? var.tags : {}
  )

  ssl_minimum_protocol_version = var.ssl_minimum_protocol_version
}
