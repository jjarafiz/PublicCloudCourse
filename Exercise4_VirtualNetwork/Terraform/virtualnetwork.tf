provider "aws" {
  region = var.region
}

##############
# SSH Key Pair
##############
resource "aws_key_pair" "keys" {
  key_name   = "JJKey"
  public_key = file("KeyPairJJ.pub")
}

#####
# VPC
#####

resource "aws_vpc" "first_VPC" {
  cidr_block           = var.VPC_cidrblock
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = {
    Name = var.name
  }

}
###############
# Public Subnet
###############

resource "aws_subnet" "pub_sub" {
  vpc_id                  = aws_vpc.first_VPC.id
  cidr_block              = var.pub_sub
  map_public_ip_on_launch = true
  tags = {
    Name = var.name_pub
  }
}

################
# Private Subnet
################

resource "aws_subnet" "priv_sub" {
  vpc_id                  = aws_vpc.first_VPC.id
  cidr_block              = var.priv_sub
  map_public_ip_on_launch = true
  tags = {
    Name = var.name_priv
  }
}
#############
# Route Table
#############

resource "aws_route_table" "rou_tab" {
  vpc_id = aws_vpc.first_VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.int_gw.id
  }
  tags = {
    Name = var.name_rt
  }
}
###############
# Default Route
###############
resource "aws_internet_gateway" "int_gw" {
  vpc_id = aws_vpc.first_VPC.id
  tags = {
    Name = var.name_ig
  }
}
#########################
# Route Table Association
#########################

resource "aws_route_table_association" "rt_assoc" {
  subnet_id      = aws_subnet.pub_sub.id
  route_table_id = aws_route_table.rou_tab.id
}
################
# Security Group
################

resource "aws_security_group" "web_sg" {
  name = "web security group"
  vpc_id = aws_vpc.first_VPC.id
  description = "Allow http, https and SSH to the web server"
  
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
  
}

################
# Elastic IP Web
################
resource "aws_eip" "elast_ip" {
  vpc        = true
  network_interface = aws_network_interface.elast_int.id
}
#######################
# Elastic Interface Web
#######################
resource "aws_network_interface" "elast_int" {
  subnet_id = aws_subnet.pub_sub.id
  security_groups = [aws_security_group.web_sg.id]
}

#################
# Elastic IP Jump
#################
resource "aws_eip" "elast_ip_jump" {
  vpc        = true
  network_interface = aws_network_interface.elast_int_jump.id
}
########################
# Elastic Interface Jump
########################
resource "aws_network_interface" "elast_int_jump" {
  subnet_id = aws_subnet.pub_sub.id
  security_groups = [aws_security_group.web_sg.id]
}

############
# Web Server
############

resource "aws_instance" "WebVM" {
  ami = var.instance_ami
  instance_type = var.instance_type
  key_name = aws_key_pair.keys.id
  user_data                   = file("install_apache.sh")
  network_interface {
  	network_interface_id = aws_network_interface.elast_int.id
  	device_index = 0
  }
   tags = {
    Name = var.name_web
  }
}

#########################
# Jump Host Public Subnet
#########################

resource "aws_instance" "JumpHost" {
  ami = var.instance_ami
  instance_type = var.instance_type
  key_name = aws_key_pair.keys.id
  network_interface {
  	network_interface_id = aws_network_interface.elast_int_jump.id
  	device_index = 0
  }
  tags = {
    Name = var.name_jump
  }
}

##########################
# Host Private Subnet
##########################

resource "aws_instance" "PrivHost" {
  ami = var.instance_ami
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  subnet_id = aws_subnet.priv_sub.id
  key_name = aws_key_pair.keys.id
  tags = {
    Name = var.name_privhost
  }
}