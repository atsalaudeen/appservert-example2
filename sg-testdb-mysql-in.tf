resource "aws_security_group" "testapp-mysql-in" {
  tags = {
    Name = "${var.project_name}-mysql-in-sg"
  }
  name = "testapp-mysql-in"
  description = "testapp-mysql-in"
  vpc_id      = "${aws_vpc.main.id}"

  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["${var.open_vpn}"]
    description = "OpenVPN Access"
  }
  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["${var.vpc_cird_block}"]
  }
# mysql access to webservers
  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    security_groups = ["${aws_security_group.testapp-instance-sg.id}"]
    description = "testapp-instance-sg"
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

