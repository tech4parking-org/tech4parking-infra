resource "aws_lambda_function" "process_car_parking" {
  function_name = "process_car_parking-lambda-processing"
  role          = var.iam_role_lambda_exec_arn
  package_type  = "Image"
  image_uri     = "${aws_ecr_repository.process_car_parking_ecr.repository_url}:latest"
  timeout       = 300

  environment {
    variables = {
      TABLE_NAME = var.parking_spots_table_name
    }
  }

  lifecycle {
    ignore_changes = [image_uri] # Ignora mudanças no URI da imagem para evitar recriação
  }
}

# Permite que a API Gateway invoque a Lambda
resource "aws_lambda_permission" "api_gateway" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.process_car_parking.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.process_car_parking_service.execution_arn}/*/*"
}
