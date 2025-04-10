variable "project_name" {
  type        = string
  description = "Project name used for naming resources and tags (e.g., 'react-app')"
  default     = null
}

variable "root_domain" {
  type        = string
  description = "Main domain for the application (e.g., 'example.com')"
  validation {
    condition     = can(regex("^[a-zA-Z0-9]([a-zA-Z0-9\\-]{0,61}[a-zA-Z0-9])?\\.[a-zA-Z]{2,}$", var.root_domain))
    error_message = "The root_domain must be a valid domain name (e.g., example.com)."
  }
}

variable "subdomain" {
  type        = string
  description = "Subdomain for the React app (e.g., 'app' will result in 'app.example.com')"
  default     = "app"
}

variable "aws_region" {
  description = "AWS region to deploy all resources"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  type        = string
  description = "Deployment environment (e.g., 'dev', 'prod', 'staging')"
  default     = "dev"
  validation {
    condition     = contains(["dev", "prod", "staging"], lower(var.environment))
    error_message = "The environment must be one of: 'dev', 'prod', or 'staging'."
  }
}

variable "cloudfront_distribution_name" {
  type        = string
  description = "Name for the CloudFront distribution"
  default     = null
}

variable "logging_bucket_domain_name" {
  type        = string
  description = "Domain name of the logging S3 bucket (e.g., 'logs-bucket.s3.amazonaws.com')"
}

variable "origin_domain_name" {
  type        = string
  description = "Domain name of the S3 bucket origin for CloudFront (e.g., 'app-bucket.s3.amazonaws.com')"
}

variable "tags" {
  type        = map(string)
  description = "Common tags to apply to all resources"
  default     = {}
}

variable "ssl_minimum_protocol_version" {
  type        = string
  description = "Minimum protocol version for SSL in CloudFront"
  default     = "TLSv1.2_2021"
}

variable "full_domain" {
  type        = string
  description = "The full domain name used for the certificate and DNS (e.g., 'app.example.com')"
}
