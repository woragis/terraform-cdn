locals {
  origin_domain_name         = var.origin_domain_name
  aws_region                 = var.aws_region
  root_domain                = var.root_domain

  # Domain and Naming
  full_domain        = "${var.subdomain}.${var.root_domain}"
  normalized_project = lower(coalesce(trimspace(var.project_name), "app"))
  environment        = lower(var.environment)

  # CloudFront and Certificate Names
  cloudfront_name       = trim(coalesce(var.cloudfront_distribution_name, ""), " ") != "" ? var.cloudfront_distribution_name : "${local.normalized_project}-${local.environment}-cdn"
  certificate_name      = "${local.normalized_project}-${local.environment}-cert"
  cloudfront_origin_id  = "${local.normalized_project}-s3-origin"

  # Certificate Validation (optional helper local if you're accessing it elsewhere)
  cert_validation = tolist(aws_acm_certificate.cert.domain_validation_options)[0]

  # Tags
  common_tags = merge(
    {
      Project     = coalesce(trimspace(var.project_name), "App")
      Environment = local.environment
      ManagedBy   = "Terraform"
      Purpose     = "Static Website"
    },
    var.tags != null ? var.tags : {}
  )

  # CloudFront Settings
  ssl_minimum_protocol_version = var.ssl_minimum_protocol_version
}
