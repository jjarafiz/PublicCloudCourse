# Deploy a Virtual Network Infrastructure

This is the fourth exercise of the course.

The list of tasks:


   * Create a VPC and two subnets (public and private).
   * Create Internet Gateway and associate it with the VPC
   * Create a route table for the public subnet and add a default route pointing to the Internet gateway
   * Adjust the default security group to allow HTTP, HTTPS and SSH access to all virtual machines. Use GUI if necessary.
   * Deploy a web server in the public subnet (use the tools you created in the previous exercise to deploy it).
   * Deploy an SSH jump host in the public subnet.
   * Deploy another VM instance in the private subnet.


Optional:

   * Create an elastic IP address and an elastic network interface.

There are also a set of connectivity tests:


  * You can open SSH session to web server and jump host from the Internet;
  * You can download a web page from the web server;
  * Jump host can open SSH session to VM instance in the private subnet;
  * The VM instance in the private subnet cannot reach destinations outside of your virtual network.


## Configuration Applied
~~~
$ terraform validate
Success! The configuration is valid.

$ terraform apply

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_eip.elast_ip will be created
  + resource "aws_eip" "elast_ip" {
      + allocation_id     = (known after apply)
      + association_id    = (known after apply)
      + customer_owned_ip = (known after apply)
      + domain            = (known after apply)
      + id                = (known after apply)
      + instance          = (known after apply)
      + network_interface = (known after apply)
      + private_dns       = (known after apply)
      + private_ip        = (known after apply)
      + public_dns        = (known after apply)
      + public_ip         = (known after apply)
      + public_ipv4_pool  = (known after apply)
      + vpc               = true
    }

  # aws_eip.elast_ip_jump will be created
  + resource "aws_eip" "elast_ip_jump" {
      + allocation_id     = (known after apply)
      + association_id    = (known after apply)
      + customer_owned_ip = (known after apply)
      + domain            = (known after apply)
      + id                = (known after apply)
      + instance          = (known after apply)
      + network_interface = (known after apply)
      + private_dns       = (known after apply)
      + private_ip        = (known after apply)
      + public_dns        = (known after apply)
      + public_ip         = (known after apply)
      + public_ipv4_pool  = (known after apply)
      + vpc               = true
    }

  # aws_instance.JumpHost will be created
  + resource "aws_instance" "JumpHost" {
      + ami                          = "ami-0d359437d1756caa8"
      + arn                          = (known after apply)
      + associate_public_ip_address  = (known after apply)
      + availability_zone            = (known after apply)
      + cpu_core_count               = (known after apply)
      + cpu_threads_per_core         = (known after apply)
      + get_password_data            = false
      + host_id                      = (known after apply)
      + id                           = (known after apply)
      + instance_state               = (known after apply)
      + instance_type                = "t2.micro"
      + ipv6_address_count           = (known after apply)
      + ipv6_addresses               = (known after apply)
      + key_name                     = (known after apply)
      + network_interface_id         = (known after apply)
      + outpost_arn                  = (known after apply)
      + password_data                = (known after apply)
      + placement_group              = (known after apply)
      + primary_network_interface_id = (known after apply)
      + private_dns                  = (known after apply)
      + private_ip                   = (known after apply)
      + public_dns                   = (known after apply)
      + public_ip                    = (known after apply)
      + security_groups              = (known after apply)
      + subnet_id                    = (known after apply)
      + tags                         = {
          + "Name" = "jump_host_JJ"
        }
      + tenancy                      = (known after apply)
      + volume_tags                  = (known after apply)
      + vpc_security_group_ids       = (known after apply)

      + ebs_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + snapshot_id           = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }

      + ephemeral_block_device {
          + device_name  = (known after apply)
          + no_device    = (known after apply)
          + virtual_name = (known after apply)
        }

      + metadata_options {
          + http_endpoint               = (known after apply)
          + http_put_response_hop_limit = (known after apply)
          + http_tokens                 = (known after apply)
        }

      + network_interface {
          + delete_on_termination = false
          + device_index          = 0
          + network_interface_id  = (known after apply)
        }

      + root_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }
    }

  # aws_instance.PrivHost will be created
  + resource "aws_instance" "PrivHost" {
      + ami                          = "ami-0d359437d1756caa8"
      + arn                          = (known after apply)
      + associate_public_ip_address  = (known after apply)
      + availability_zone            = (known after apply)
      + cpu_core_count               = (known after apply)
      + cpu_threads_per_core         = (known after apply)
      + get_password_data            = false
      + host_id                      = (known after apply)
      + id                           = (known after apply)
      + instance_state               = (known after apply)
      + instance_type                = "t2.micro"
      + ipv6_address_count           = (known after apply)
      + ipv6_addresses               = (known after apply)
      + key_name                     = (known after apply)
      + network_interface_id         = (known after apply)
      + outpost_arn                  = (known after apply)
      + password_data                = (known after apply)
      + placement_group              = (known after apply)
      + primary_network_interface_id = (known after apply)
      + private_dns                  = (known after apply)
      + private_ip                   = (known after apply)
      + public_dns                   = (known after apply)
      + public_ip                    = (known after apply)
      + security_groups              = (known after apply)
      + source_dest_check            = true
      + subnet_id                    = (known after apply)
      + tags                         = {
          + "Name" = "priv_host_JJ"
        }
      + tenancy                      = (known after apply)
      + volume_tags                  = (known after apply)
      + vpc_security_group_ids       = (known after apply)

      + ebs_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + snapshot_id           = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }

      + ephemeral_block_device {
          + device_name  = (known after apply)
          + no_device    = (known after apply)
          + virtual_name = (known after apply)
        }

      + metadata_options {
          + http_endpoint               = (known after apply)
          + http_put_response_hop_limit = (known after apply)
          + http_tokens                 = (known after apply)
        }

      + network_interface {
          + delete_on_termination = (known after apply)
          + device_index          = (known after apply)
          + network_interface_id  = (known after apply)
        }

      + root_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }
    }

  # aws_instance.WebVM will be created
  + resource "aws_instance" "WebVM" {
      + ami                          = "ami-0d359437d1756caa8"
      + arn                          = (known after apply)
      + associate_public_ip_address  = (known after apply)
      + availability_zone            = (known after apply)
      + cpu_core_count               = (known after apply)
      + cpu_threads_per_core         = (known after apply)
      + get_password_data            = false
      + host_id                      = (known after apply)
      + id                           = (known after apply)
      + instance_state               = (known after apply)
      + instance_type                = "t2.micro"
      + ipv6_address_count           = (known after apply)
      + ipv6_addresses               = (known after apply)
      + key_name                     = (known after apply)
      + network_interface_id         = (known after apply)
      + outpost_arn                  = (known after apply)
      + password_data                = (known after apply)
      + placement_group              = (known after apply)
      + primary_network_interface_id = (known after apply)
      + private_dns                  = (known after apply)
      + private_ip                   = (known after apply)
      + public_dns                   = (known after apply)
      + public_ip                    = (known after apply)
      + security_groups              = (known after apply)
      + subnet_id                    = (known after apply)
      + tags                         = {
          + "Name" = "web_vm_JJ"
        }
      + tenancy                      = (known after apply)
      + user_data                    = "35773d885a9c11d983f3da3fc6fe5b346d96c785"
      + volume_tags                  = (known after apply)
      + vpc_security_group_ids       = (known after apply)

      + ebs_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + snapshot_id           = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }

      + ephemeral_block_device {
          + device_name  = (known after apply)
          + no_device    = (known after apply)
          + virtual_name = (known after apply)
        }

      + metadata_options {
          + http_endpoint               = (known after apply)
          + http_put_response_hop_limit = (known after apply)
          + http_tokens                 = (known after apply)
        }

      + network_interface {
          + delete_on_termination = false
          + device_index          = 0
          + network_interface_id  = (known after apply)
        }

      + root_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }
    }

  # aws_internet_gateway.int_gw will be created
  + resource "aws_internet_gateway" "int_gw" {
      + arn      = (known after apply)
      + id       = (known after apply)
      + owner_id = (known after apply)
      + tags     = {
          + "Name" = "internet_gateway_JJ"
        }
      + vpc_id   = (known after apply)
    }

  # aws_key_pair.keys will be created
  + resource "aws_key_pair" "keys" {
      + arn         = (known after apply)
      + fingerprint = (known after apply)
      + id          = (known after apply)
      + key_name    = "JJKey"
      + key_pair_id = (known after apply)
      + public_key  = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCABgEv5E5+h5+wOnH+wtvRgIOHZbjB1rsKDVtUwNOsCo6dCtfTMVvyHKCePKbnh5cX2HacNQPfoBKPxmb/cqf4WqFRSEys/GDKW/AWJ09P7uzYKMi7La8gd+ljzd7rbscac3EsSuN4ufcNjclcWxIsKAt1O4NjVrggtNLRhecqlAF6DwuaJlfBCr390BuvPQ3MQ2WJPTtcpQUDfTxfi4OiBdC9d9ip4WjLqm3UM1Fo5Q6A77VzLrxEd5YzwWeNjPX1L6LVZ215W+VdyL2LwpFpbYfWcovJ3T6AKH0Xma25kD11ugPrdKgSR5DpXHCd3t5PlI7srG6smFEYaCKGlRWd"
    }

  # aws_network_interface.elast_int will be created
  + resource "aws_network_interface" "elast_int" {
      + id                = (known after apply)
      + mac_address       = (known after apply)
      + outpost_arn       = (known after apply)
      + private_dns_name  = (known after apply)
      + private_ip        = (known after apply)
      + private_ips       = (known after apply)
      + private_ips_count = (known after apply)
      + security_groups   = (known after apply)
      + source_dest_check = true
      + subnet_id         = (known after apply)

      + attachment {
          + attachment_id = (known after apply)
          + device_index  = (known after apply)
          + instance      = (known after apply)
        }
    }

  # aws_network_interface.elast_int_jump will be created
  + resource "aws_network_interface" "elast_int_jump" {
      + id                = (known after apply)
      + mac_address       = (known after apply)
      + outpost_arn       = (known after apply)
      + private_dns_name  = (known after apply)
      + private_ip        = (known after apply)
      + private_ips       = (known after apply)
      + private_ips_count = (known after apply)
      + security_groups   = (known after apply)
      + source_dest_check = true
      + subnet_id         = (known after apply)

      + attachment {
          + attachment_id = (known after apply)
          + device_index  = (known after apply)
          + instance      = (known after apply)
        }
    }

  # aws_route_table.rou_tab will be created
  + resource "aws_route_table" "rou_tab" {
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + route            = [
          + {
              + cidr_block                = "0.0.0.0/0"
              + egress_only_gateway_id    = ""
              + gateway_id                = (known after apply)
              + instance_id               = ""
              + ipv6_cidr_block           = ""
              + nat_gateway_id            = ""
              + network_interface_id      = ""
              + transit_gateway_id        = ""
              + vpc_peering_connection_id = ""
            },
        ]
      + tags             = {
          + "Name" = "route_table_JJ"
        }
      + vpc_id           = (known after apply)
    }

  # aws_route_table_association.rt_assoc will be created
  + resource "aws_route_table_association" "rt_assoc" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # aws_security_group.web_sg will be created
  + resource "aws_security_group" "web_sg" {
      + arn                    = (known after apply)
      + description            = "Allow http, https and SSH to the web server"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 22
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 22
            },
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 8080
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 8080
            },
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 80
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 80
            },
        ]
      + name                   = "web security group"
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + vpc_id                 = (known after apply)
    }

  # aws_subnet.priv_sub will be created
  + resource "aws_subnet" "priv_sub" {
      + arn                             = (known after apply)
      + assign_ipv6_address_on_creation = false
      + availability_zone               = (known after apply)
      + availability_zone_id            = (known after apply)
      + cidr_block                      = "192.168.1.64/26"
      + id                              = (known after apply)
      + ipv6_cidr_block                 = (known after apply)
      + ipv6_cidr_block_association_id  = (known after apply)
      + map_public_ip_on_launch         = true
      + owner_id                        = (known after apply)
      + tags                            = {
          + "Name" = "private_subnet_JJ"
        }
      + vpc_id                          = (known after apply)
    }

  # aws_subnet.pub_sub will be created
  + resource "aws_subnet" "pub_sub" {
      + arn                             = (known after apply)
      + assign_ipv6_address_on_creation = false
      + availability_zone               = (known after apply)
      + availability_zone_id            = (known after apply)
      + cidr_block                      = "192.168.1.0/26"
      + id                              = (known after apply)
      + ipv6_cidr_block                 = (known after apply)
      + ipv6_cidr_block_association_id  = (known after apply)
      + map_public_ip_on_launch         = true
      + owner_id                        = (known after apply)
      + tags                            = {
          + "Name" = "public_subnet_JJ"
        }
      + vpc_id                          = (known after apply)
    }

  # aws_vpc.first_VPC will be created
  + resource "aws_vpc" "first_VPC" {
      + arn                              = (known after apply)
      + assign_generated_ipv6_cidr_block = false
      + cidr_block                       = "192.168.1.0/24"
      + default_network_acl_id           = (known after apply)
      + default_route_table_id           = (known after apply)
      + default_security_group_id        = (known after apply)
      + dhcp_options_id                  = (known after apply)
      + enable_classiclink               = (known after apply)
      + enable_classiclink_dns_support   = (known after apply)
      + enable_dns_hostnames             = true
      + enable_dns_support               = true
      + id                               = (known after apply)
      + instance_tenancy                 = "default"
      + ipv6_association_id              = (known after apply)
      + ipv6_cidr_block                  = (known after apply)
      + main_route_table_id              = (known after apply)
      + owner_id                         = (known after apply)
      + tags                             = {
          + "Name" = "first_vpc_JJ"
        }
    }

Plan: 15 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_key_pair.keys: Creating...
aws_vpc.first_VPC: Creating...
aws_key_pair.keys: Creation complete after 1s [id=JJKey]
aws_vpc.first_VPC: Creation complete after 3s [id=vpc-0857caa941ace64f8]
aws_subnet.priv_sub: Creating...
aws_subnet.pub_sub: Creating...
aws_internet_gateway.int_gw: Creating...
aws_security_group.web_sg: Creating...
aws_subnet.pub_sub: Creation complete after 1s [id=subnet-0961b4bd8f555f3d1]
aws_subnet.priv_sub: Creation complete after 1s [id=subnet-066b81dd4242526b7]
aws_internet_gateway.int_gw: Creation complete after 1s [id=igw-035b4f69024eb5190]
aws_route_table.rou_tab: Creating...
aws_security_group.web_sg: Creation complete after 2s [id=sg-00b00ee8ac8a312e7]
aws_network_interface.elast_int: Creating...
aws_instance.PrivHost: Creating...
aws_network_interface.elast_int_jump: Creating...
aws_route_table.rou_tab: Creation complete after 1s [id=rtb-0936434d444e56657]
aws_route_table_association.rt_assoc: Creating...
aws_route_table_association.rt_assoc: Creation complete after 0s [id=rtbassoc-00830d34828f9a979]
aws_network_interface.elast_int_jump: Creation complete after 1s [id=eni-0749cc191c204dbef]
aws_eip.elast_ip_jump: Creating...
aws_instance.JumpHost: Creating...
aws_network_interface.elast_int: Creation complete after 1s [id=eni-0a44ce08426f16a1c]
aws_instance.WebVM: Creating...
aws_eip.elast_ip: Creating...
aws_eip.elast_ip_jump: Creation complete after 1s [id=eipalloc-02a80fb73bc1d3ec3]
aws_eip.elast_ip: Creation complete after 1s [id=eipalloc-014fbb267768e04e3]
aws_instance.PrivHost: Still creating... [10s elapsed]
aws_instance.JumpHost: Still creating... [10s elapsed]
aws_instance.WebVM: Still creating... [10s elapsed]
aws_instance.PrivHost: Still creating... [20s elapsed]
aws_instance.JumpHost: Still creating... [20s elapsed]
aws_instance.WebVM: Still creating... [20s elapsed]
aws_instance.PrivHost: Creation complete after 22s [id=i-0aa64b1768a9493ea]
aws_instance.JumpHost: Creation complete after 23s [id=i-03d63cd01707760c3]
aws_instance.WebVM: Creation complete after 23s [id=i-02e18c71cb5b72216]

Apply complete! Resources: 15 added, 0 changed, 0 destroyed.

~~~
## Verification

### VPCs
~~~
$ aws ec2 describe-vpcs
-----------------------------------------------------------
|                      DescribeVpcs                       |
+---------------------------------------------------------+
||                         Vpcs                          ||
|+----------------------------+--------------------------+|
||  CidrBlock                 |  172.31.0.0/16           ||
||  DhcpOptionsId             |  dopt-c2a372a8           ||
||  InstanceTenancy           |  default                 ||
||  IsDefault                 |  True                    ||
||  OwnerId                   |  379268274265            ||
||  State                     |  available               ||
||  VpcId                     |  vpc-2d62b447            ||
|+----------------------------+--------------------------+|
|||               CidrBlockAssociationSet               |||
||+-------------------+---------------------------------+||
|||  AssociationId    |  vpc-cidr-assoc-068e2f6d        |||
|||  CidrBlock        |  172.31.0.0/16                  |||
||+-------------------+---------------------------------+||
||||                  CidrBlockState                   ||||
|||+-------------------+-------------------------------+|||
||||  State            |  associated                   ||||
|||+-------------------+-------------------------------+|||
||                         Vpcs                          ||
|+-----------------------+-------------------------------+|
||  CidrBlock            |  192.168.1.0/24               ||
||  DhcpOptionsId        |  dopt-c2a372a8                ||
||  InstanceTenancy      |  default                      ||
||  IsDefault            |  False                        ||
||  OwnerId              |  379268274265                 ||
||  State                |  available                    ||
||  VpcId                |  vpc-0857caa941ace64f8        ||
|+-----------------------+-------------------------------+|
|||               CidrBlockAssociationSet               |||
||+----------------+------------------------------------+||
|||  AssociationId |  vpc-cidr-assoc-0eb7dd85d20583f1f  |||
|||  CidrBlock     |  192.168.1.0/24                    |||
||+----------------+------------------------------------+||
||||                  CidrBlockState                   ||||
|||+-------------------+-------------------------------+|||
||||  State            |  associated                   ||||
|||+-------------------+-------------------------------+|||
|||                        Tags                         |||
||+------------------+----------------------------------+||
|||  Key             |  Name                            |||
|||  Value           |  first_vpc_JJ                    |||
||+------------------+----------------------------------+||


~~~

### Elastic IP Address
~~~

$ aws ec2 describe-addresses
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|                                                                                                        DescribeAddresses                                                                                                        |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
||                                                                                                           Addresses                                                                                                           ||
|+----------------------------+-----------------------------+---------+----------------------+---------------------+------------------------+--------------------------+-------------------+------------------+------------------+|
||        AllocationId        |        AssociationId        | Domain  |     InstanceId       | NetworkBorderGroup  |  NetworkInterfaceId    | NetworkInterfaceOwnerId  | PrivateIpAddress  |    PublicIp      | PublicIpv4Pool   ||
|+----------------------------+-----------------------------+---------+----------------------+---------------------+------------------------+--------------------------+-------------------+------------------+------------------+|
||  eipalloc-02a80fb73bc1d3ec3|  eipassoc-0b0c4a61fc0ce8f43 |  vpc    |  i-03d63cd01707760c3 |  eu-central-1       |  eni-0749cc191c204dbef |  379268274265            |  192.168.1.27     |  18.157.219.247  |  amazon          ||
||  eipalloc-014fbb267768e04e3|  eipassoc-0ad52941d7c5ab480 |  vpc    |  i-02e18c71cb5b72216 |  eu-central-1       |  eni-0a44ce08426f16a1c |  379268274265            |  192.168.1.55     |  18.158.31.223   |  amazon          ||
|+----------------------------+-----------------------------+---------+----------------------+---------------------+------------------------+--------------------------+-------------------+------------------+------------------+|





~~~
### Network Interfaces
~~~
$ aws ec2 describe-network-interfaces
----------------------------------------------------------------------------------
|                            DescribeNetworkInterfaces                           |
+--------------------------------------------------------------------------------+
||                               NetworkInterfaces                              ||
|+-----------------------+------------------------------------------------------+|
||  AvailabilityZone     |  eu-central-1c                                       ||
||  Description          |                                                      ||
||  InterfaceType        |  interface                                           ||
||  MacAddress           |  0a:8e:ae:1d:ce:b6                                   ||
||  NetworkInterfaceId   |  eni-0749cc191c204dbef                               ||
||  OwnerId              |  379268274265                                        ||
||  PrivateDnsName       |  ip-192-168-1-27.eu-central-1.compute.internal       ||
||  PrivateIpAddress     |  192.168.1.27                                        ||
||  RequesterManaged     |  False                                               ||
||  SourceDestCheck      |  True                                                ||
||  Status               |  in-use                                              ||
||  SubnetId             |  subnet-0961b4bd8f555f3d1                            ||
||  VpcId                |  vpc-0857caa941ace64f8                               ||
|+-----------------------+------------------------------------------------------+|
|||                                 Association                                |||
||+----------------+-----------------------------------------------------------+||
|||  AllocationId  |  eipalloc-02a80fb73bc1d3ec3                               |||
|||  AssociationId |  eipassoc-0b0c4a61fc0ce8f43                               |||
|||  IpOwnerId     |  379268274265                                             |||
|||  PublicDnsName |  ec2-18-157-219-247.eu-central-1.compute.amazonaws.com    |||
|||  PublicIp      |  18.157.219.247                                           |||
||+----------------+-----------------------------------------------------------+||
|||                                 Attachment                                 |||
||+-------------------------------+--------------------------------------------+||
|||  AttachTime                   |  2020-06-29T23:42:39+00:00                 |||
|||  AttachmentId                 |  eni-attach-084b4c7519e226be2              |||
|||  DeleteOnTermination          |  False                                     |||
|||  DeviceIndex                  |  0                                         |||
|||  InstanceId                   |  i-03d63cd01707760c3                       |||
|||  InstanceOwnerId              |  379268274265                              |||
|||  Status                       |  attached                                  |||
||+-------------------------------+--------------------------------------------+||
|||                                   Groups                                   |||
||+-------------------------+--------------------------------------------------+||
|||  GroupId                |  sg-00b00ee8ac8a312e7                            |||
|||  GroupName              |  web security group                              |||
||+-------------------------+--------------------------------------------------+||
|||                             PrivateIpAddresses                             |||
||+---------------------+------------------------------------------------------+||
|||  Primary            |  True                                                |||
|||  PrivateDnsName     |  ip-192-168-1-27.eu-central-1.compute.internal       |||
|||  PrivateIpAddress   |  192.168.1.27                                        |||
||+---------------------+------------------------------------------------------+||
||||                                Association                               ||||
|||+---------------+----------------------------------------------------------+|||
||||  AllocationId |  eipalloc-02a80fb73bc1d3ec3                              ||||
||||  AssociationId|  eipassoc-0b0c4a61fc0ce8f43                              ||||
||||  IpOwnerId    |  379268274265                                            ||||
||||  PublicDnsName|  ec2-18-157-219-247.eu-central-1.compute.amazonaws.com   ||||
||||  PublicIp     |  18.157.219.247                                          ||||
|||+---------------+----------------------------------------------------------+|||
||                               NetworkInterfaces                              ||
|+-----------------------+------------------------------------------------------+|
||  AvailabilityZone     |  eu-central-1c                                       ||
||  Description          |                                                      ||
||  InterfaceType        |  interface                                           ||
||  MacAddress           |  0a:78:11:8d:5a:66                                   ||
||  NetworkInterfaceId   |  eni-0a44ce08426f16a1c                               ||
||  OwnerId              |  379268274265                                        ||
||  PrivateDnsName       |  ip-192-168-1-55.eu-central-1.compute.internal       ||
||  PrivateIpAddress     |  192.168.1.55                                        ||
||  RequesterManaged     |  False                                               ||
||  SourceDestCheck      |  True                                                ||
||  Status               |  in-use                                              ||
||  SubnetId             |  subnet-0961b4bd8f555f3d1                            ||
||  VpcId                |  vpc-0857caa941ace64f8                               ||
|+-----------------------+------------------------------------------------------+|
|||                                 Association                                |||
||+----------------+-----------------------------------------------------------+||
|||  AllocationId  |  eipalloc-014fbb267768e04e3                               |||
|||  AssociationId |  eipassoc-0ad52941d7c5ab480                               |||
|||  IpOwnerId     |  379268274265                                             |||
|||  PublicDnsName |  ec2-18-158-31-223.eu-central-1.compute.amazonaws.com     |||
|||  PublicIp      |  18.158.31.223                                            |||
||+----------------+-----------------------------------------------------------+||
|||                                 Attachment                                 |||
||+-------------------------------+--------------------------------------------+||
|||  AttachTime                   |  2020-06-29T23:42:40+00:00                 |||
|||  AttachmentId                 |  eni-attach-01b221461c57b03c9              |||
|||  DeleteOnTermination          |  False                                     |||
|||  DeviceIndex                  |  0                                         |||
|||  InstanceId                   |  i-02e18c71cb5b72216                       |||
|||  InstanceOwnerId              |  379268274265                              |||
|||  Status                       |  attached                                  |||
||+-------------------------------+--------------------------------------------+||
|||                                   Groups                                   |||
||+-------------------------+--------------------------------------------------+||
|||  GroupId                |  sg-00b00ee8ac8a312e7                            |||
|||  GroupName              |  web security group                              |||
||+-------------------------+--------------------------------------------------+||
|||                             PrivateIpAddresses                             |||
||+---------------------+------------------------------------------------------+||
|||  Primary            |  True                                                |||
|||  PrivateDnsName     |  ip-192-168-1-55.eu-central-1.compute.internal       |||
|||  PrivateIpAddress   |  192.168.1.55                                        |||
||+---------------------+------------------------------------------------------+||
||||                                Association                               ||||
|||+----------------+---------------------------------------------------------+|||
||||  AllocationId  |  eipalloc-014fbb267768e04e3                             ||||
||||  AssociationId |  eipassoc-0ad52941d7c5ab480                             ||||
||||  IpOwnerId     |  379268274265                                           ||||
||||  PublicDnsName |  ec2-18-158-31-223.eu-central-1.compute.amazonaws.com   ||||
||||  PublicIp      |  18.158.31.223                                          ||||
|||+----------------+---------------------------------------------------------+|||
||                               NetworkInterfaces                              ||
|+-----------------------+------------------------------------------------------+|
||  AvailabilityZone     |  eu-central-1b                                       ||
||  Description          |                                                      ||
||  InterfaceType        |  interface                                           ||
||  MacAddress           |  06:db:82:1c:18:40                                   ||
||  NetworkInterfaceId   |  eni-023d55a702ca21aa3                               ||
||  OwnerId              |  379268274265                                        ||
||  PrivateDnsName       |  ip-192-168-1-93.eu-central-1.compute.internal       ||
||  PrivateIpAddress     |  192.168.1.93                                        ||
||  RequesterManaged     |  False                                               ||
||  SourceDestCheck      |  True                                                ||
||  Status               |  in-use                                              ||
||  SubnetId             |  subnet-066b81dd4242526b7                            ||
||  VpcId                |  vpc-0857caa941ace64f8                               ||
|+-----------------------+------------------------------------------------------+|
|||                                 Association                                |||
||+----------------+-----------------------------------------------------------+||
|||  IpOwnerId     |  amazon                                                   |||
|||  PublicDnsName |  ec2-18-184-197-92.eu-central-1.compute.amazonaws.com     |||
|||  PublicIp      |  18.184.197.92                                            |||
||+----------------+-----------------------------------------------------------+||
|||                                 Attachment                                 |||
||+-------------------------------+--------------------------------------------+||
|||  AttachTime                   |  2020-06-29T23:42:38+00:00                 |||
|||  AttachmentId                 |  eni-attach-06b2227f0c3827c8a              |||
|||  DeleteOnTermination          |  True                                      |||
|||  DeviceIndex                  |  0                                         |||
|||  InstanceId                   |  i-0aa64b1768a9493ea                       |||
|||  InstanceOwnerId              |  379268274265                              |||
|||  Status                       |  attached                                  |||
||+-------------------------------+--------------------------------------------+||
|||                                   Groups                                   |||
||+-------------------------+--------------------------------------------------+||
|||  GroupId                |  sg-00b00ee8ac8a312e7                            |||
|||  GroupName              |  web security group                              |||
||+-------------------------+--------------------------------------------------+||
|||                             PrivateIpAddresses                             |||
||+---------------------+------------------------------------------------------+||
|||  Primary            |  True                                                |||
|||  PrivateDnsName     |  ip-192-168-1-93.eu-central-1.compute.internal       |||
|||  PrivateIpAddress   |  192.168.1.93                                        |||
||+---------------------+------------------------------------------------------+||
||||                                Association                               ||||
|||+----------------+---------------------------------------------------------+|||
||||  IpOwnerId     |  amazon                                                 ||||
||||  PublicDnsName |  ec2-18-184-197-92.eu-central-1.compute.amazonaws.com   ||||
||||  PublicIp      |  18.184.197.92                                          ||||
|||+----------------+---------------------------------------------------------+|||


~~~
### Instances
~~~

$ aws ec2 describe-instances
----------------------------------------------------------------------------------------
|                                   DescribeInstances                                  |
+--------------------------------------------------------------------------------------+
||                                    Reservations                                    ||
|+-----------------------------------+------------------------------------------------+|
||  OwnerId                          |  379268274265                                  ||
||  ReservationId                    |  r-0d2824fa9b4b74600                           ||
|+-----------------------------------+------------------------------------------------+|
|||                                     Instances                                    |||
||+------------------------+---------------------------------------------------------+||
|||  AmiLaunchIndex        |  0                                                      |||
|||  Architecture          |  x86_64                                                 |||
|||  ClientToken           |  29539F2A-B66A-49F2-A74D-967AEFBE9A07                   |||
|||  EbsOptimized          |  False                                                  |||
|||  EnaSupport            |  True                                                   |||
|||  Hypervisor            |  xen                                                    |||
|||  ImageId               |  ami-0d359437d1756caa8                                  |||
|||  InstanceId            |  i-0aa64b1768a9493ea                                    |||
|||  InstanceType          |  t2.micro                                               |||
|||  KeyName               |  JJKey                                                  |||
|||  LaunchTime            |  2020-06-29T23:42:38+00:00                              |||
|||  PrivateDnsName        |  ip-192-168-1-93.eu-central-1.compute.internal          |||
|||  PrivateIpAddress      |  192.168.1.93                                           |||
|||  PublicDnsName         |  ec2-18-184-197-92.eu-central-1.compute.amazonaws.com   |||
|||  PublicIpAddress       |  18.184.197.92                                          |||
|||  RootDeviceName        |  /dev/sda1                                              |||
|||  RootDeviceType        |  ebs                                                    |||
|||  SourceDestCheck       |  True                                                   |||
|||  StateTransitionReason |                                                         |||
|||  SubnetId              |  subnet-066b81dd4242526b7                               |||
|||  VirtualizationType    |  hvm                                                    |||
|||  VpcId                 |  vpc-0857caa941ace64f8                                  |||
||+------------------------+---------------------------------------------------------+||
||||                               BlockDeviceMappings                              ||||
|||+-----------------------------------------+--------------------------------------+|||
||||  DeviceName                             |  /dev/sda1                           ||||
|||+-----------------------------------------+--------------------------------------+|||
|||||                                      Ebs                                     |||||
||||+---------------------------------+--------------------------------------------+||||
|||||  AttachTime                     |  2020-06-29T23:42:39+00:00                 |||||
|||||  DeleteOnTermination            |  True                                      |||||
|||||  Status                         |  attached                                  |||||
|||||  VolumeId                       |  vol-04b836cc8e8001d6e                     |||||
||||+---------------------------------+--------------------------------------------+||||
||||                        CapacityReservationSpecification                        ||||
|||+----------------------------------------------------------------+---------------+|||
||||  CapacityReservationPreference                                 |  open         ||||
|||+----------------------------------------------------------------+---------------+|||
||||                                   CpuOptions                                   ||||
|||+--------------------------------------------------------------+-----------------+|||
||||  CoreCount                                                   |  1              ||||
||||  ThreadsPerCore                                              |  1              ||||
|||+--------------------------------------------------------------+-----------------+|||
||||                               HibernationOptions                               ||||
|||+------------------------------------------------+-------------------------------+|||
||||  Configured                                    |  False                        ||||
|||+------------------------------------------------+-------------------------------+|||
||||                                 MetadataOptions                                ||||
|||+-------------------------------------------------------+------------------------+|||
||||  HttpEndpoint                                         |  enabled               ||||
||||  HttpPutResponseHopLimit                              |  1                     ||||
||||  HttpTokens                                           |  optional              ||||
||||  State                                                |  applied               ||||
|||+-------------------------------------------------------+------------------------+|||
||||                                   Monitoring                                   ||||
|||+---------------------------------+----------------------------------------------+|||
||||  State                          |  disabled                                    ||||
|||+---------------------------------+----------------------------------------------+|||
||||                                NetworkInterfaces                               ||||
|||+-----------------------+--------------------------------------------------------+|||
||||  Description          |                                                        ||||
||||  InterfaceType        |  interface                                             ||||
||||  MacAddress           |  06:db:82:1c:18:40                                     ||||
||||  NetworkInterfaceId   |  eni-023d55a702ca21aa3                                 ||||
||||  OwnerId              |  379268274265                                          ||||
||||  PrivateDnsName       |  ip-192-168-1-93.eu-central-1.compute.internal         ||||
||||  PrivateIpAddress     |  192.168.1.93                                          ||||
||||  SourceDestCheck      |  True                                                  ||||
||||  Status               |  in-use                                                ||||
||||  SubnetId             |  subnet-066b81dd4242526b7                              ||||
||||  VpcId                |  vpc-0857caa941ace64f8                                 ||||
|||+-----------------------+--------------------------------------------------------+|||
|||||                                  Association                                 |||||
||||+-----------------+------------------------------------------------------------+||||
|||||  IpOwnerId      |  amazon                                                    |||||
|||||  PublicDnsName  |  ec2-18-184-197-92.eu-central-1.compute.amazonaws.com      |||||
|||||  PublicIp       |  18.184.197.92                                             |||||
||||+-----------------+------------------------------------------------------------+||||
|||||                                  Attachment                                  |||||
||||+-------------------------------+----------------------------------------------+||||
|||||  AttachTime                   |  2020-06-29T23:42:38+00:00                   |||||
|||||  AttachmentId                 |  eni-attach-06b2227f0c3827c8a                |||||
|||||  DeleteOnTermination          |  True                                        |||||
|||||  DeviceIndex                  |  0                                           |||||
|||||  Status                       |  attached                                    |||||
||||+-------------------------------+----------------------------------------------+||||
|||||                                    Groups                                    |||||
||||+--------------------------+---------------------------------------------------+||||
|||||  GroupId                 |  sg-00b00ee8ac8a312e7                             |||||
|||||  GroupName               |  web security group                               |||||
||||+--------------------------+---------------------------------------------------+||||
|||||                              PrivateIpAddresses                              |||||
||||+---------------------+--------------------------------------------------------+||||
|||||  Primary            |  True                                                  |||||
|||||  PrivateDnsName     |  ip-192-168-1-93.eu-central-1.compute.internal         |||||
|||||  PrivateIpAddress   |  192.168.1.93                                          |||||
||||+---------------------+--------------------------------------------------------+||||
||||||                                 Association                                ||||||
|||||+----------------+-----------------------------------------------------------+|||||
||||||  IpOwnerId     |  amazon                                                   ||||||
||||||  PublicDnsName |  ec2-18-184-197-92.eu-central-1.compute.amazonaws.com     ||||||
||||||  PublicIp      |  18.184.197.92                                            ||||||
|||||+----------------+-----------------------------------------------------------+|||||
||||                                    Placement                                   ||||
|||+------------------------------------------+-------------------------------------+|||
||||  AvailabilityZone                        |  eu-central-1b                      ||||
||||  GroupName                               |                                     ||||
||||  Tenancy                                 |  default                            ||||
|||+------------------------------------------+-------------------------------------+|||
||||                                 SecurityGroups                                 ||||
|||+---------------------------+----------------------------------------------------+|||
||||  GroupId                  |  sg-00b00ee8ac8a312e7                              ||||
||||  GroupName                |  web security group                                ||||
|||+---------------------------+----------------------------------------------------+|||
||||                                      State                                     ||||
|||+---------------------------------+----------------------------------------------+|||
||||  Code                           |  16                                          ||||
||||  Name                           |  running                                     ||||
|||+---------------------------------+----------------------------------------------+|||
||||                                      Tags                                      ||||
|||+----------------------------+---------------------------------------------------+|||
||||  Key                       |  Name                                             ||||
||||  Value                     |  priv_host_JJ                                     ||||
|||+----------------------------+---------------------------------------------------+|||
||                                    Reservations                                    ||
|+-----------------------------------+------------------------------------------------+|
||  OwnerId                          |  379268274265                                  ||
||  ReservationId                    |  r-0b0ddfe6608ae0128                           ||
|+-----------------------------------+------------------------------------------------+|
|||                                     Instances                                    |||
||+------------------------+---------------------------------------------------------+||
|||  AmiLaunchIndex        |  0                                                      |||
|||  Architecture          |  x86_64                                                 |||
|||  ClientToken           |  618B8ABF-4557-4080-AAB5-BCB7897A3F8A                   |||
|||  EbsOptimized          |  False                                                  |||
|||  EnaSupport            |  True                                                   |||
|||  Hypervisor            |  xen                                                    |||
|||  ImageId               |  ami-0d359437d1756caa8                                  |||
|||  InstanceId            |  i-02e18c71cb5b72216                                    |||
|||  InstanceType          |  t2.micro                                               |||
|||  KeyName               |  JJKey                                                  |||
|||  LaunchTime            |  2020-06-29T23:42:40+00:00                              |||
|||  PrivateDnsName        |  ip-192-168-1-55.eu-central-1.compute.internal          |||
|||  PrivateIpAddress      |  192.168.1.55                                           |||
|||  PublicDnsName         |  ec2-18-158-31-223.eu-central-1.compute.amazonaws.com   |||
|||  PublicIpAddress       |  18.158.31.223                                          |||
|||  RootDeviceName        |  /dev/sda1                                              |||
|||  RootDeviceType        |  ebs                                                    |||
|||  SourceDestCheck       |  True                                                   |||
|||  StateTransitionReason |                                                         |||
|||  SubnetId              |  subnet-0961b4bd8f555f3d1                               |||
|||  VirtualizationType    |  hvm                                                    |||
|||  VpcId                 |  vpc-0857caa941ace64f8                                  |||
||+------------------------+---------------------------------------------------------+||
||||                               BlockDeviceMappings                              ||||
|||+-----------------------------------------+--------------------------------------+|||
||||  DeviceName                             |  /dev/sda1                           ||||
|||+-----------------------------------------+--------------------------------------+|||
|||||                                      Ebs                                     |||||
||||+---------------------------------+--------------------------------------------+||||
|||||  AttachTime                     |  2020-06-29T23:42:41+00:00                 |||||
|||||  DeleteOnTermination            |  True                                      |||||
|||||  Status                         |  attached                                  |||||
|||||  VolumeId                       |  vol-09b785b3d142cfa95                     |||||
||||+---------------------------------+--------------------------------------------+||||
||||                        CapacityReservationSpecification                        ||||
|||+----------------------------------------------------------------+---------------+|||
||||  CapacityReservationPreference                                 |  open         ||||
|||+----------------------------------------------------------------+---------------+|||
||||                                   CpuOptions                                   ||||
|||+--------------------------------------------------------------+-----------------+|||
||||  CoreCount                                                   |  1              ||||
||||  ThreadsPerCore                                              |  1              ||||
|||+--------------------------------------------------------------+-----------------+|||
||||                               HibernationOptions                               ||||
|||+------------------------------------------------+-------------------------------+|||
||||  Configured                                    |  False                        ||||
|||+------------------------------------------------+-------------------------------+|||
||||                                 MetadataOptions                                ||||
|||+-------------------------------------------------------+------------------------+|||
||||  HttpEndpoint                                         |  enabled               ||||
||||  HttpPutResponseHopLimit                              |  1                     ||||
||||  HttpTokens                                           |  optional              ||||
||||  State                                                |  applied               ||||
|||+-------------------------------------------------------+------------------------+|||
||||                                   Monitoring                                   ||||
|||+---------------------------------+----------------------------------------------+|||
||||  State                          |  disabled                                    ||||
|||+---------------------------------+----------------------------------------------+|||
||||                                NetworkInterfaces                               ||||
|||+-----------------------+--------------------------------------------------------+|||
||||  Description          |                                                        ||||
||||  InterfaceType        |  interface                                             ||||
||||  MacAddress           |  0a:78:11:8d:5a:66                                     ||||
||||  NetworkInterfaceId   |  eni-0a44ce08426f16a1c                                 ||||
||||  OwnerId              |  379268274265                                          ||||
||||  PrivateDnsName       |  ip-192-168-1-55.eu-central-1.compute.internal         ||||
||||  PrivateIpAddress     |  192.168.1.55                                          ||||
||||  SourceDestCheck      |  True                                                  ||||
||||  Status               |  in-use                                                ||||
||||  SubnetId             |  subnet-0961b4bd8f555f3d1                              ||||
||||  VpcId                |  vpc-0857caa941ace64f8                                 ||||
|||+-----------------------+--------------------------------------------------------+|||
|||||                                  Association                                 |||||
||||+-----------------+------------------------------------------------------------+||||
|||||  IpOwnerId      |  379268274265                                              |||||
|||||  PublicDnsName  |  ec2-18-158-31-223.eu-central-1.compute.amazonaws.com      |||||
|||||  PublicIp       |  18.158.31.223                                             |||||
||||+-----------------+------------------------------------------------------------+||||
|||||                                  Attachment                                  |||||
||||+-------------------------------+----------------------------------------------+||||
|||||  AttachTime                   |  2020-06-29T23:42:40+00:00                   |||||
|||||  AttachmentId                 |  eni-attach-01b221461c57b03c9                |||||
|||||  DeleteOnTermination          |  False                                       |||||
|||||  DeviceIndex                  |  0                                           |||||
|||||  Status                       |  attached                                    |||||
||||+-------------------------------+----------------------------------------------+||||
|||||                                    Groups                                    |||||
||||+--------------------------+---------------------------------------------------+||||
|||||  GroupId                 |  sg-00b00ee8ac8a312e7                             |||||
|||||  GroupName               |  web security group                               |||||
||||+--------------------------+---------------------------------------------------+||||
|||||                              PrivateIpAddresses                              |||||
||||+---------------------+--------------------------------------------------------+||||
|||||  Primary            |  True                                                  |||||
|||||  PrivateDnsName     |  ip-192-168-1-55.eu-central-1.compute.internal         |||||
|||||  PrivateIpAddress   |  192.168.1.55                                          |||||
||||+---------------------+--------------------------------------------------------+||||
||||||                                 Association                                ||||||
|||||+----------------+-----------------------------------------------------------+|||||
||||||  IpOwnerId     |  379268274265                                             ||||||
||||||  PublicDnsName |  ec2-18-158-31-223.eu-central-1.compute.amazonaws.com     ||||||
||||||  PublicIp      |  18.158.31.223                                            ||||||
|||||+----------------+-----------------------------------------------------------+|||||
||||                                    Placement                                   ||||
|||+------------------------------------------+-------------------------------------+|||
||||  AvailabilityZone                        |  eu-central-1c                      ||||
||||  GroupName                               |                                     ||||
||||  Tenancy                                 |  default                            ||||
|||+------------------------------------------+-------------------------------------+|||
||||                                 SecurityGroups                                 ||||
|||+---------------------------+----------------------------------------------------+|||
||||  GroupId                  |  sg-00b00ee8ac8a312e7                              ||||
||||  GroupName                |  web security group                                ||||
|||+---------------------------+----------------------------------------------------+|||
||||                                      State                                     ||||
|||+---------------------------------+----------------------------------------------+|||
||||  Code                           |  16                                          ||||
||||  Name                           |  running                                     ||||
|||+---------------------------------+----------------------------------------------+|||
||||                                      Tags                                      ||||
|||+--------------------------------+-----------------------------------------------+|||
||||  Key                           |  Name                                         ||||
||||  Value                         |  web_vm_JJ                                    ||||
|||+--------------------------------+-----------------------------------------------+|||
||                                    Reservations                                    ||
|+-----------------------------------+------------------------------------------------+|
||  OwnerId                          |  379268274265                                  ||
||  ReservationId                    |  r-0eace7a70b591608f                           ||
|+-----------------------------------+------------------------------------------------+|
|||                                     Instances                                    |||
||+------------------------+---------------------------------------------------------+||
|||  AmiLaunchIndex        |  0                                                      |||
|||  Architecture          |  x86_64                                                 |||
|||  ClientToken           |  12114794-98B6-4EC7-9AA2-E3CC515C832D                   |||
|||  EbsOptimized          |  False                                                  |||
|||  EnaSupport            |  True                                                   |||
|||  Hypervisor            |  xen                                                    |||
|||  ImageId               |  ami-0d359437d1756caa8                                  |||
|||  InstanceId            |  i-03d63cd01707760c3                                    |||
|||  InstanceType          |  t2.micro                                               |||
|||  KeyName               |  JJKey                                                  |||
|||  LaunchTime            |  2020-06-29T23:42:39+00:00                              |||
|||  PrivateDnsName        |  ip-192-168-1-27.eu-central-1.compute.internal          |||
|||  PrivateIpAddress      |  192.168.1.27                                           |||
|||  PublicDnsName         |  ec2-18-157-219-247.eu-central-1.compute.amazonaws.com  |||
|||  PublicIpAddress       |  18.157.219.247                                         |||
|||  RootDeviceName        |  /dev/sda1                                              |||
|||  RootDeviceType        |  ebs                                                    |||
|||  SourceDestCheck       |  True                                                   |||
|||  StateTransitionReason |                                                         |||
|||  SubnetId              |  subnet-0961b4bd8f555f3d1                               |||
|||  VirtualizationType    |  hvm                                                    |||
|||  VpcId                 |  vpc-0857caa941ace64f8                                  |||
||+------------------------+---------------------------------------------------------+||
||||                               BlockDeviceMappings                              ||||
|||+-----------------------------------------+--------------------------------------+|||
||||  DeviceName                             |  /dev/sda1                           ||||
|||+-----------------------------------------+--------------------------------------+|||
|||||                                      Ebs                                     |||||
||||+---------------------------------+--------------------------------------------+||||
|||||  AttachTime                     |  2020-06-29T23:42:40+00:00                 |||||
|||||  DeleteOnTermination            |  True                                      |||||
|||||  Status                         |  attached                                  |||||
|||||  VolumeId                       |  vol-0899c632e6d7bc266                     |||||
||||+---------------------------------+--------------------------------------------+||||
||||                        CapacityReservationSpecification                        ||||
|||+----------------------------------------------------------------+---------------+|||
||||  CapacityReservationPreference                                 |  open         ||||
|||+----------------------------------------------------------------+---------------+|||
||||                                   CpuOptions                                   ||||
|||+--------------------------------------------------------------+-----------------+|||
||||  CoreCount                                                   |  1              ||||
||||  ThreadsPerCore                                              |  1              ||||
|||+--------------------------------------------------------------+-----------------+|||
||||                               HibernationOptions                               ||||
|||+------------------------------------------------+-------------------------------+|||
||||  Configured                                    |  False                        ||||
|||+------------------------------------------------+-------------------------------+|||
||||                                 MetadataOptions                                ||||
|||+-------------------------------------------------------+------------------------+|||
||||  HttpEndpoint                                         |  enabled               ||||
||||  HttpPutResponseHopLimit                              |  1                     ||||
||||  HttpTokens                                           |  optional              ||||
||||  State                                                |  applied               ||||
|||+-------------------------------------------------------+------------------------+|||
||||                                   Monitoring                                   ||||
|||+---------------------------------+----------------------------------------------+|||
||||  State                          |  disabled                                    ||||
|||+---------------------------------+----------------------------------------------+|||
||||                                NetworkInterfaces                               ||||
|||+-----------------------+--------------------------------------------------------+|||
||||  Description          |                                                        ||||
||||  InterfaceType        |  interface                                             ||||
||||  MacAddress           |  0a:8e:ae:1d:ce:b6                                     ||||
||||  NetworkInterfaceId   |  eni-0749cc191c204dbef                                 ||||
||||  OwnerId              |  379268274265                                          ||||
||||  PrivateDnsName       |  ip-192-168-1-27.eu-central-1.compute.internal         ||||
||||  PrivateIpAddress     |  192.168.1.27                                          ||||
||||  SourceDestCheck      |  True                                                  ||||
||||  Status               |  in-use                                                ||||
||||  SubnetId             |  subnet-0961b4bd8f555f3d1                              ||||
||||  VpcId                |  vpc-0857caa941ace64f8                                 ||||
|||+-----------------------+--------------------------------------------------------+|||
|||||                                  Association                                 |||||
||||+----------------+-------------------------------------------------------------+||||
|||||  IpOwnerId     |  379268274265                                               |||||
|||||  PublicDnsName |  ec2-18-157-219-247.eu-central-1.compute.amazonaws.com      |||||
|||||  PublicIp      |  18.157.219.247                                             |||||
||||+----------------+-------------------------------------------------------------+||||
|||||                                  Attachment                                  |||||
||||+-------------------------------+----------------------------------------------+||||
|||||  AttachTime                   |  2020-06-29T23:42:39+00:00                   |||||
|||||  AttachmentId                 |  eni-attach-084b4c7519e226be2                |||||
|||||  DeleteOnTermination          |  False                                       |||||
|||||  DeviceIndex                  |  0                                           |||||
|||||  Status                       |  attached                                    |||||
||||+-------------------------------+----------------------------------------------+||||
|||||                                    Groups                                    |||||
||||+--------------------------+---------------------------------------------------+||||
|||||  GroupId                 |  sg-00b00ee8ac8a312e7                             |||||
|||||  GroupName               |  web security group                               |||||
||||+--------------------------+---------------------------------------------------+||||
|||||                              PrivateIpAddresses                              |||||
||||+---------------------+--------------------------------------------------------+||||
|||||  Primary            |  True                                                  |||||
|||||  PrivateDnsName     |  ip-192-168-1-27.eu-central-1.compute.internal         |||||
|||||  PrivateIpAddress   |  192.168.1.27                                          |||||
||||+---------------------+--------------------------------------------------------+||||
||||||                                 Association                                ||||||
|||||+----------------+-----------------------------------------------------------+|||||
||||||  IpOwnerId     |  379268274265                                             ||||||
||||||  PublicDnsName |  ec2-18-157-219-247.eu-central-1.compute.amazonaws.com    ||||||
||||||  PublicIp      |  18.157.219.247                                           ||||||
|||||+----------------+-----------------------------------------------------------+|||||
||||                                    Placement                                   ||||
|||+------------------------------------------+-------------------------------------+|||
||||  AvailabilityZone                        |  eu-central-1c                      ||||
||||  GroupName                               |                                     ||||
||||  Tenancy                                 |  default                            ||||
|||+------------------------------------------+-------------------------------------+|||
||||                                 SecurityGroups                                 ||||
|||+---------------------------+----------------------------------------------------+|||
||||  GroupId                  |  sg-00b00ee8ac8a312e7                              ||||
||||  GroupName                |  web security group                                ||||
|||+---------------------------+----------------------------------------------------+|||
||||                                      State                                     ||||
|||+---------------------------------+----------------------------------------------+|||
||||  Code                           |  16                                          ||||
||||  Name                           |  running                                     ||||
|||+---------------------------------+----------------------------------------------+|||
||||                                      Tags                                      ||||
|||+----------------------------+---------------------------------------------------+|||
||||  Key                       |  Name                                             ||||
||||  Value                     |  jump_host_JJ                                     ||||
|||+----------------------------+---------------------------------------------------+|||






~~~
## Tests

### SSH to Web Server 
~~~
$ ssh -i KeyPairJJ.pem ubuntu@ec2-18-158-31-223.eu-central-1.compute.amazonaws.com
The authenticity of host 'ec2-18-158-31-223.eu-central-1.compute.amazonaws.com (18.158.31.223)' can't be established.
ECDSA key fingerprint is SHA256:ih0L5EzbGHYgGAdoBs/1FT524GynFH1oyEOQGE+QSK0.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'ec2-18-158-31-223.eu-central-1.compute.amazonaws.com,18.158.31.223' (ECDSA) to the list of known hosts.
Welcome to Ubuntu 18.04.4 LTS (GNU/Linux 5.3.0-1023-aws x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Tue Jun 30 01:15:57 UTC 2020

  System load:  0.0               Processes:           93
  Usage of /:   16.1% of 7.69GB   Users logged in:     0
  Memory usage: 18%               IP address for eth0: 192.168.1.55
  Swap usage:   0%

20 packages can be updated.
13 updates are security updates.



The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.


~~~
### SSH to Jump Host 
~~~
$ ssh -i KeyPairJJ.pem ubuntu@ec2-18-157-219-247.eu-central-1.compute.amazonaws.com
Welcome to Ubuntu 18.04.4 LTS (GNU/Linux 5.3.0-1023-aws x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Mon Jun 29 23:45:50 UTC 2020

  System load:  0.1               Processes:           95
  Usage of /:   13.8% of 7.69GB   Users logged in:     0
  Memory usage: 16%               IP address for eth0: 192.168.1.27
  Swap usage:   0%

0 packages can be updated.
0 updates are security updates.



The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

~~~
### Download a web page from the Web Server
~~~
ubuntu@ip-192-168-1-55:~$ wget https://ipspace.net
--2020-06-30 01:16:45--  https://ipspace.net/
Resolving ipspace.net (ipspace.net)... 104.26.3.69, 172.67.71.25, 104.26.2.69, ...
Connecting to ipspace.net (ipspace.net)|104.26.3.69|:443... connected.
HTTP request sent, awaiting response... 301 Moved Permanently
Location: https://www.ipspace.net/ [following]
--2020-06-30 01:16:45--  https://www.ipspace.net/
Resolving www.ipspace.net (www.ipspace.net)... 104.26.3.69, 172.67.71.25, 104.26.2.69, ...
Connecting to www.ipspace.net (www.ipspace.net)|104.26.3.69|:443... connected.
HTTP request sent, awaiting response... 301 Moved Permanently
Location: /Main_Page [following]
--2020-06-30 01:16:45--  https://www.ipspace.net/Main_Page
Reusing existing connection to www.ipspace.net:443.
HTTP request sent, awaiting response... 200 OK
Length: unspecified [text/html]
Saving to: ‘index.html’

index.html              [ <=>               ]  22.18K  --.-KB/s    in 0s      

2020-06-30 01:16:45 (78.7 MB/s) - ‘index.html’ saved [22715]


~~~
### Jump host can open a SSH session to VM instance in the private subnet
~~~

$ ssh -i KeyPairJJ.pem   ubuntu@192.168.1.93
Welcome to Ubuntu 18.04.4 LTS (GNU/Linux 5.3.0-1023-aws x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Tue Jun 30 01:13:37 UTC 2020

  System load:  0.0               Processes:           90
  Usage of /:   14.0% of 7.69GB   Users logged in:     0
  Memory usage: 16%               IP address for eth0: 192.168.1.93
  Swap usage:   0%


0 packages can be updated.
0 updates are security updates.

Failed to connect to https://changelogs.ubuntu.com/meta-release-lts. Check your Internet connection or proxy settings


Last login: Tue Jun 30 01:06:43 2020 from 192.168.1.27
To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.


~~~
### The VM instance in the private subnet cannot reach destinations outside of your virtual network.
~~~

~$ ping 8.8.8.8
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.

