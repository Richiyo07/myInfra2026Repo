resource "aws_instance" "mySonarInstance" {
      ami           = "ami-0ea1cddefe0c4aed5"
      key_name = var.key_name
      instance_type = "t2.micro"
      vpc_security_group_ids = [aws_security_group.sonar-sg-2022.id]
      tags= {
        Name = "sonar_instance"
      }
    }

resource "aws_security_group" "sonar_sg" {
  name        = "sonar-sg"
  description = "Security group for SonarQube server"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["3.15.216.238"] # Replace with your public IP
  }

  ingress {
    description = "SonarQube Web UI"
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Restrict if possible
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sonar-sg"
  }
}

# Create Elastic IP address for Sonar instance
resource "aws_eip" "mySonarInstance" {
domain     = "vpc"
  instance = aws_instance.mySonarInstance.id
tags= {
    Name = "sonar-eip"
  }
}
