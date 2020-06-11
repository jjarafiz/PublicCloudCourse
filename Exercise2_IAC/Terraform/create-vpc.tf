provider "aws" {
  region = var.region
}

resource "aws_vpc" "first_VPC" {
  cidr_block           = var.VPC_cidrblock
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = {
    Name = var.name
  }

}
