resource "aws_security_group" "sg-testapp-ssh-in" {
  tags = {
    Name = "testapp-ssh-in"
  }
  name = "testapp-ssh-in"
  description = "testapp-ssh-in"
  vpc_id      = "${aws_vpc.main.id}"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["10.10.0.0/16"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["10.250.0.0/16"]
    description = "mgmt network"
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

