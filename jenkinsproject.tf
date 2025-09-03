provider "aws" {
  region = "us-east-1"
}

data "aws_vpc" "existing" {
  id = "vpc-0d70179c349e98540"
}

data "aws_subnet" "existing" {
  id = "subnet-09e452b7e0205f53b"
}

resource "aws_instance" "one" {
  count                  = 4
  ami                    = "ami-0360c520857e3138f"
  instance_type          = "t2.medium"
  key_name               = "kkeypair"
  subnet_id              = data.aws_subnet.existing.id
  vpc_security_group_ids = ["sg-0335c4fe474fed430"]

  tags = {
    Name = var.instance_names[count.index]
  }
}

variable "instance_names" {
  default = ["jenkins", "tomcat-1", "tomcat-2", "Monitoring server"]
}
