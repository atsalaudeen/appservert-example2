resource "aws_security_group" "testapp-prod-bastion" {
  tags = {
    Name = "testapp-prod-bastion"
  }
  name = "testapp-prod-bastion"
  description = "testapp-prod-bastion"
  vpc_id      = "${aws_vpc.main.id}"

# update this to your host ip or open vpc access
  ingress {
    from_port = 22
    to_port = 22
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

