provider "aws" {
  region = local.aws_region
}

resource "aws_cognito_user_pool" "this" {
  name = "my-user-pool"

  username_attributes = ["email"] # ✅ Login with email only

  auto_verified_attributes = ["email"]

  schema {
    name     = "email"
    required = true
    mutable  = false
    attribute_data_type = string
  }

  schema {
    name     = "name"
    required = true
    mutable  = true
    attribute_data_type = string
  }

  password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
    require_uppercase = true
  }

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }
}

resource "aws_cognito_user_pool_client" "this" {
  name         = "my-user-pool-client"
  user_pool_id = aws_cognito_user_pool.this.id

  access_token_validity  = 1440  # 1 day (in minutes)
  id_token_validity      = 1440  # 1 day (in minutes)
  refresh_token_validity = 1     # 1 day (in days)

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

output "user_pool_id" {
  value = aws_cognito_user_pool.this.id
}

output "client_id" {
  value = aws_cognito_user_pool_client.this.id
}
