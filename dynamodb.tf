resource "aws_dynamodb_table" "VisitCounter" {
  name         = "VisitCounter"
  billing_mode = "PAY_PER_REQUEST"  # or use provisioned settings if needed
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"  # 'S' for string, 'N' for number, etc.
  }

  tags = {
    Name = "VisitCounter"
  }
}
