provider "aws" {
  region = local.aws_region
}

# Create the user pool
resource "aws_cognito_user_pool" "main" {
  name = local.user_pool_name

  username_attributes = ["email"] # ✅ Login with email only

  auto_verified_attributes = ["email"]

  schema {
    name     = local.user_pool_email_schema.name
    required = local.user_pool_email_schema.required
    mutable  = local.user_pool_email_schema.mutable
    attribute_data_type = local.user_pool_email_schema.attribute_data_type
  }

  schema {
    name     = local.user_pool_name_schema.name
    required = local.user_pool_name_schema.required
    mutable  = local.user_pool_name_schema.mutable
    attribute_data_type = local.user_pool_name_schema.attribute_data_type
  }

  password_policy {
    minimum_length    = local.password_policy.minimum_length
    require_lowercase = local.password_policy.require_lowercase
    require_numbers   = local.password_policy.require_numbers
    require_symbols   = local.password_policy.require_symbols
    require_uppercase = local.password_policy.require_uppercase
  }

  account_recovery_setting {
    recovery_mechanism {
      name     = local.account_recovery_setting.recovery_mechanism.name
      priority = local.account_recovery_setting.recovery_mechanism.priority
    }
  }
}

# Create the Cognito User Pool Client
resource "aws_cognito_user_pool_client" "main" {
  name         = local.user_pool_name
  user_pool_id = aws_cognito_user_pool.main.id

  access_token_validity  = local.token_validity_minutes
  id_token_validity      = local.token_validity_minutes
  refresh_token_validity = local.token_validity_days

  token_validity_units {
    access_token  = "minutes"
    id_token      = "minutes"
    refresh_token = "days"
  }

  generate_secret               = false
  prevent_user_existence_errors = "ENABLED"

  explicit_auth_flows = [
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_SRP_AUTH",
    "ALLOW_ADMIN_USER_PASSWORD_AUTH"
  ]
}
