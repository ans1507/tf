# VPC creation
resource "aws_vpc" "my_vpc" {
  cidr_block       = "${var.vpc_cidr}"
  #instance_tenancy = "default"
  
  tags = {
    Name = "New_vpc"
  }
}
# Create Internet Gateway and attached to VPC
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my_vpc.id
  
  tags = {
    Name = "Internet_gateway"
  }
}
# Subnet creation
resource "aws_subnet" "Public" {
  count = "${length(var.subnet_cidr-pub)}"
  vpc_id = aws_vpc.my_vpc.id
  availability_zone = "${element(var.azs,count.index)}"
  cidr_block = "${element(var.subnet_cidr-pub,count.index)}"
  map_public_ip_on_launch = true
 
  tags = {
    Name = "subnet-${count.index+1}"
  }
}
# create route table and attache to IGW 
resource "aws_route_table" "pub_RT" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "RT"
  }
}
# Associate Route table and subnet
resource "aws_route_table_association" "Associate" {
  count = "${length(var.subnet_cidr-pub)}"
  subnet_id = "${element(aws_subnet.Public.*.id,count.index)}"
  route_table_id = aws_route_table.pub_RT.id
}