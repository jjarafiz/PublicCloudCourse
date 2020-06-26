# Deploy a Cloud-Based Web Server 

This is the third exercise of the course.

List of tasks:

* Create an SSH key pair
* Deploy a virtual machine in default VPC
* Create a public S3 bucket. Upload a picture (JPG or PNG) file of your choice into that bucket.
* Turn the S3 bucket into a static web site.
* Install and enable a web server.
* Add a static web page that references the picture in your cloud storage.
* (Optional) Use server-side include to add ifconfig printout
to the web page.

## Deployment of the Web Server in AWS using Terraform
~~~

terraform validate
Success! The configuration is valid.

terraform apply

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.WebVM will be created
  + resource "aws_instance" "WebVM" {
      + ami                          = "ami-0d359437d1756caa8"
      + arn                          = (known after apply)
      + associate_public_ip_address  = true
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
      + tenancy                      = (known after apply)
      + user_data                    = "b1cb1f77c032ea4f43018629246c08ec040891f5"
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

  # aws_key_pair.keys will be created
  + resource "aws_key_pair" "keys" {
      + arn         = (known after apply)
      + fingerprint = (known after apply)
      + id          = (known after apply)
      + key_name    = "JJKey"
      + key_pair_id = (known after apply)
      + public_key  = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCABgEv5E5+h5+wOnH+wtvRgIOHZbjB1rsKDVtUwNOsCo6dCtfTMVvyHKCePKbnh5cX2HacNQPfoBKPxmb/cqf4WqFRSEys/GDKW/AWJ09P7uzYKMi7La8gd+ljzd7rbscac3EsSuN4ufcNjclcWxIsKAt1O4NjVrggtNLRhecqlAF6DwuaJlfBCr390BuvPQ3MQ2WJPTtcpQUDfTxfi4OiBdC9d9ip4WjLqm3UM1Fo5Q6A77VzLrxEd5YzwWeNjPX1L6LVZ215W+VdyL2LwpFpbYfWcovJ3T6AKH0Xma25kD11ugPrdKgSR5DpXHCd3t5PlI7srG6smFEYaCKGlRWd"
    }

  # aws_s3_bucket.b will be created
  + resource "aws_s3_bucket" "b" {
      + acceleration_status         = (known after apply)
      + acl                         = "public-read"
      + arn                         = (known after apply)
      + bucket                      = "s3-cloudcourse-website"
      + bucket_domain_name          = (known after apply)
      + bucket_regional_domain_name = (known after apply)
      + force_destroy               = false
      + hosted_zone_id              = (known after apply)
      + id                          = (known after apply)
      + policy                      = jsonencode(
            {
              + Statement = [
                  + {
                      + Action    = [
                          + "s3:GetObject",
                        ]
                      + Effect    = "Allow"
                      + Principal = "*"
                      + Resource  = [
                          + "arn:aws:s3:::s3-cloudcourse-website/*",
                        ]
                      + Sid       = "PublicRead"
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + region                      = (known after apply)
      + request_payer               = (known after apply)
      + website_domain              = (known after apply)
      + website_endpoint            = (known after apply)

      + versioning {
          + enabled    = (known after apply)
          + mfa_delete = (known after apply)
        }
    }

  # aws_s3_bucket_object.image will be created
  + resource "aws_s3_bucket_object" "image" {
      + acl                    = "public-read"
      + bucket                 = (known after apply)
      + content_type           = (known after apply)
      + etag                   = "e1902ad0aa4610cd19bd09274205d0cd"
      + force_destroy          = false
      + id                     = (known after apply)
      + key                    = "Web.png"
      + server_side_encryption = (known after apply)
      + source                 = "Web.png"
      + storage_class          = (known after apply)
      + version_id             = (known after apply)
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

Plan: 5 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_key_pair.keys: Creating...
aws_security_group.web_sg: Creating...
aws_s3_bucket.b: Creating...
aws_key_pair.keys: Creation complete after 0s [id=JJKey]
aws_security_group.web_sg: Creation complete after 2s [id=sg-042fcb74f6a8f3fee]
aws_instance.WebVM: Creating...
aws_s3_bucket.b: Creation complete after 4s [id=s3-cloudcourse-website]
aws_s3_bucket_object.image: Creating...
aws_s3_bucket_object.image: Creation complete after 0s [id=Web.png]
aws_instance.WebVM: Still creating... [10s elapsed]
aws_instance.WebVM: Still creating... [20s elapsed]
aws_instance.WebVM: Creation complete after 22s [id=i-0eae5597237f8a1f7]

~~~
