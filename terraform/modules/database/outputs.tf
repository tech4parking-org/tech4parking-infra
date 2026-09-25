output "parking_spots_table_name" {
  value = aws_dynamodb_table.parking_spots.name
}

output "parking_spots_table_arn" {
  value = aws_dynamodb_table.parking_spots.arn
}
