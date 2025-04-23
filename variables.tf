variable "aws_region" {
  description = "The AWS region to deploy the resources."
  type        = string
  default     = "us-east-1"
}

variable "create_cognito" {
  description = "A boolean flag to control if Cognito resources should be created."
  type        = bool
  default     = true
}

variable "user_pool_name" {
  description = "The name of the Cognito User Pool."
  type        = string
  default     = "my-user-pool"
}

variable "password_minimum_length" {
  description = "Minimum length for the user password."
  type        = number
  default     = 8
}

variable "token_validity_minutes" {
  description = "Validity duration of access and ID tokens in minutes."
  type        = number
  default     = 1440
}

variable "token_validity_days" {
  description = "Validity duration of refresh token in days."
  type        = number
  default     = 1
}
