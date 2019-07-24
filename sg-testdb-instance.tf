resource "aws_security_group" "testapp-instance-sg" {
  tags = {
    Name = "${var.project_name}-testappinstance-sg"
  }
  name = "testapp-instance-sg"
  description = "Allow HTTP access to testapp-instance"
  vpc_id      = "${aws_vpc.main.id}"

# update this to your host ip or open vpc access
  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["${var.open_vpn}"]
    description = "OpenVPN NAT gateway"
  }
# Add Application Load balancer access, should accept http only from load balancer only

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = ["${aws_security_group.testapp-alg-sg.id}"]
    description = "VPN NAT IP"
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = ["${aws_security_group.testapp-alb-sg-myapp.id}"]
    description = "myapp prod"
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = ["${aws_security_group.testapp-alb-sg-ulms.id}"]
    description = "ULMS Prod"
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = ["${aws_security_group.testapp-alb-sg-vrm.id}"]
    description = "vrm DC"
  }



# TEMPORARY SSH ACCESS 
# remove or narrow to desired sg

 ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    #security_groups = ["sg-0fca1a86b3f4ebd6f"]
    #security_groups = ["${aws_security_group.tf-mgmtserver-sg.id}"]
  }

 egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

