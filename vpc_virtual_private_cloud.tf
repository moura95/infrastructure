resource "aws_internet_gateway" "igw_crypto_tracker" {
  vpc_id = aws_vpc.vpc_crypto_tracker.id
}

resource "aws_route_table" "rtb_crypto_tracker" {
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_crypto_tracker.id
  }

  vpc_id = aws_vpc.vpc_crypto_tracker.id
}

resource "aws_vpc" "vpc_crypto_tracker" {
  cidr_block           = "172.31.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"
}

resource "aws_subnet" "subnet_1" {
  availability_zone                   = "sa-east-1a"
  cidr_block                          = "172.31.16.0/20"
  map_public_ip_on_launch             = true
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = aws_vpc.vpc_crypto_tracker.id
}

resource "aws_subnet" "subnet_2" {
  availability_zone_id                = "sae1-az1"
  cidr_block                          = "172.31.0.0/20"
  map_public_ip_on_launch             = true
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = aws_vpc.vpc_crypto_tracker.id
}

resource "aws_subnet" "subnet_3" {
  availability_zone                   = "sa-east-1c"
  cidr_block                          = "172.31.32.0/20"
  map_public_ip_on_launch             = true
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = aws_vpc.vpc_crypto_tracker.id
}

resource "aws_security_group" "lb" {
  description = "lb"
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 443
    protocol    = "tcp"
    to_port     = 443
  }

  name   = "lb"
  vpc_id = aws_vpc.vpc_crypto_tracker.id
}

resource "aws_security_group" "sg_rds" {
  description = "open port to postgresql"
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 5432
    protocol    = "tcp"
    to_port     = 5432
  }

  name   = "rds"
  vpc_id = aws_vpc.vpc_crypto_tracker.id
}

resource "aws_security_group" "cluster" {
  description = "cluster"
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 443
    protocol    = "tcp"
    to_port     = 443
  }

  name   = "cluster"
  vpc_id = aws_vpc.vpc_crypto_tracker.id
}
