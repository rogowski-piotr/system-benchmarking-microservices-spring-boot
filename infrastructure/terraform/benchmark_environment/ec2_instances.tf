# this recource will create a ec2 instances with specified specs
resource "aws_instance" "ec2_instance_Benchmark_environment" {
  ami                    = "ami-065deacbcaac64cf2"            # this is a Ubuntu linux ami id
  instance_type          = "INSTANCE_TYPE"                    # this is a param for github workflow
  security_groups = [aws_security_group.security_group.name]
  key_name = "admin"
  tags = {
    Name = "Benchmark environment"
  }
}

resource "aws_instance" "ec2_instance_Benchmark_environment_1" {
  ami                    = "ami-065deacbcaac64cf2"            # this is a Ubuntu linux ami id
  instance_type          = "INSTANCE_TYPE"                    # this is a param for github workflow
  security_groups = [aws_security_group.security_group.name]
  key_name = "admin"
  tags = {
    Name = "Benchmark environment 1"
  }
}

resource "aws_instance" "ec2_instance_Benchmark_environment_2" {
  ami                    = "ami-065deacbcaac64cf2"            # this is a Ubuntu linux ami id
  instance_type          = "INSTANCE_TYPE"                    # this is a param for github workflow
  security_groups = [aws_security_group.security_group.name]
  key_name = "admin"
  tags = {
    Name = "Benchmark environment 2"
  }
}

# this recource will create a ec2 instance with specified specs
# resource "aws_instance" "ec2_instance_Load_generating_environment" {
#   ami                    = "ami-065deacbcaac64cf2"                  # this is a Ubuntu linux ami id     
#   instance_type          = "t2.micro"                    
#   security_groups = [aws_security_group.security_group.name]
#   key_name = "admin"
#   tags = {
#     Name = "Load generating environment"
#   }
# }
