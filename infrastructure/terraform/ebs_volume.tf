# this resource will create a ebs volume with 1 gb in size, we are creating this volume for persistant storage of critical data
resource "aws_ebs_volume" "ebs_volume" {
  availability_zone = aws_instance.ec2_instance.availability_zone
  size              = 1
  tags = {
    Name = "ebsVolume"
  }
}

# this will attach above created volume to ec2 instance at /dev/sdf
resource "aws_volume_attachment" "attach_volume" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.ebs_volume.id
  instance_id = aws_instance.ec2_instance.id
  # !! warning
  # dont use force detach and preserve this volume from destroying if using in production or, if it contain important data
  # else you will loose your data
  force_detach = true                           
}