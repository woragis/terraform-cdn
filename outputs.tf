output "user_pool_id" {
  value = aws_cognito_user_pool.main.id
  description = "The Cognito User Pool ID."
}

output "client_id" {
  value = aws_cognito_user_pool_client.main.id
  description = "The Cognito User Pool Client ID."
}
