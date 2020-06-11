# Simple Infrastructure-as-Code Setup

This is the second exercise of the course. I will work with AWS.

Regarding the tool, I will do the exercise with 3 different tools:

* Ansible 
* CLoudFormation 
* Terraform 

I am going to execute the same tasks with each tool:

* Create VPC
* Modify VPC Name
* Delete VPC

## ANSIBLE

### 1.1 CREATE VPC ANSIBLE

$ ansible-playbook  create-vpc.yaml
PLAY [localhost] ***************************************************************

TASK [Create a VPC] ************************************************************
changed: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=1    changed=1    unreachable=0    failed=0   

$ aws ec2 describe-vpcs
-----------------------------------------------------------
|                      DescribeVpcs                       |
+---------------------------------------------------------+
||                         Vpcs                          ||
|+-----------------------+-------------------------------+|
||  CidrBlock            |  192.168.1.0/24               ||
||  DhcpOptionsId        |  dopt-c2a372a8                ||
||  InstanceTenancy      |  default                      ||
||  IsDefault            |  False                        ||
||  OwnerId              |  379268274265                 ||
||  State                |  available                    ||
||  VpcId                |  vpc-0cb0d1e3c4964a78e        ||
|+-----------------------+-------------------------------+|
|||               CidrBlockAssociationSet               |||
||+----------------+------------------------------------+||
|||  AssociationId |  vpc-cidr-assoc-07e5c3ea2fbec9239  |||
|||  CidrBlock     |  192.168.1.0/24                    |||
||+----------------+------------------------------------+||
||||                  CidrBlockState                   ||||
|||+-------------------+-------------------------------+|||
||||  State            |  associated                   ||||
|||+-------------------+-------------------------------+|||
|||                        Tags                         |||
||+--------------------+--------------------------------+||
|||  Key               |  Name                          |||
|||  Value             |  first_vpc                     |||

### 1.2 MODIFY VPC NAME WITH ANSIBLE

$ ansible-playbook  update-vpc.yaml

PLAY [localhost] ***************************************************************

TASK [Change the name of a VPC] ************************************************
changed: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=1    changed=1    unreachable=0    failed=0   

$ aws ec2 describe-vpcs
-----------------------------------------------------------
|                      DescribeVpcs                       |
+---------------------------------------------------------+
||                         Vpcs                          ||
|+-----------------------+-------------------------------+|
||  CidrBlock            |  192.168.1.0/24               ||
||  DhcpOptionsId        |  dopt-c2a372a8                ||
||  InstanceTenancy      |  default                      ||
||  IsDefault            |  False                        ||
||  OwnerId              |  379268274265                 ||
||  State                |  available                    ||
||  VpcId                |  vpc-07ff771167f654ead        ||
|+-----------------------+-------------------------------+|
|||               CidrBlockAssociationSet               |||
||+----------------+------------------------------------+||
|||  AssociationId |  vpc-cidr-assoc-03dca65b726ff51a5  |||
|||  CidrBlock     |  192.168.1.0/24                    |||
||+----------------+------------------------------------+||
||||                  CidrBlockState                   ||||
|||+-------------------+-------------------------------+|||
||||  State            |  associated                   ||||
|||+-------------------+-------------------------------+|||
|||                        Tags                         |||
||+-------------------+---------------------------------+||
|||        Key        |              Value              |||
||+-------------------+---------------------------------+||
|||  Name             |  first_vpc                      |||
|||  name             |  JJ_vpc                         |||
||+-------------------+---------------------------------+||

### 1.3 DELETE VPC WITH ANSIBLE

$ ansible-playbook create-vpc.yaml -v -e state=absent

PLAY [localhost] ***************************************************************

TASK [Create a VPC] ************************************************************
changed: [localhost] => {"changed": true, "vpc": {}}

PLAY RECAP *********************************************************************
localhost                  : ok=1    changed=1    unreachable=0    failed=0   

$ aws ec2 describe-vpcs
--------------------------------------------------
|                  DescribeVpcs                  |
+------------------------------------------------+
||                     Vpcs                     ||
|+-----------------------+----------------------+|
||  CidrBlock            |  172.31.0.0/16       ||
||  DhcpOptionsId        |  dopt-c2a372a8       ||
||  InstanceTenancy      |  default             ||
||  IsDefault            |  True                ||
||  OwnerId              |  379268274265        ||
||  State                |  available           ||
||  VpcId                |  vpc-2d62b447        ||
|+-----------------------+----------------------+|
|||           CidrBlockAssociationSet          |||
||+----------------+---------------------------+||
|||  AssociationId |  vpc-cidr-assoc-068e2f6d  |||
|||  CidrBlock     |  172.31.0.0/16            |||
||+----------------+---------------------------+||
||||              CidrBlockState              ||||
|||+---------------+--------------------------+|||
||||  State        |  associated              ||||
|||+---------------+--------------------------+|||

## CLOUDFORMATION

### 2.1 CREATE VPC WITH CLOUDFORMATION

$ aws ec2 describe-vpcs
--------------------------------------------------
|                  DescribeVpcs                  |
+------------------------------------------------+
||                     Vpcs                     ||
|+-----------------------+----------------------+|
||  CidrBlock            |  172.31.0.0/16       ||
||  DhcpOptionsId        |  dopt-c2a372a8       ||
||  InstanceTenancy      |  default             ||
||  IsDefault            |  True                ||
||  OwnerId              |  379268274265        ||
||  State                |  available           ||
||  VpcId                |  vpc-2d62b447        ||
|+-----------------------+----------------------+|
|||           CidrBlockAssociationSet          |||
||+----------------+---------------------------+||
|||  AssociationId |  vpc-cidr-assoc-068e2f6d  |||
|||  CidrBlock     |  172.31.0.0/16            |||
||+----------------+---------------------------+||
||||              CidrBlockState              ||||
|||+---------------+--------------------------+|||
||||  State        |  associated              ||||
|||+---------------+--------------------------+|||


$ aws cloudformation validate-template --template-body file://create-vpc.yaml
-------------------------------------------------------------
|                     ValidateTemplate                      |
+-------------------------------+---------------------------+
|  Description                  |  Basic VPC                |
+-------------------------------+---------------------------+
||                       Parameters                        ||
|+--------------+---------------+---------+----------------+|
|| DefaultValue |  Description  | NoEcho  | ParameterKey   ||
|+--------------+---------------+---------+----------------+|
||  unnamed     |  VPC name     |  False  |  Name          ||

$ aws cloudformation describe-stacks
----------------
|DescribeStacks|
+--------------+

$ aws cloudformation create-stack --stack-name JJ-cfn --template-body file://create-vpc.yaml --parameters ParameterKey=Name,ParameterValue=first_vpc
-------------------------------------------------------------------------------------------------------------------
|                                                   CreateStack                                                   |
+---------+-------------------------------------------------------------------------------------------------------+
|  StackId|  arn:aws:cloudformation:eu-central-1:379268274265:stack/JJ-cfn/059e4e70-ab47-11ea-957e-0a3f04c080ce   |
+---------+-------------------------------------------------------------------------------------------------------+
$ aws cloudformation describe-stacks
-----------------------------------------------------------------------------------------------------------------------------
|                                                      DescribeStacks                                                       |
+---------------------------------------------------------------------------------------------------------------------------+
||                                                         Stacks                                                          ||
|+-----------------+-------------------------------------------------------------------------------------------------------+|
||  CreationTime   |  2020-06-10T18:20:11.389000+00:00                                                                     ||
||  Description    |  Basic VPC                                                                                            ||
||  DisableRollback|  False                                                                                                ||
||  StackId        |  arn:aws:cloudformation:eu-central-1:379268274265:stack/JJ-cfn/059e4e70-ab47-11ea-957e-0a3f04c080ce   ||
||  StackName      |  JJ-cfn                                                                                               ||
||  StackStatus    |  CREATE_COMPLETE                                                                                      ||
|+-----------------+-------------------------------------------------------------------------------------------------------+|
|||                                                   DriftInformation                                                    |||
||+-------------------------------------------------------------------+---------------------------------------------------+||
|||  StackDriftStatus                                                 |  NOT_CHECKED                                      |||
||+-------------------------------------------------------------------+---------------------------------------------------+||
|||                                                        Outputs                                                        |||
||+--------------------------------+-----------------------------+--------------------------------------------------------+||
|||           Description          |          OutputKey          |                      OutputValue                       |||
||+--------------------------------+-----------------------------+--------------------------------------------------------+||
|||  VPC ID                        |  VPC                        |  vpc-0aa6ee7be60bac5d2                                 |||
|||  VPC Name                      |  Name                       |  first_vpc                                             |||
||+--------------------------------+-----------------------------+--------------------------------------------------------+||
|||                                                      Parameters                                                       |||
||+--------------------------------------------------------------------+--------------------------------------------------+||
|||  ParameterKey                                                      |  Name                                            |||
|||  ParameterValue                                                    |  first_vpc                                       |||
||+--------------------------------------------------------------------+--------------------------------------------------+||
$ aws ec2 describe-vpcs
---------------------------------------------------------------------------------------------------------------------------------------------
|                                                               DescribeVpcs                                                                |
+-------------------------------------------------------------------------------------------------------------------------------------------+
||                                                                  Vpcs                                                                   ||
|+----------------------------------------------------------+------------------------------------------------------------------------------+|
||  CidrBlock                                               |  192.168.1.0/24                                                              ||
||  DhcpOptionsId                                           |  dopt-c2a372a8                                                               ||
||  InstanceTenancy                                         |  default                                                                     ||
||  IsDefault                                               |  False                                                                       ||
||  OwnerId                                                 |  379268274265                                                                ||
||  State                                                   |  available                                                                   ||
||  VpcId                                                   |  vpc-0aa6ee7be60bac5d2                                                       ||
|+----------------------------------------------------------+------------------------------------------------------------------------------+|
|||                                                        CidrBlockAssociationSet                                                        |||
||+------------------------------------------+--------------------------------------------------------------------------------------------+||
|||  AssociationId                           |  vpc-cidr-assoc-06a8429ed27f365a0                                                          |||
|||  CidrBlock                               |  192.168.1.0/24                                                                            |||
||+------------------------------------------+--------------------------------------------------------------------------------------------+||
||||                                                           CidrBlockState                                                            ||||
|||+---------------------------------------------------+---------------------------------------------------------------------------------+|||
||||  State                                            |  associated                                                                     ||||
|||+---------------------------------------------------+---------------------------------------------------------------------------------+|||
|||                                                                 Tags                                                                  |||
||+-------------------------------+-------------------------------------------------------------------------------------------------------+||
|||              Key              |                                                 Value                                                 |||
||+-------------------------------+-------------------------------------------------------------------------------------------------------+||
|||  aws:cloudformation:stack-name|  JJ-cfn                                                                                               |||
|||  name                         |  first_vpc                                                                                            |||
|||  aws:cloudformation:stack-id  |  arn:aws:cloudformation:eu-central-1:379268274265:stack/JJ-cfn/059e4e70-ab47-11ea-957e-0a3f04c080ce   |||
|||  aws:cloudformation:logical-id|  VPC                                                                                                  |||
||+-------------------------------+-------------------------------------------------------------------------------------------------------+||
||                                                                  Vpcs                                                                   ||
|+-----------------------------------------------------------------------+-----------------------------------------------------------------+|
||  CidrBlock                                                            |  172.31.0.0/16                                                  ||
||  DhcpOptionsId                                                        |  dopt-c2a372a8                                                  ||
||  InstanceTenancy                                                      |  default                                                        ||
||  IsDefault                                                            |  True                                                           ||
||  OwnerId                                                              |  379268274265                                                   ||
||  State                                                                |  available                                                      ||
||  VpcId                                                                |  vpc-2d62b447                                                   ||
|+-----------------------------------------------------------------------+-----------------------------------------------------------------+|
|||                                                        CidrBlockAssociationSet                                                        |||
||+---------------------------------------------------+-----------------------------------------------------------------------------------+||
|||  AssociationId                                    |  vpc-cidr-assoc-068e2f6d                                                          |||
|||  CidrBlock                                        |  172.31.0.0/16                                                                    |||
||+---------------------------------------------------+-----------------------------------------------------------------------------------+||
||||                                                           CidrBlockState                                                            ||||
|||+---------------------------------------------------+---------------------------------------------------------------------------------+|||
||||  State                                            |  associated                                                                     ||||
|||+---------------------------------------------------+---------------------------------------------------------------------------------+|||

### 2.2 MODIFY VPC NAME WITH CLOUDFORMATION

$aws cloudformation update-stack --stack-name JJ-cfn --use-previous-template --parameters ParameterKey=Name,ParameterValue=JJ_vpc
-------------------------------------------------------------------------------------------------------------------
|                                                   UpdateStack                                                   |
+---------+-------------------------------------------------------------------------------------------------------+
|  StackId|  arn:aws:cloudformation:eu-central-1:379268274265:stack/JJ-cfn/059e4e70-ab47-11ea-957e-0a3f04c080ce   |
+---------+-------------------------------------------------------------------------------------------------------+
$ aws cloudformation describe-stacks
-----------------------------------------------------------------------------------------------------------------------------
|                                                      DescribeStacks                                                       |
+---------------------------------------------------------------------------------------------------------------------------+
||                                                         Stacks                                                          ||
|+-----------------+-------------------------------------------------------------------------------------------------------+|
||  CreationTime   |  2020-06-10T18:20:11.389000+00:00                                                                     ||
||  Description    |  Basic VPC                                                                                            ||
||  DisableRollback|  False                                                                                                ||
||  LastUpdatedTime|  2020-06-10T18:32:37.434000+00:00                                                                     ||
||  StackId        |  arn:aws:cloudformation:eu-central-1:379268274265:stack/JJ-cfn/059e4e70-ab47-11ea-957e-0a3f04c080ce   ||
||  StackName      |  JJ-cfn                                                                                               ||
||  StackStatus    |  UPDATE_COMPLETE                                                                                      ||
|+-----------------+-------------------------------------------------------------------------------------------------------+|
|||                                                   DriftInformation                                                    |||
||+-------------------------------------------------------------------+---------------------------------------------------+||
|||  StackDriftStatus                                                 |  NOT_CHECKED                                      |||
||+-------------------------------------------------------------------+---------------------------------------------------+||
|||                                                        Outputs                                                        |||
||+--------------------------------+-----------------------------+--------------------------------------------------------+||
|||           Description          |          OutputKey          |                      OutputValue                       |||
||+--------------------------------+-----------------------------+--------------------------------------------------------+||
|||  VPC ID                        |  VPC                        |  vpc-0aa6ee7be60bac5d2                                 |||
|||  VPC Name                      |  Name                       |  JJ_vpc                                                |||
||+--------------------------------+-----------------------------+--------------------------------------------------------+||
|||                                                      Parameters                                                       |||
||+----------------------------------------------------------------------------+------------------------------------------+||
|||  ParameterKey                                                              |  Name                                    |||
|||  ParameterValue                                                            |  JJ_vpc                                  |||
||+----------------------------------------------------------------------------+------------------------------------------+||

$aws ec2 describe-vpcs
---------------------------------------------------------------------------------------------------------------------------------------------
|                                                               DescribeVpcs                                                                |
+-------------------------------------------------------------------------------------------------------------------------------------------+
||                                                                  Vpcs                                                                   ||
|+----------------------------------------------------------+------------------------------------------------------------------------------+|
||  CidrBlock                                               |  192.168.1.0/24                                                              ||
||  DhcpOptionsId                                           |  dopt-c2a372a8                                                               ||
||  InstanceTenancy                                         |  default                                                                     ||
||  IsDefault                                               |  False                                                                       ||
||  OwnerId                                                 |  379268274265                                                                ||
||  State                                                   |  available                                                                   ||
||  VpcId                                                   |  vpc-0aa6ee7be60bac5d2                                                       ||
|+----------------------------------------------------------+------------------------------------------------------------------------------+|
|||                                                        CidrBlockAssociationSet                                                        |||
||+------------------------------------------+--------------------------------------------------------------------------------------------+||
|||  AssociationId                           |  vpc-cidr-assoc-06a8429ed27f365a0                                                          |||
|||  CidrBlock                               |  192.168.1.0/24                                                                            |||
||+------------------------------------------+--------------------------------------------------------------------------------------------+||
||||                                                           CidrBlockState                                                            ||||
|||+---------------------------------------------------+---------------------------------------------------------------------------------+|||
||||  State                                            |  associated                                                                     ||||
|||+---------------------------------------------------+---------------------------------------------------------------------------------+|||
|||                                                                 Tags                                                                  |||
||+-------------------------------+-------------------------------------------------------------------------------------------------------+||
|||              Key              |                                                 Value                                                 |||
||+-------------------------------+-------------------------------------------------------------------------------------------------------+||
|||  aws:cloudformation:stack-name|  JJ-cfn                                                                                               |||
|||  aws:cloudformation:stack-id  |  arn:aws:cloudformation:eu-central-1:379268274265:stack/JJ-cfn/059e4e70-ab47-11ea-957e-0a3f04c080ce   |||
|||  name                         |  JJ_vpc                                                                                               |||
|||  aws:cloudformation:logical-id|  VPC                                                                                                  |||
||+-------------------------------+-------------------------------------------------------------------------------------------------------+||
||                                                                  Vpcs                                                                   ||
|+-----------------------------------------------------------------------+-----------------------------------------------------------------+|
||  CidrBlock                                                            |  172.31.0.0/16                                                  ||
||  DhcpOptionsId                                                        |  dopt-c2a372a8                                                  ||
||  InstanceTenancy                                                      |  default                                                        ||
||  IsDefault                                                            |  True                                                           ||
||  OwnerId                                                              |  379268274265                                                   ||
||  State                                                                |  available                                                      ||
||  VpcId                                                                |  vpc-2d62b447                                                   ||
|+-----------------------------------------------------------------------+-----------------------------------------------------------------+|
|||                                                        CidrBlockAssociationSet                                                        |||
||+---------------------------------------------------+-----------------------------------------------------------------------------------+||
|||  AssociationId                                    |  vpc-cidr-assoc-068e2f6d                                                          |||
|||  CidrBlock                                        |  172.31.0.0/16                                                                    |||
||+---------------------------------------------------+-----------------------------------------------------------------------------------+||
||||                                                           CidrBlockState                                                            ||||
|||+---------------------------------------------------+---------------------------------------------------------------------------------+|||
||||  State                                            |  associated                                                                     ||||
|||+---------------------------------------------------+---------------------------------------------------------------------------------+|||

### 2.3 DELETE VPC WITH CLOUDFORMATION

$ aws cloudformation delete-stack --stack-name JJ-cfn

$ aws cloudformation describe-stacks
----------------
|DescribeStacks|
+--------------+
$ aws ec2 describe-vpcs
--------------------------------------------------
|                  DescribeVpcs                  |
+------------------------------------------------+
||                     Vpcs                     ||
|+-----------------------+----------------------+|
||  CidrBlock            |  172.31.0.0/16       ||
||  DhcpOptionsId        |  dopt-c2a372a8       ||
||  InstanceTenancy      |  default             ||
||  IsDefault            |  True                ||
||  OwnerId              |  379268274265        ||
||  State                |  available           ||
||  VpcId                |  vpc-2d62b447        ||
|+-----------------------+----------------------+|
|||           CidrBlockAssociationSet          |||
||+----------------+---------------------------+||
|||  AssociationId |  vpc-cidr-assoc-068e2f6d  |||
|||  CidrBlock     |  172.31.0.0/16            |||
||+----------------+---------------------------+||
||||              CidrBlockState              ||||
|||+---------------+--------------------------+|||
||||  State        |  associated              ||||
|||+---------------+--------------------------+|||

## TERRAFORM

### 3.1 CREATE VPC WITH TERRAFORM

$ terraform plan -out plans/create-vpc.tfplan
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.


------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

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
          + "Name" = "first_vpc"
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

This plan was saved to: plans/create-vpc.tfplan

To perform exactly these actions, run the following command to apply:
    terraform apply "plans/create-vpc.tfplan"

$ terraform apply plans/create-vpc.tfplan
aws_vpc.first_VPC: Creating...
aws_vpc.first_VPC: Creation complete after 2s [id=vpc-0f0ec44a09285ebe1]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

The state of your infrastructure has been saved to the path
below. This state is required to modify and destroy your
infrastructure, so keep it safe. To inspect the complete state
use the `terraform show` command.

State path: terraform.tfstate
jj@jj-VirtualBox:~/PublicCloudExercises/PublicCloudCourse/Exercise2_IAC/Terraform$ terraform show
# aws_vpc.first_VPC:
resource "aws_vpc" "first_VPC" {
    arn                              = "arn:aws:ec2:eu-central-1:379268274265:vpc/vpc-0f0ec44a09285ebe1"
    assign_generated_ipv6_cidr_block = false
    cidr_block                       = "192.168.1.0/24"
    default_network_acl_id           = "acl-0aa8bee918de7b71a"
    default_route_table_id           = "rtb-09e9f5c2d27480e59"
    default_security_group_id        = "sg-08e29cf09d9bf1429"
    dhcp_options_id                  = "dopt-c2a372a8"
    enable_dns_hostnames             = true
    enable_dns_support               = true
    id                               = "vpc-0f0ec44a09285ebe1"
    instance_tenancy                 = "default"
    main_route_table_id              = "rtb-09e9f5c2d27480e59"
    owner_id                         = "379268274265"
    tags                             = {
        "Name" = "first_vpc"
    }
}
$ aws ec2 describe-vpcs
-----------------------------------------------------------
|                      DescribeVpcs                       |
+---------------------------------------------------------+
||                         Vpcs                          ||
|+-----------------------+-------------------------------+|
||  CidrBlock            |  192.168.1.0/24               ||
||  DhcpOptionsId        |  dopt-c2a372a8                ||
||  InstanceTenancy      |  default                      ||
||  IsDefault            |  False                        ||
||  OwnerId              |  379268274265                 ||
||  State                |  available                    ||
||  VpcId                |  vpc-0f0ec44a09285ebe1        ||
|+-----------------------+-------------------------------+|
|||               CidrBlockAssociationSet               |||
||+----------------+------------------------------------+||
|||  AssociationId |  vpc-cidr-assoc-0091c43f792ca7e0f  |||
|||  CidrBlock     |  192.168.1.0/24                    |||
||+----------------+------------------------------------+||
||||                  CidrBlockState                   ||||
|||+-------------------+-------------------------------+|||
||||  State            |  associated                   ||||
|||+-------------------+-------------------------------+|||
|||                        Tags                         |||
||+--------------------+--------------------------------+||
|||  Key               |  Name                          |||
|||  Value             |  first_vpc                     |||
||+--------------------+--------------------------------+||

### 3.2 MODIFY VPC NAME WITH TERRAFORM

$ terraform apply -var-file update-vpc.tfvars
aws_vpc.first_VPC: Refreshing state... [id=vpc-0f0ec44a09285ebe1]

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  ~ update in-place

Terraform will perform the following actions:

  # aws_vpc.first_VPC will be updated in-place
  ~ resource "aws_vpc" "first_VPC" {
        arn                              = "arn:aws:ec2:eu-central-1:379268274265:vpc/vpc-0f0ec44a09285ebe1"
        assign_generated_ipv6_cidr_block = false
        cidr_block                       = "192.168.1.0/24"
        default_network_acl_id           = "acl-0aa8bee918de7b71a"
        default_route_table_id           = "rtb-09e9f5c2d27480e59"
        default_security_group_id        = "sg-08e29cf09d9bf1429"
        dhcp_options_id                  = "dopt-c2a372a8"
        enable_dns_hostnames             = true
        enable_dns_support               = true
        id                               = "vpc-0f0ec44a09285ebe1"
        instance_tenancy                 = "default"
        main_route_table_id              = "rtb-09e9f5c2d27480e59"
        owner_id                         = "379268274265"
      ~ tags                             = {
          ~ "Name" = "first_vpc" -> "JJ_vpc"
        }
    }

Plan: 0 to add, 1 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_vpc.first_VPC: Modifying... [id=vpc-0f0ec44a09285ebe1]
aws_vpc.first_VPC: Modifications complete after 2s [id=vpc-0f0ec44a09285ebe1]

Apply complete! Resources: 0 added, 1 changed, 0 destroyed.
$ terraform show
# aws_vpc.first_VPC:
resource "aws_vpc" "first_VPC" {
    arn                              = "arn:aws:ec2:eu-central-1:379268274265:vpc/vpc-0f0ec44a09285ebe1"
    assign_generated_ipv6_cidr_block = false
    cidr_block                       = "192.168.1.0/24"
    default_network_acl_id           = "acl-0aa8bee918de7b71a"
    default_route_table_id           = "rtb-09e9f5c2d27480e59"
    default_security_group_id        = "sg-08e29cf09d9bf1429"
    dhcp_options_id                  = "dopt-c2a372a8"
    enable_dns_hostnames             = true
    enable_dns_support               = true
    id                               = "vpc-0f0ec44a09285ebe1"
    instance_tenancy                 = "default"
    main_route_table_id              = "rtb-09e9f5c2d27480e59"
    owner_id                         = "379268274265"
    tags                             = {
        "Name" = "JJ_vpc"
    }
}
$ aws ec2 describe-vpcs
-----------------------------------------------------------
|                      DescribeVpcs                       |
+---------------------------------------------------------+
||                         Vpcs                          ||
|+-----------------------+-------------------------------+|
||  CidrBlock            |  192.168.1.0/24               ||
||  DhcpOptionsId        |  dopt-c2a372a8                ||
||  InstanceTenancy      |  default                      ||
||  IsDefault            |  False                        ||
||  OwnerId              |  379268274265                 ||
||  State                |  available                    ||
||  VpcId                |  vpc-0f0ec44a09285ebe1        ||
|+-----------------------+-------------------------------+|
|||               CidrBlockAssociationSet               |||
||+----------------+------------------------------------+||
|||  AssociationId |  vpc-cidr-assoc-0091c43f792ca7e0f  |||
|||  CidrBlock     |  192.168.1.0/24                    |||
||+----------------+------------------------------------+||
||||                  CidrBlockState                   ||||
|||+-------------------+-------------------------------+|||
||||  State            |  associated                   ||||
|||+-------------------+-------------------------------+|||
|||                        Tags                         |||
||+------------------------+----------------------------+||
|||  Key                   |  Name                      |||
|||  Value                 |  JJ_vpc                    |||
||+------------------------+----------------------------+||

### 3.3 DELETE VPC WITH TERRAFORM

$ terraform destroy
aws_vpc.first_VPC: Refreshing state... [id=vpc-0f0ec44a09285ebe1]

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # aws_vpc.first_VPC will be destroyed
  - resource "aws_vpc" "first_VPC" {
      - arn                              = "arn:aws:ec2:eu-central-1:379268274265:vpc/vpc-0f0ec44a09285ebe1" -> null
      - assign_generated_ipv6_cidr_block = false -> null
      - cidr_block                       = "192.168.1.0/24" -> null
      - default_network_acl_id           = "acl-0aa8bee918de7b71a" -> null
      - default_route_table_id           = "rtb-09e9f5c2d27480e59" -> null
      - default_security_group_id        = "sg-08e29cf09d9bf1429" -> null
      - dhcp_options_id                  = "dopt-c2a372a8" -> null
      - enable_dns_hostnames             = true -> null
      - enable_dns_support               = true -> null
      - id                               = "vpc-0f0ec44a09285ebe1" -> null
      - instance_tenancy                 = "default" -> null
      - main_route_table_id              = "rtb-09e9f5c2d27480e59" -> null
      - owner_id                         = "379268274265" -> null
      - tags                             = {
          - "Name" = "JJ_vpc"
        } -> null
    }

Plan: 0 to add, 0 to change, 1 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

aws_vpc.first_VPC: Destroying... [id=vpc-0f0ec44a09285ebe1]
aws_vpc.first_VPC: Destruction complete after 0s

Destroy complete! Resources: 1 destroyed.
jj@jj-VirtualBox:~/PublicCloudExercises/PublicCloudCourse/Exercise2_IAC/Terraform$ terraform show

