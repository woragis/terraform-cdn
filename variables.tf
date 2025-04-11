variable "project_name" {
  type        = string
  description = "Project name used for naming resources and tags"
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
  description = "Subdomain for the app (e.g., 'app' -> app.example.com)"
  default     = "app"
}

variable "aws_region" {
  type        = string
  description = "AWS region to deploy all resources"
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
