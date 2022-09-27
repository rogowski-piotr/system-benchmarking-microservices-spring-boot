# this is default vpc in aws ,
# this niether be created during terraform apply and nor be destroyed during terraform destroy
# this the just for referncing attribute of default vpc

resource "aws_default_vpc" "default_vpc" {
  tags = {
    Name = "Default VPC"
  }
}