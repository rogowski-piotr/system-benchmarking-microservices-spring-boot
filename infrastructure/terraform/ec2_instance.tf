# this recource will create a ec2 instance with specified specs
resource "aws_instance" "ec2_instance" {
  ami                    = "ami-065deacbcaac64cf2"            # this is a Ubuntu linux ami id
  instance_type          = "t2.micro"
  security_groups = [aws_security_group.security_group.name]
  tags = {
    Name = "webServer"
  }
}