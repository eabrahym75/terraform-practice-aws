# Refer to the template file - install_nginx.sh
data "template_file" "user_data1" {
  template = "${file("install-nginx.sh")}"

}


# Create EC2 Instance - Ubuntu 20.04 for nginx
resource "aws_instance" "my-nginx-server2ws" {
  ami                    = "ami-0aa2b7722dc1b5612"
  instance_type          = "t2.micro"
  availability_zone      = "us-east-1a"
  key_name               = "aws_key"
  vpc_security_group_ids = ["${aws_security_group.my_asg.id}"]
  
  # user_data : render the template
  user_data     = base64encode("${data.template_file.user_data1.rendered}")

  tags = {
    "Name" = "Ubuntu Nginx server"
  }
}

# Refer to the template file - install-apache.sh
data "template_file" "user_data2" {
  template = "${file("install-apache.sh")}"
}
# Create EC2 Instance - Ubuntu 20.04 for Apache
resource "aws_instance" "my-apache-server1s3" {
  ami                    = "ami-0aa2b7722dc1b5612"
  instance_type          = "t2.micro"
  availability_zone      = "us-east-1a"
  key_name               = "aws_key"
  vpc_security_group_ids = ["${aws_security_group.my_asg.id}"]
  # user_data : render the template
  user_data     = base64encode("${data.template_file.user_data2.rendered}")

  tags = {
    "Name" = "Ubuntu Apache server"
  }
}


# Create a VPC
resource "aws_vpc" "my_test_vpc1" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    name = "dev"
  }
}

# creating a subnet
resource "aws_subnet" "my_test_vpc1_PublicSubnet" {
  vpc_id                  = aws_vpc.my_test_vpc1.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "Public Subnet"
  }
}

# create internet gateway
resource "aws_internet_gateway" "my_test_vpc1_Internetgateway" {
  vpc_id = aws_vpc.my_test_vpc1.id

  tags = {
    Name = "Gateway"
  }
}
# created a  route table to accept traffic from anywhere on the internet
resource "aws_route_table" "vpc_route" {
  vpc_id = aws_vpc.my_test_vpc1.id

  tags = {
    Name = "public-route"
  }
}

resource "aws_route" "route-inline" {
  route_table_id         = aws_route_table.vpc_route.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my_test_vpc1_Internetgateway.id

}

