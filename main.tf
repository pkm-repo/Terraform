provider "aws" {
  region = "eu-north-1"  # Change to your preferred region
}

# Security Group
resource "aws_security_group" "web_sg2" {
  name        = "web_sg2"
  description = "Allow SSH and HTTP"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance
resource "aws_instance" "web" {
  ami                    = "ami-02a8c5a3865cd8c7f"
  instance_type          = "t3.micro"
  key_name               = "Demo1"
  vpc_security_group_ids = [aws_security_group.web_sg2.id]

  tags = {
    Name = "EC2"
  }
}

# S3 Bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "pkmbucket15" 

  tags = {
    Name = "MyS3Bucket"
  }
}

