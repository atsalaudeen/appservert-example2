resource "aws_security_group" "sg-sgallowhttpfromall" {
  tags = {
    Name = "HTTP (testapp-production)"
  }
  name = "testapp-production-vpc-sgallowhttperomeverywhere-4VMB2RXY06CY"
  description = "Allow HTTP from everywhere"
  vpc_id      = "${aws_vpc.main.id}"

# update this to your host ip or open vpc access
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

