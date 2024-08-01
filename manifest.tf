# Specify the provider
provider "aws" {
  region = "us-east-2"  
}

# Create a security group allowing SSH access
resource "aws_security_group" "instance_sg" {
  name        = "instance-sg"
  description = "Allow SSH access"
  
  ingress {
    from_port   = 22
    to_port     = 22
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

# Create an EC2 instance 
resource "aws_instance" "prod_server" {
  ami           = "ami-0c55b159cbfafe1f0"             
  instance_type = "t2.medium"
  key_name      = "sk-test"  
  security_groups = [aws_security_group.instance_sg.name]

  tags = {
    Name = "Prod-server"
  }
}

resource "aws_instance" "grafana" {
  ami           = "ami-0c55b159cbfafe1f0"             
  instance_type = "t2.micro"
  key_name      = "sk-test"  
  security_groups = [aws_security_group.instance_sg.name]

  tags = {
    Name = "Grafana"
  }
}

# Allocate an Elastic IP
resource "aws_eip" "instance_eip" {
  instance = aws_instance.prod_server.id
}

