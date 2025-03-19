resource "aws_vpc" "open-tel-vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support = var.enable_dns_support
  
  tags = {
    Name = var.vpc_name
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}
resource "aws_subnet" "open-tel-pub-subnet" {
  count = length(var.pub_subnet_cidr)
  vpc_id = aws_vpc.open-tel-vpc.id
  cidr_block = var.pub_subnet_cidr[count.index]
  map_public_ip_on_launch = true
  availability_zone = var.pub_subnet_az[count.index]
  tags = {
    Name = var.pub_subnet_name[count.index]
    "kubernetes.io/role/elb"        = "1"
    "kubernetes.io/cluster/${var.cluster_name}"   = "shared"
  }
}
resource "aws_subnet" "open-tel-priv-subnet" {
  count = length(var.priv_subnet_cidr)
  vpc_id = aws_vpc.open-tel-vpc.id
  cidr_block = var.priv_subnet_cidr[count.index]
  map_public_ip_on_launch = false
  availability_zone = var.priv_subnet_az[count.index]
  tags = {
    Name = var.priv_subnet_name[count.index]
    "kubernetes.io/role/internal-elb"    = "1" 
    "kubernetes.io/cluster/${var.cluster_name}"   = "shared"
  }
}
resource "aws_internet_gateway" "open-tel-igw" {
  vpc_id = aws_vpc.open-tel-vpc.id
  tags = {
    Name = var.igw_name
  }
}
resource "aws_route_table" "open-tel-pub-rt" {
  vpc_id = aws_vpc.open-tel-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.open-tel-igw.id
  }
  tags ={
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}
resource "aws_route_table_association" "open-tel-pub-rt-assoc" {
  count = length(var.pub_subnet_cidr)
  subnet_id = aws_subnet.open-tel-pub-subnet[count.index].id
  route_table_id = aws_route_table.open-tel-pub-rt.id
}

// Add NAT Gateway and Elastic IP
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "open-tel-nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.open-tel-pub-subnet[0].id

  tags = {
    Name = "${var.vpc_name}-nat"
  }
}

// Add private route table
resource "aws_route_table" "open-tel-priv-rt" {
  vpc_id = aws_vpc.open-tel-vpc.id
  
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.open-tel-nat.id
  }

  tags = {
    Name = "${var.vpc_name}-private-rt"
  }
}

// Update private subnet route table association
resource "aws_route_table_association" "open-tel-priv-rt-assoc" {
  count = length(var.priv_subnet_cidr)
  subnet_id      = aws_subnet.open-tel-priv-subnet[count.index].id
  route_table_id = aws_route_table.open-tel-priv-rt.id
}
