# this recource will create a ec2 instance with specified specs
resource "aws_instance" "ec2_instance" {
  ami                    = "ami-0a1ee2fb28fe05df3"            # this is a amazon linux ami id
  instance_type          = "t2.micro"
  security_groups = [aws_security_group.security_group.name]
  tags = {
    Name = "webServer"
  }
}