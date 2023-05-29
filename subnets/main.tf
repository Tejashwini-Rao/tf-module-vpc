resource "aws_subnet" "main" {
  count= length(var.subnets)
  vpc_id     = var.vpc_id
  cidr_block = element(var.subnets[count.index] )
  availability_zone = var.az[count.index]

  tags = {
    Name = "${var.name}-subnet"
  }
}