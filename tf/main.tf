provider "aws" {

    region = "ap-south-1"
  
}

data "aws_ami" "ubuntu" {
    
    most_recent = true
        
    filter {
       name   = "name"
       values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }

      owners = ["099720109477"] #canonical
}

data "aws_security_group" "sg" {

    tags = {
        Name =  "default"
    }
  
}

resource "aws_key_pair" "name" {
    
    key_name = "newkey_1"
    public_key = file(var.public_key)

}

resource "aws_instance" "instance" {

    for_each = toset([ "instance-1" ,"instance-2" ])
    ami = data.aws_ami.ubuntu.id
    instance_type = "t2.micro"
    key_name = aws_key_pair.name
    vpc_security_group_ids = [data.aws_security_group.sg.id]
    
    tags = {
        Name = each.key
    }

}