# Tabela das vagas de estacionamento (usada pela Lambda process_car_parking)
resource "aws_dynamodb_table" "parking_spots" {
  name         = "ParkingSpots"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "spot_id"

  attribute {
    name = "spot_id"
    type = "S"
  }
}
