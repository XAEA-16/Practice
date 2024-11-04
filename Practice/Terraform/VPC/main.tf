provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "kp" {
  key_name   = "New-kp"
  public_key = file("C:\\Users\\rahul\\OneDrive\\Desktop\\Practice\\Terraform\\VPC\\new-key-pair.pem.pub")
}

variable "cidr" {
  default = "10.0.0.0/24"
}

resource "aws_vpc" "myvpc" {
  cidr_block = var.cidr

  tags = {
    Name = "My-Vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "My-Internet-Gateway"
  }
}

resource "aws_subnet" "sub1" {
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.0.0/24"
  tags = {
    Name = "My-Subnet"
  }
}

resource "aws_route_table" "rta" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "My-Route-table"
  }
}

resource "aws_route_table_association" "rt1" {
  route_table_id = aws_route_table.rta.id
  subnet_id      = aws_subnet.sub1.id
}

resource "aws_security_group" "MySg" {
  vpc_id = aws_vpc.myvpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 8000
    to_port     = 8001
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
    Name = "My-Security-group"
  }
}


# United States as Your VPC # Internet to VPC (Country Border):
# The Internet Gateway is like the country's border. It allows international traffic (data) to enter and leave the United States (VPC). #
# VPC to Subnet (States): # The VPC is the entire country (United States). Subnets are like individual states within the country (California, Texas, etc.). Each state has its own range of zip codes (CIDR block). #
# Route Table (Interstate Highways): # The Route Table is like the network of interstate highways. These highways direct traffic between states and to international airports (internet gateways) for travel outside the country. # # Security Group (State Troopers): 
# The Security Group is like state troopers or border control. They ensure only authorized vehicles (traffic) can enter certain areas. For example, they allow delivery trucks (HTTP) and police cars (SSH) but block unauthorized vehicles. #
# Example Flow: # A tourist (internet traffic) arrives at the U.S. border (Internet Gateway). 
# They are permitted entry and travel on the interstate highways (Route Table) to reach California (Subnet). 
# Once in California, state troopers (Security Group) ensure the tourist follows state laws, 
#allowing them to visit specific attractions (resources) while blocking access to restricted areas.