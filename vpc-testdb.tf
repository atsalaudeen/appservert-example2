data "aws_availability_zones" "available" {}

# Main  vpc
resource "aws_vpc" "main" {
  cidr_block       = "${var.vpc_cird_block}"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "${var.project_name}"
  }
}

# Create 3 Public subnets

#public Subnet 1
resource "aws_subnet" "public_subnet_1" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${var.vpc_public_subnet1_cird_block}"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "${data.aws_availability_zones.available.names[0]} -- (${var.project_name} public)"
  }
}
#public Subnet 2
resource "aws_subnet" "public_subnet_2" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${var.vpc_public_subnet2_cird_block}"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "${var.project_name}-vpc-public-subnet-2"
    Name = "${data.aws_availability_zones.available.names[1]} -- (${var.project_name} public)"
  }
}

#public Subnet 3
resource "aws_subnet" "public_subnet_3" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${var.vpc_public_subnet3_cird_block}"
  availability_zone = "${data.aws_availability_zones.available.names[2]}"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "${data.aws_availability_zones.available.names[2]} -- (${var.project_name} public)"
  }
}

# Create 3 private subnet 1
resource "aws_subnet" "private_subnet_1" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${var.vpc_private_subnet1_cird_block}"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  tags = {
    Name = "${data.aws_availability_zones.available.names[0]} -- (${var.project_name} private)"
  }
}
# private subnet 2
resource "aws_subnet" "private_subnet_2" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${var.vpc_private_subnet2_cird_block}"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
  tags = {
    Name = "${data.aws_availability_zones.available.names[1]} -- (${var.project_name} private)"
  }
}

# private subnet 3
resource "aws_subnet" "private_subnet_3" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${var.vpc_private_subnet3_cird_block}"
  availability_zone = "${data.aws_availability_zones.available.names[2]}"
  tags = {
    Name = "${data.aws_availability_zones.available.names[2]} -- (${var.project_name} private)"
  }
}

# internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    Name = "${var.project_name}"
  }
}

# NAT Gateway is paid
# ELastic IP for NAT Gateway
#resource "aws_eip" "nat_eip" {
#  vpc      = true
#  depends_on = ["aws_internet_gateway.igw"]
#}

# NAT gateway for private ip address
# Disable for free tier
#resource "aws_nat_gateway" "ngw" {
#  allocation_id = "${aws_eip.nat_eip.id}"
#  subnet_id     = "${aws_subnet.public_subnet_1.id}"
#  depends_on = ["aws_internet_gateway.igw"]
#  tags = {
#    Name = "${var.project_name}-vpc-nat-gw"
#  }
#}

# Route Table for public network

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.main.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags = {
    Name = "${var.project_name} Public Route"
  }
}


# nat gw is paid.
# create a private nat instance and update
resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.main.id}"
  route {
    cidr_block = "0.0.0.0/0"
    # remove later after nat instance is created
    gateway_id = "${aws_internet_gateway.igw.id}"
    # this should be via nat gateway as below
    #gateway_id = "${aws_nat_gateway.ngw.id}"
  }

  tags = {
    Name = "${var.project_name} Private Route - ${data.aws_availability_zones.available.names[0]}"
  }
}
# Route table for Private subnets

# Route Table association with public subnets
resource "aws_route_table_association" "assoc_rtb_public_subnet1" {
  subnet_id      = "${aws_subnet.public_subnet_1.id}"
  route_table_id = "${aws_route_table.public.id}"
}
resource "aws_route_table_association" "assoc_rtb_public_subnet2" {
  subnet_id      = "${aws_subnet.public_subnet_2.id}"
  route_table_id = "${aws_route_table.public.id}"
}
resource "aws_route_table_association" "assoc_rtb_public_subnet3" {
  subnet_id      = "${aws_subnet.public_subnet_3.id}"
  route_table_id = "${aws_route_table.public.id}"
}

# Route table association with private subnets
resource "aws_route_table_association" "assoc_rtb_private_subnet1" {
  subnet_id      = "${aws_subnet.private_subnet_1.id}"
  route_table_id = "${aws_route_table.private.id}"
}
resource "aws_route_table_association" "assoc_rtb_private_subnet2" {
  subnet_id      = "${aws_subnet.private_subnet_2.id}"
  route_table_id = "${aws_route_table.private.id}"
}
resource "aws_route_table_association" "assoc_rtb_private_subnet3" {
  subnet_id      = "${aws_subnet.private_subnet_3.id}"
  route_table_id = "${aws_route_table.private.id}"
}

