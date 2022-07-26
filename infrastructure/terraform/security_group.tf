# this resource will create new security with specified inbound and outbound rules
resource "aws_security_group" "security_group" {
  name        = "allow_tcp"
  description = "Allow tcp inbound traffic"
  vpc_id      = aws_default_vpc.default_vpc.id            # here we are using default vpc attribute id,
                                                          # which we created before for attribute referancing 
  
# creating inbound rule for tcp port 8080 to use jenkins
  ingress {
    description = "Allow Jenkins"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
# creating inbound rule for tcp port 443 to allow https traffic
  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
# creating inbound rule for tcp port 80 to allow http traffic
  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
# creating inbound rule for tcp port 22 to ssh into instance
  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
# outbound rule protocal -1 means all and port 0 means all
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tcp"
  }
}