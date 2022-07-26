# provisioner to execute ansible playbook

resource "null_resource" "configure_server"{
#ecution in terraform their no sequence of exection so if resource 3 is depandent on  resource 1 & 2 ,
# then we can use depends on and pass the list of resource on which resource 1 is dependent
depends_on = [aws_instance.ec2_instance,aws_ebs_volume.ebs_volume,aws_volume_attachment.attach_volume]
  
# provisioner are use to execute command on local or remote machine,here we are using local-exec
provisioner "local-exec"{
# this command will be executed on local machine and will change the permission of key file which we saved previously
  command = "chmod 400 ${var.base_path}${var.key_name}.pem"
  }
provisioner "local-exec"{
# this command will connect to ec2 instance and run the play on instance
# ANSIBLE_HOST_KEY_CHECKING=False means it will not give warning for host authenticity,
# else we have to manually pass yeson terminal 
  command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ec2-user --private-key ${var.base_path}${var.key_name}.pem -i '${aws_instance.ec2_instance.public_ip},' playbook.yml"
  }
}