resource "aws_security_group" "production-vpc-allowall-sg" {
  tags = {
    Name = "vpc-allowall-sg"
  }
  name = "vpc-allowall-sg"
  description = "Allow all from within the VPC"
  vpc_id      = "${aws_vpc.main.id}"


  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["10.109.0.0/16"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

