# Tabela para armazenar transações
resource "aws_dynamodb_table" "transactions" {
  name         = "Transactions"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "TransactionID"
  attribute {
    name = "TransactionID"
    type = "S"
  }
  # Adicione outras configurações conforme necessário
}