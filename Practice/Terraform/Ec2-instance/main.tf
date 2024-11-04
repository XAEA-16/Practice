provider "aws" {
  region = "us-east-1"

}

resource "aws_instance" "instance1" {

  ami           = "ami-0866a3c8686eaeeba"
  instance_type = "t2.micro"

  tags = {
    NAME = "new-instance"
  }


}
