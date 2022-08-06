resource "aws_apigatewayv2_api" "apigw_app" {
  name          = var.apigw_name
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "apigw_lambda_integration" {
  api_id           = aws_apigatewayv2_api.apigw_app.id
  integration_type = "AWS_PROXY"

  description               = var.lambda_description
  integration_method        = "POST"
  integration_uri           = module.lambda_function.lambda_function_invoke_arn
}

resource "aws_apigatewayv2_route" "apigw_route" {
  api_id    = aws_apigatewayv2_api.apigw_app.id
  route_key = "ANY /route"

  target = "integrations/${aws_apigatewayv2_integration.apigw_lambda_integration.id}"
}

resource "aws_apigatewayv2_stage" "apigw_stage" {
  api_id = aws_apigatewayv2_api.apigw_app.id
  name   = var.apigw_stage_name
}

resource "aws_apigatewayv2_deployment" "apigw_deployment" {
  api_id      = aws_apigatewayv2_api.apigw_app.id
  description = "Example deployment"

  triggers = {
    redeployment = sha1(join(",", list(
      jsonencode(aws_apigatewayv2_integration.apigw_lambda_integration),
      jsonencode(aws_apigatewayv2_route.apigw_route),
    )))
  }

  lifecycle {
    create_before_destroy = true
  }
}