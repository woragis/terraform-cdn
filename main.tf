provider "aws" {
  region = local.aws_region
}

resource "aws_cognito_user_pool" "main" {
  name = local.cognito_user_pool
}

resource "aws_cognito_user_pool_client" "client" {
  name         = local.cognito_name
  user_pool_id = aws_cognito_user_pool.main.id
}
