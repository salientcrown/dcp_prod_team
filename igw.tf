
resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "igw-${var.env}"
  }
}