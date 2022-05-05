############################################################
# VPC
############################################################

#########################
# Local values
#########################

locals {
  vpc_cidr_block = "${var.vpc_net_address}/${var.vpc_netid_bits}"
}

#########################
# VPC
#########################

resource "aws_vpc" "main" {
  cidr_block           = local.vpc_cidr_block
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.aws_resource_prefix}main",
  }
}

#########################
# Subnets
#########################

resource "aws_subnet" "public" {
  count                   = var.vpc_subnet_count
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(local.vpc_cidr_block, var.vpc_subnetid_bits, count.index)
  availability_zone       = element(var.aws_az_names, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name          = "${var.aws_resource_prefix}pub-subnet-${count.index + 1}",
    NetworkAccess = "public",
  }
}

resource "aws_subnet" "private" {
  count                   = var.vpc_subnet_count
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(local.vpc_cidr_block, var.vpc_subnetid_bits, count.index + var.vpc_subnet_count)
  availability_zone       = element(var.aws_az_names, count.index)
  map_public_ip_on_launch = false

  tags = {
    Name          = "${var.aws_resource_prefix}prv-subnet-${count.index + 1}",
    NetworkAccess = "private",
  }
}

#########################
# Internet gateway
#########################

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.aws_resource_prefix}igw",
  }
}

#########################
# Elastic IPs
#########################

resource "aws_eip" "natgw" {
  depends_on = [aws_internet_gateway.igw]
  vpc        = true

  tags = {
    Name        = "${var.aws_resource_prefix}natgw",
  }
}

#########################
# NAT gateway
#########################

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.natgw.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name        = "${var.aws_resource_prefix}natgw",
  }
}


#########################
# Routing tables
#########################

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name        = "${var.aws_resource_prefix}routes-public",
  }
}

resource "aws_route_table" "nat" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw.id
  }

  tags = {
    Name        = "${var.aws_resource_prefix}routes-nat",
  }
}

#########################
# Routing table associations
#########################

resource "aws_route_table_association" "public_subnet_routes" {
  count          = var.vpc_subnet_count
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_subnet_routes" {
  count          = var.vpc_subnet_count
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.nat.id
}
