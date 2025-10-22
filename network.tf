resource "aws_vpc" "vpc" {
  cidr_block = "10.10.0.0/16"
  tags = {
    Name = "gh_runners_vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "gh_runners_igw"
  }
}

resource "aws_subnet" "sb_pub" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.10.1.0/24"
  tags = {
    Name = "gh_runners_sb_pub"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "gh_runners_rt"
  }
}

resource "aws_route_table_association" "sb_rt_assoc" {
  subnet_id      = aws_subnet.sb_pub.id
  route_table_id = aws_route_table.rt.id
}
