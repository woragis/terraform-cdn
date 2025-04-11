output "cloudfront_domain_name" {
  description = "CloudFront domain to point DNS to"
  value       = aws_cloudfront_distribution.cdn.domain_name
}

output "full_domain" {
  description = "The full domain name (subdomain + root)"
  value       = local.full_domain
}

output "zone_id" {
  description = "Route53 zone ID (from primary zone data source)"
  value       = data.aws_route53_zone.primary.zone_id
}

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID (for cache invalidation)"
  value       = aws_cloudfront_distribution.cdn.id
}
