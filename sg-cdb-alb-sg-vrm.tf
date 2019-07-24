resource "aws_security_group" "testapp-alb-sg-vrm" {
  tags = {
    Name = "testapp-alb-sg-vrm"
  }
  name = "testapp-alb-sg-vrm"
  description = "testapp-alb-sg-vrm"
  vpc_id      = "${aws_vpc.main.id}"

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["10.0.1.224/28"]
    description = "vrm DC subnet"
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["10.0.1.130/32"]
    description = "UK Office"
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["10.0.2.130/32"]
    description = "VRM AWS subnet"
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["10.0.1.187/32"]
    description = "VRM AWS subnet"
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["10.0.1.168/32"]
    description = "VRM aws-staging subnet"
  }


  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

