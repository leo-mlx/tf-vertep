# Create a VPC
resource "aws_vpc" "VPN_attached_network" {
  cidr_block = var.vpc_CIDR
}

# Create a Subnet for instances
resource "aws_subnet" "public-subnet" {
  cidr_block        = var.subnet_CIDR
  vpc_id            = aws_vpc.VPN_attached_network.id
  availability_zone = var.vpc_zone
  depends_on        = [
    aws_vpc.VPN_attached_network
  ]
}

# Create static IP for VPN
resource "aws_eip" "ip-vpn" {
  instance   = aws_instance.vpn.id
  depends_on = [
    aws_instance.vpn
  ]
}

# Create static IP for Gitlab (will be removed later after VPN will start to work)
resource "aws_eip" "ip-gitlab" {
  instance   = aws_instance.gitlab.id
  depends_on = [
    aws_instance.gitlab
  ]
}

# Create Internet gateway for VPN
resource "aws_internet_gateway" "vpn-gw" {
  vpc_id = aws_vpc.VPN_attached_network.id
  tags   = {
    Name = var.vpn_server_tag
  }
  depends_on        = [
    aws_vpc.VPN_attached_network
  ]
}

# Create a routing table
resource "aws_route_table" "route-table-vpn" {
  vpc_id = aws_vpc.VPN_attached_network.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpn-gw.id
  }

  tags = {
    Name = var.vpn_server_tag
  }

  depends_on   = [
    aws_internet_gateway.vpn-gw
  ]
}

# Route table assositation
resource "aws_route_table_association" "subnet-association" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.route-table-vpn.id

  depends_on     = [
    aws_route_table.route-table-vpn
  ]
}
