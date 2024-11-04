provider "aws" {
  region = "us-east-1"

}

resource "aws_dynamodb_table" "db1" {
  billing_mode = "PAY_PER_REQUEST"
  name         = "MY-DB"
  hash_key     = "id"

  attribute {
    name = "new"
    type = "S"
  }


}
