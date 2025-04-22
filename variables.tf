variable "aws_region" {
  type        = string
  description = "AWS region to deploy all resources"
  default     = "us-east-1"
}

variable "cognito_name" {
  type        = string
  description = "Domain name of the S3 bucket origin for CloudFront (e.g., 'app-bucket.s3.amazonaws.com')"
}

variable "cognito_user_pool" {
  type        = string
  description = "Domain name of the S3 bucket origin for CloudFront (e.g., 'app-bucket.s3.amazonaws.com')"
}
