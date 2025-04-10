output "cloudfront_domain_name" {
  description = "The CloudFront distribution domain name (e.g., d123...cloudfront.net)"
  value       = aws_cloudfront_distribution.cdn.domain_name
}

output "cloudfront_distribution_id" {
  description = "The CloudFront distribution ID for cache invalidation"
  value       = aws_cloudfront_distribution.cdn.id
}

output "certificate_arn" {
  description = "The ARN of the ACM certificate"
  value       = aws_acm_certificate.cert.arn
}
