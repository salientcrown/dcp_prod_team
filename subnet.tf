# --------------------------------------------------------------------------------------------------------------
#                     PUBLIC SUBNET
# --------------------------------------------------------------------------------------------------------------

resource "aws_subnet" "public" {
  count                   = var.az_count
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 3, var.az_count + count.index)
  availability_zone       = slice(data.aws_availability_zones.az.names, 0, 2)[count.index]
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = true
  tags = {
    Name = "PublicSubnet_${var.env}_${count.index + 1}"
  }
}


# --------------------------------------------------------------------------------------------------------------
#                     PRIVATE SUBNET
# --------------------------------------------------------------------------------------------------------------

resource "aws_subnet" "private" {
  count                   = var.az_count + 2
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 6, var.az_count + count.index)
  availability_zone       = element(slice(data.aws_availability_zones.az.names, 0, 2), count.index)
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = true
  tags = {
    Name = "PrivteSubnet_${var.env}_${count.index + 1}"
  }
}