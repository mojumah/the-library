terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "eu-west-2"
}

resource "aws_vpc" "fdr" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "fdr"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.fdr.id

  tags = {
    Name = "fdr-gw"
  }
}

resource "aws_subnet" "es1" {
  vpc_id = aws_vpc.fdr.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "es1"
  }
  
}

resource "aws_subnet" "es2" {
  vpc_id = aws_vpc.fdr.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "es2"
  }
  
}

resource "aws_route_table" "es1" {
  vpc_id = aws_vpc.fdr.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "es1 route table"
  }

}

resource "aws_route_table_association" "es1" {
  subnet_id = "${aws_subnet.es1.id}"
  route_table_id = "${aws_route_table.es1.id}"
  
}

resource "aws_route_table" "es2" {
  vpc_id = aws_vpc.fdr.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "es2 route table"
  }
  
}

resource "aws_route_table_association" "es2" {
  subnet_id = "${aws_subnet.es2.id}"
  route_table_id = "${aws_route_table.es2.id}"
}