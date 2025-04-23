locals {
  aws_region            = var.aws_region
  create_cognito        = true
  user_pool_name        = "my-user-pool"
  user_pool_email_schema = {
    name     = "email"
    required = true
    mutable  = false
    attribute_data_type = "String"
  }
  user_pool_name_schema = {
    name     = "name"
    required = true
    mutable  = true
    attribute_data_type = "String"
  }
  password_policy       = {
    minimum_length    = var.password_minimum_length
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
    require_uppercase = true
  }
  account_recovery_setting = {
    recovery_mechanism = {
      name     = "verified_email"
      priority = 1
    }
  }
  token_validity_minutes = var.token_validity_minutes
  token_validity_days    = var.token_validity_days
}
