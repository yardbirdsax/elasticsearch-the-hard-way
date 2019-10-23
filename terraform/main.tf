provider "aws" {
  version = "~> 2.0"
  region = "us-east-1"
}

locals {
  tagName = "es-lab"
  keyName = "${local.tagName}-keyPair"
}

resource aws_vpc "vpc" {
  cidr_block = var.cidrBlock
  tags = {
    name = local.tagName
  }
  enable_dns_hostnames = true
}

resource aws_subnet "es-labSubnet" {
  cidr_block = var.cidrBlock
  vpc_id = aws_vpc.vpc.id
  tags = {
    name = local.tagName
  }
}

resource aws_security_group "es-labSG" {
  
  vpc_id = aws_vpc.vpc.id
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [aws_vpc.vpc.cidr_block]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource aws_internet_gateway "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    name = local.tagName
  }
}

data aws_ami "ubuntu" {
  most_recent = true

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
  owners = ["099720109477"]
}

resource aws_key_pair "es-labKeyPair" {
  key_name = local.keyName
  public_key = file(var.sshPubKeyFilePath)
}

module "masterNode" {
  source = "./modules/node-module"

  amiId = data.aws_ami.ubuntu.id
  instanceName = "es-master"
  nodeCount = var.nodeCount
  subnetId = aws_subnet.es-labSubnet.id
  securityGroupId = aws_security_group.es-labSG.id
  keyName = aws_key_pair.es-labKeyPair.key_name
  nodeSize = var.nodeSize
}

resource aws_route_table "es-labRouteTable" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }  
  tags = {
    Name = "${local.tagName}-RouteTable"
  }
}

resource aws_route_table_association "es-labRouteTableAssociation" {
  route_table_id = aws_route_table.es-labRouteTable.id
  subnet_id = aws_subnet.es-labSubnet.id
}

output "dnsNames" {
  value = module.masterNode.dnsNames
}