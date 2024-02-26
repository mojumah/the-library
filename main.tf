terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-1"
}

resource "aws_vpc" "library" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "library"
  }
  
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.library.id

  tags = {
    Name = "library-gw"
  }
  
}

resource "aws_subnet" "es1" {
  vpc_id = aws_vpc.library.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "es1"
  }
  
}

resource "aws_subnet" "es2" {
  vpc_id = aws_vpc.library.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "es2"
  }
  
}

resource "aws_route_table" "es1" {
  vpc_id = aws_vpc.library.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "es1 route table"
  }
  
}

resource "aws_route_table_association" "es1" {
  subnet_id = "${aws_subnet.es1.id}"
  route_table_id = "${aws_route_table.es1.id}"
  
}

resource "aws_route_table" "es2" {
  vpc_id = aws_vpc.library.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "es2 route table"
  }
  
}

resource "aws_route_table_association" "es2" {
  subnet_id = "${aws_subnet.es2.id}"
  route_table_id = "${aws_route_table.es2.id}"
  
}

resource "aws_security_group" "allow_ssh" {
  name = "allow_ssh"
  description = "Allow SSH"
  vpc_id = aws_vpc.library.id

  ingress {
    description = "SSH from VPC"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }  

  ingress {
    description = "http from world"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }  

  ingress {
    description = "https from world"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  } 

  ingress {
    description = "All TCP from salt master"
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["${aws_instance.salt-master.private_ip}/32"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "salt minion security group"
  }


}

resource "aws_security_group" "allow_ssh_to_salt_master" {
  name = "allow_ssh_to_salt_master"
  description = "Allow SSH"
  vpc_id = aws_vpc.library.id

  ingress {
    description = "SSH from VPC"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "salt-master"
  }

}

resource "aws_security_group_rule" "allow_salt_specefic_port" {
  type = "ingress"
  from_port = 4505
  to_port = 4505
  protocol = "tcp"
  security_group_id = aws_security_group.allow_ssh_to_salt_master.id
  cidr_blocks = ["${aws_instance.minion-website.private_ip}/32"]

}

resource "aws_security_group_rule" "allow_salt_specific_port_2" {
  type = "ingress"
  from_port = 4506
  to_port = 4506
  protocol = "tcp"
  security_group_id = aws_security_group.allow_ssh_to_salt_master.id
  cidr_blocks = ["${aws_instance.minion-website.private_ip}/32"]
}

resource "aws_security_group_rule" "allow_all_TCP_from_salt_minion" {
  type = "ingress"
  from_port = 0
  to_port = 65535
  protocol = "tcp"
  security_group_id = aws_security_group.allow_ssh_to_salt_master.id
  cidr_blocks = ["${aws_instance.minion-website.private_ip}/32"] 
}

data "template_file" "user_data" {
  template = file("/home/mo/workspace/library/script/install-salt-master.yaml")
}

resource "aws_instance" "minion-website" {
  ami           = "ami-0277155c3f0ab2930"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.es1.id
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]
  key_name = "library-key"
  user_data = data.template_file.user_data.rendered

  tags = {
    Name = "minion-website"
  }
}

resource "aws_eip" "minion-website-ip" {
  instance = aws_instance.minion-website.id
  vpc      = true
}

data "template_file" "user_data_of_the_salt_master" {
  template = file("/home/mo/workspace/library/script/install-nginx.yaml")
}

resource "aws_instance" "salt-master" {
  ami           = "ami-0277155c3f0ab2930"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.es1.id
  vpc_security_group_ids = ["${aws_security_group.allow_ssh_to_salt_master.id}"]
  key_name = "library-key"
  user_data = data.template_file.user_data.rendered

  tags = {
    Name = "salt-master"
  }
}

resource "aws_eip" "website-ip" {
  instance = aws_instance.salt-master.id
  vpc      = true
}