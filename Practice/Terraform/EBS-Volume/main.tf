provider "aws" {

  region = "us-east-1"

}

resource "aws_ebs_volume" "eb1" {
  availability_zone = "us-east-1a"
  size              = 20
  type              = "gp2"
  encrypted         = true

  tags = {
    Name = "MY-EBS-Volume"
  }
}

resource "aws_instance" "instance1" {
  ami           = "ami-0866a3c8686eaeeba"
  instance_type = "t2.micro"

}

resource "aws_volume_attachment" "ebs-attachment" {
  device_name = "/dev/sdh"
  instance_id = aws_instance.instance1.id
  volume_id   = aws_ebs_volume.eb1.id

}
