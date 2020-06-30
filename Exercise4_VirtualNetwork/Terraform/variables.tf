
variable "region" {
  type    = string
  default = "eu-central-1"
}
variable "VPC_cidrblock" {
  default = "192.168.1.0/24"
}
variable "pub_sub" {
  default = "192.168.1.0/26"
}
variable "priv_sub" {
  default = "192.168.1.64/26"
}

variable "enable_dns_support" {
  type    = bool
  default = true
}

variable "enable_dns_hostnames" {
  type    = bool
  default = true
}
variable "name" {
  type    = string
  default = "first_vpc_JJ"
}
variable "name_pub" {
  type    = string
  default = "public_subnet_JJ"
}
variable "name_priv" {
  type    = string
  default = "private_subnet_JJ"
}
variable "name_ig" {
  type    = string
  default = "internet_gateway_JJ"
}
variable "name_rt" {
  type    = string
  default = "route_table_JJ"
}
variable "name_web" {
  type    = string
  default = "web_vm_JJ"
}
variable "name_jump" {
  type    = string
  default = "jump_host_JJ"
}
variable "name_privhost" {
  type    = string
  default = "priv_host_JJ"
}

variable "instance_ami" {
	description = "Ubuntu Server 18.04 LTS (64-bit x86)"
	default = "ami-0d359437d1756caa8"
}

variable "instance_type" {
	default = "t2.micro"
}

variable "SSH_key" {
	type = string
	default = "ec2_key"
}





