resource "aws_api_gateway_rest_api" "process_car_parking_service" {
  name        = "process_car_parking_service-lambda"
  description = "API de vagas do Tech4Parking (Lambda process_car_parking)"
}

resource "aws_api_gateway_resource" "api_resource" {
  rest_api_id = aws_api_gateway_rest_api.process_car_parking_service.id
  parent_id   = aws_api_gateway_rest_api.process_car_parking_service.root_resource_id
  path_part   = "spots"
}

# Método POST
resource "aws_api_gateway_method" "post_method" {
  rest_api_id   = aws_api_gateway_rest_api.process_car_parking_service.id
  resource_id   = aws_api_gateway_resource.api_resource.id
  http_method   = "POST"
  authorization = "NONE"
}

# Integração POST com Lambda
resource "aws_api_gateway_integration" "post_integration" {
  rest_api_id             = aws_api_gateway_rest_api.process_car_parking_service.id
  resource_id             = aws_api_gateway_resource.api_resource.id
  http_method             = aws_api_gateway_method.post_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.process_car_parking.invoke_arn
}

# Método GET
resource "aws_api_gateway_method" "get_method" {
  rest_api_id   = aws_api_gateway_rest_api.process_car_parking_service.id
  resource_id   = aws_api_gateway_resource.api_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

# Integração GET com Lambda
resource "aws_api_gateway_integration" "get_integration" {
  rest_api_id             = aws_api_gateway_rest_api.process_car_parking_service.id
  resource_id             = aws_api_gateway_resource.api_resource.id
  http_method             = aws_api_gateway_method.get_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.process_car_parking.invoke_arn
}

# Método DELETE
resource "aws_api_gateway_method" "delete_method" {
  rest_api_id   = aws_api_gateway_rest_api.process_car_parking_service.id
  resource_id   = aws_api_gateway_resource.api_resource.id
  http_method   = "DELETE"
  authorization = "NONE"
}

# Integração DELETE com Lambda
resource "aws_api_gateway_integration" "delete_integration" {
  rest_api_id             = aws_api_gateway_rest_api.process_car_parking_service.id
  resource_id             = aws_api_gateway_resource.api_resource.id
  http_method             = aws_api_gateway_method.delete_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.process_car_parking.invoke_arn
}

# Método OPTIONS (preflight CORS do navegador)
resource "aws_api_gateway_method" "options_method" {
  rest_api_id   = aws_api_gateway_rest_api.process_car_parking_service.id
  resource_id   = aws_api_gateway_resource.api_resource.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

# Integração OPTIONS com Lambda (a Lambda devolve os cabeçalhos CORS)
resource "aws_api_gateway_integration" "options_integration" {
  rest_api_id             = aws_api_gateway_rest_api.process_car_parking_service.id
  resource_id             = aws_api_gateway_resource.api_resource.id
  http_method             = aws_api_gateway_method.options_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.process_car_parking.invoke_arn
}
