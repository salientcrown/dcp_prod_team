# --------------------------------------------------------------------------------------------------------------
#                     ROUTE TABLE
# --------------------------------------------------------------------------------------------------------------

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myigw.id
  }
  tags = {
    Name = "${var.env}public_route_table"
  }
}
resource "aws_route_table_association" "pub_route-association" {
  count = var.az_count

  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = element(aws_route_table.public_route_table.*.id, count.index)
}

# Elastic IP configuration
resource "aws_eip" "eip" {
  count = var.az_count

  vpc        = true
  depends_on = [aws_internet_gateway.myigw]
  tags = {
    Name = "${var.env}_eip_${count.index + 1}"
  }
}
# --------------------------------------------------------------------------------------------------------------
#                     NAT GATEWAY
# --------------------------------------------------------------------------------------------------------------

resource "aws_nat_gateway" "nat" {
  count         = var.az_count
  subnet_id     = element(aws_subnet.public.*.id, count.index)
  allocation_id = element(aws_eip.eip.*.id, count.index)
  tags = {
    Name = "${var.env}_NatGateway_${count.index + 1}"
  }
}

# --------------------------------------------------------------------------------------------------------------
#                    PRIVATE ROUTE TABLE
# --------------------------------------------------------------------------------------------------------------

resource "aws_route_table" "private-route-table" {
  count  = var.az_count
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.nat.*.id, count.index)
  }
  tags = {
    Name = "${var.env}_PrivateRouteTable_${count.index + 1}"
  }
}


resource "aws_route_table_association" "route-association" {
  count          = var.az_count
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private-route-table.*.id, count.index)
}