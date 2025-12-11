provider "aws" {
  region = var.region
}

resource "aws_vpc" "this" {
  cidr_block           = var.cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    var.tags,
    {
      Name = coalesce(lookup(var.tags, "Name", null), "vpc-main")
    }
  )
}

resource "aws_subnet" "this" {
  for_each = {
    for cidr_block in var.subnets :
    cidr_block => cidr_block
  }

  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value
  map_public_ip_on_launch = var.public_ip_on_launch

  tags = merge(
    var.tags,
    {
      Name = "subnet-${replace(each.value, "/", "-")}"
    }
  )
}