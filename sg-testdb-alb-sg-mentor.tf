resource "aws_security_group" "testapp-alb-sg-myapp" {
  tags = {
    Name = "testapp-alb-sg-myapp"
  }
  name = "testapp-alb-sg-myapp"
  description = "testapp-alb-sg-myapp"
  vpc_id      = "${aws_vpc.main.id}"

# update this to your host ip or open vpc access
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["10.0.1.190/32"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["10.0.1.109/32"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

