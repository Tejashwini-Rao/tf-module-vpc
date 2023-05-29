resource "aws_vpc" "main" {
  cidr_block = "var.vpc_cidr_block"
  tags= {
    name = "${var.env}-vpc"
  }
}

module "subnet" {
  for_each = var.subnets
  source    = "./subnets"
  name = each.value["name"]
  subnets= each.value["subnet_cidr"]
  vpc_id = aws_vpc.main.id
  az= var.az
  ngw= try(each.value["ngw"],false)
  igw= try(each.value["igw"],false)
  env=var.env

}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "$(var.env)-igw"
  }
}