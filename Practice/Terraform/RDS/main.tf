provider "aws" {
  region = "us-east-1"
}
resource "aws_security_group" "Asg" {
  vpc_id = ""
  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "My-Sg"
  }
}

resource "aws_db_instance" "db" {
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "mysql"
  instance_class       = "db.t2.micro"
  username             = "admin"
  password             = "admin"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  tags = {
    Name = "my-rds"
  }

}
