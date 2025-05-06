data "aws_iam_role" "iam_for_lambda" {
  name               = "visitcounter-role"
}

resource "aws_lambda_function" "lf" {
  filename      = "lambda_function.zip"
  function_name = "visitcounter"
  role          = data.aws_iam_role.iam_for_lambda.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"
}


resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lf.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.visitcounter.execution_arn}/*/*"
}



resource "aws_apigatewayv2_api" "visitcounter" {
  name          = "visitcounter"
  protocol_type = "HTTP"

  cors_configuration {
    allow_origins = ["*"]
    allow_methods = ["GET", "POST", "OPTIONS"]
    allow_headers = ["*"]
  }
}


resource "aws_apigatewayv2_integration" "visitcounterintegration" {
  api_id           = aws_apigatewayv2_api.visitcounter.id
  integration_type = "AWS_PROXY"

  connection_type           = "INTERNET"
  description               = "Lambda integration"
  integration_uri           = aws_lambda_function.lf.invoke_arn
  payload_format_version    = "2.0"
  passthrough_behavior      = "WHEN_NO_MATCH"
}

resource "aws_apigatewayv2_route" "visitcounterroute_get" {
  api_id    = aws_apigatewayv2_api.visitcounter.id
  route_key = "GET /visit"
  target    = "integrations/${aws_apigatewayv2_integration.visitcounterintegration.id}"
}

resource "aws_apigatewayv2_route" "visitcounterroute_post" {
  api_id    = aws_apigatewayv2_api.visitcounter.id
  route_key = "POST /visit"
  target    = "integrations/${aws_apigatewayv2_integration.visitcounterintegration.id}"
}






resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.visitcounter.id
  name        = "$default"
  auto_deploy = true
}


