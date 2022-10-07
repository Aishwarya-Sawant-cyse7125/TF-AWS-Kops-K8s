data "aws_availability_zones" "available" {
  state = "available"
}

# Private subnet for Kubernetes cluster
resource "aws_subnet" "private_subnet_1" {
    vpc_id                  = aws_vpc.vpc.id
    map_public_ip_on_launch = false
    cidr_block              = cidrsubnet(var.vpc_cidr, 8, 0)
    availability_zone       = element(data.aws_availability_zones.available.names, 0)
    tags = {
      Name                                        = "private-subnet-1-${var.clustername}"
      "kubernetes.io/cluster/${var.clustername}"  = "shared"
    }
}

# Public subnet
# resource "aws_subnet" "public_subnet_1" {
#     vpc_id                  = aws_vpc.vpc.id
#     map_public_ip_on_launch = true
#     cidr_block              = cidrsubnet(var.vpc_cidr, 8, 4)
#     availability_zone       = element(data.aws_availability_zones.available.names, 0)
#     tags = {
#       Name                                        = "public-subnet-1-${var.clustername}"
#       "kubernetes.io/cluster/${var.clustername}"  = "shared"
#     }
# }


# Subnet for Bastion
resource "aws_subnet" "bastion_subnet" {
    vpc_id                  = aws_vpc.vpc.id
    map_public_ip_on_launch = true //because we need public ip for bastion
    cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 8, 253)
    availability_zone       = element(data.aws_availability_zones.available.names, 1)
    tags = {
      Name = "bastion-subnet"
    }
}

# Public route table for bastion
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
}

# Private route table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id
}

# Internet gateway
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
}

# # Create elastic ip address
resource "aws_eip" "elastic_ip" {
  vpc = true
}

# Create a nat gateway and attach the bastion subnet
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.elastic_ip.id
  subnet_id = aws_subnet.bastion_subnet.id
  depends_on = [
    aws_internet_gateway.internet_gateway
  ]
}

# Create public route
resource "aws_route" "public_igw_route" {
  route_table_id = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.internet_gateway.id
  depends_on = [
    aws_internet_gateway.internet_gateway
  ]
}

# Create private route
resource "aws_route" "private_natgw_route" {
  route_table_id = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat_gateway.id
  depends_on = [
    aws_nat_gateway.nat_gateway
  ]
}

# Create route table association for public route table
# resource "aws_route_table_association" "public_rt_association" {
#   subnet_id = aws_subnet.public_subnet_1.id
#   route_table_id = aws_route_table.public_route_table.id
# }

# Create route table association for private route table
resource "aws_route_table_association" "private_rt_association" {
  subnet_id = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_route_table.id
}

# Create route table association for bastion host
resource "aws_route_table_association" "bastion_rt_association" {
  subnet_id = aws_subnet.bastion_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}