# Encaminha as mensagens do sensor (firmware tech4parking-iot) para a Lambda
resource "aws_iot_topic_rule" "process_car_parking_iot_rule" {
  name        = "process_car_parking_sensor"
  sql         = "SELECT * FROM 'parking_sensor'"
  sql_version = "2016-03-23"
  enabled     = true

  lambda {
    function_arn = var.process_car_parking_lambda_arn
  }
}

# Permite que a regra IoT invoque a Lambda
resource "aws_lambda_permission" "iot_rule" {
  statement_id  = "AllowIoTRuleInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.process_car_parking_lambda_arn
  principal     = "iot.amazonaws.com"
  source_arn    = aws_iot_topic_rule.process_car_parking_iot_rule.arn
}
