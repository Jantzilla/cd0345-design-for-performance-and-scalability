provider "aws" {
    region = "us-east-1"
    access_key = "{ACCESS KEY}"
    secret_key = "{SECRET KEY}"
}

resource "aws_instance" "Udacity_T2" {
    count = "4"
    ami = "ami-0b0dcb5067f052a63"
    instance_type = "t2.micro"
    subnet_id = "subnet-07bf25415476ef128"
    tags = {
      Name = "Udacity T2"
    }
}

resource "aws_instance" "Udacity_M4" {
    count = "2"
    ami = "ami-0b0dcb5067f052a63"
    instance_type = "m4.large"
    subnet_id = "subnet-07bf25415476ef128"
    tags = {
      Name = "Udacity M4"
    }
}
