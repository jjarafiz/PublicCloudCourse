
variable "region" {
  type    = string
  default = "eu-central-1"
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





