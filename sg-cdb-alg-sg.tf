resource "aws_security_group" "testapp-alg-sg" {
  tags = {
    Name = "${var.project_name}-testapp-alg-sg"
  }
  name = "testapp-alg-sg"
  description = "testapp-alg-sg"
  vpc_id      = "${aws_vpc.main.id}"

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

