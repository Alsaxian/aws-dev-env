resource "aws_vpc" "xitry_dev_vpc" {
  cidr_block           = "10.123.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "devVPC"
  }
}

resource "aws_subnet" "xitry_dev_subnet" {
  vpc_id                  = aws_vpc.xitry_dev_vpc.id
  cidr_block              = "10.123.10.0/24"
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true
  tags = {
    Name = "dev-public-subnet"
  }

}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.xitry_dev_vpc.id

  tags = {
    Name = "devIGW"
  }

}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.xitry_dev_vpc.id

  tags = {
    Name = "dev-public-route-table"
  }

}

resource "aws_route" "public_default_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_route_table_association" {
  subnet_id      = aws_subnet.xitry_dev_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}