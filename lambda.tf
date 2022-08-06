module "lambda_function" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = var.lambda_name
  description   = var.lambda_description
  handler       = "index.handler"
  runtime       = "nodejs16.x"
  allowed_triggers = {
    APIGatewayAny = {
      service    = "apigateway"
      source_arn = "arn:aws:execute-api:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*/*/*/*"
    }
  }

  source_path = "./lambda/index.js"

  tags = {
    Name = var.lambda_name
  }
}