
provider "aws" {
  region = var.region
}
################
# Security Group
################
resource "aws_security_group" "web_sg" {
  name = "web security group"
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

##############
# SSH Key Pair
##############
resource "aws_key_pair" "keys" {
  key_name   = "JJKey"
  public_key = file("KeyPairJJ.pub")
}
###########
# S3 BUCKET
###########
# S3 bucket
resource "aws_s3_bucket" "b" {
  bucket = "s3-cloudcourse-website"
  acl    = "public-read"
  policy = file("policy.json")

}
resource "aws_s3_bucket_object" "image" {
  bucket       = aws_s3_bucket.b.id
  key          = "Web.png"
  source       = "Web.png"
  acl          = "public-read"
  etag 	       = filemd5("Web.png")
}


##############
# EC2 INSTANCE
##############

resource "aws_instance" "WebVM" {
  ami = var.instance_ami
  instance_type = var.instance_type
  vpc_security_group_ids =  [aws_security_group.web_sg.id] 
  key_name = aws_key_pair.keys.id
  associate_public_ip_address = "true"
  user_data                   = file("install_apache.sh")
}


