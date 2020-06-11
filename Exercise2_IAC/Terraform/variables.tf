
variable "region" {
  type    = string
  default = "eu-central-1"
}

variable "VPC_cidrblock" {
  default = "192.168.1.0/24"
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
  default = "first_vpc"
}
