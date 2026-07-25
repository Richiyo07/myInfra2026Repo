resource "aws_vpc" "sonar" {
  cidr_block = "172.16.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "sonar_vpc"
  }
}

 resource "aws_security_group" "security_sonar_group_2023" {
      name        = "security_sonar_group_2023"
      description = "security group for Sonar"
      ingress {
        from_port   = 9000
        to_port     = 9000
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }

     ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }

     # outbound from Sonar server
      egress {
        from_port   = 0
        to_port     = 65535
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }

      tags= {
        Name = "security_sonar"
      }
    }

    resource "aws_instance" "mySonarInstance" {
      ami           = "ami-0b9064170e32bde34"
      key_name = "your_aws_ssh_key"
      instance_type = "t3.small"
      vpc_security_group_ids = [aws_security_group.security_sonar_group_2023.id]

      tags= {
        Name = "sonar_instance"
      }
    }
