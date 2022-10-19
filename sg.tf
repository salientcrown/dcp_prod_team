
locals {

  ssh_to   = 22
  ssh_from = 22

  http_to   = 80
  http_from = 80

}

resource "aws_security_group" "sg" {
  name        = "master_sg"
  description = "Access to the Baston host, EC2_instances"
  vpc_id      = aws_vpc.vpc.id


  ingress {
    description = "SSH Access"
    from_port   = local.ssh_from
    to_port     = local.ssh_to
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP Access"
    from_port   = local.http_from
    to_port     = local.http_to
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}_sg"
  }
}