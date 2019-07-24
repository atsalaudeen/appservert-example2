resource "aws_security_group" "testapp-alb-sg-ulms" {
  tags = {
    Name = "${var.project_name}-testapp-alb-sg-ulms"
  }
  name = "testapp-alb-sg-ulms"
  description = "testapp-alb-sg-ulms"
  vpc_id      = "${aws_vpc.main.id}"

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["10.0.1.220/32"]
  }


  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

