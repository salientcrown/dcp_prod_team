resource "aws_instance" "docker_instance" {
  count = 1


  ami                    = "ami-08c40ec9ead489470"
  instance_type          = var.instance_type
  key_name               = var.key_pair
  vpc_security_group_ids = [aws_security_group.sg.id]
  subnet_id              = element(aws_subnet.public.*.id, count.index)
    user_data              = file("docker_build_image.sh")
  tags = {
    Name = "${var.env}_docker_instance_demo"
  }
}
#  provisioner "file" {
#     source      = "/Users/chinazamdennar/Downloads/test/passwd.txt"
#     destination = "/home/ubuntu/passwd.txt"
    
#     connection {
#       type        = "ssh"
#       user        = "ubuntu"
#       private_key = file("JenkinsKP.ppk")
#       host        = aws_instance.docker_instance[0].public_ip
#       timeout     = "3m"
#       agent       = false
#   }
#   }
#   provisioner "file" {
#     source      = "Dockerfile"
#     destination = "/home/ubuntu/Dockerfile"
#     connection {
#       type        = "ssh"
#       user        = "ubuntu"
#       private_key = file("JenkinsKP.ppk")
#       host        = aws_instance.docker_instance[0].public_ip
#       timeout     = "3m"
#       agent       = false
#   }

#   }
#   # build_docker_image.sh from my computer
#   provisioner "file" {
#     source      = "docker_build_image.sh"
#     destination = "/home/ubuntu/docker_build_image.sh"
#     connection {
#       type        = "ssh"
#       user        = "ubuntu"
#       private_key = file("JenkinsKP.ppk")
#       host        = aws_instance.docker_instance[0].public_ip
#       timeout     = "3m"
#       agent       = false
#   }


#   }
#   #  set permissions and run the build_docker_image.sh
#   provisioner "remote-exec" {
#     inline = [
#       "sudo chmod +x /home/ubuntu/docker_build_image.sh",
#       "sh /home/ubuntu/docker_build_image.sh"
#     ]
#     connection {
#       type        = "ssh"
#       user        = "ubuntu"
#       private_key = file("JenkinsKP.ppk")
#       host        = aws_instance.docker_instance[0].public_ip
#       timeout     = "3m"
#       agent       = false
#   }
#   }

#   depends_on = [aws_instance.docker_instance]
# }

# resource "null_resource" "noname" {
#   connection {
#     type        = "ssh"
#     user        = "ec2_user"
#     private_key = file("/Users/chinazamdennar/Downloads/congo.pem")
#     host        = aws_instance.docker_instance[0].public_ip
#     timeout     = "3m"
#     agent       = false
#   }

#   provisioner "file" {
#     source      = "/Users/chinazamdennar/Downloads/test/passwd.txt"
#     destination = "passwd.txt"
#   }

  # provisioner "file" {
  #   source      = "Dockerfile"
  #   destination = "/home/ec2-user/Dockerfile"
  # }
  # build_docker_image.sh from my computer
#   provisioner "file" {
#     source      = "docker_build_image"ß
#     destination = "/home/ec2-user/docker_build_image.sh"
#   }
#    ser permissions and run the build_docker_image.sh
#   provisioner "remote-exec" {
#     inline = [
#       "sudo chmod +x /home/ec2-user/docker_build_image.sh",
#       "sh /home/ec2-user/docker_build_image.sh",
#     ]
#   }

#   depends_on = [aws_instance.docker_instance]
# }

# print the url of the container server

output "container_url" {
  value = join("", ["http://", aws_instance.docker_instance[0].public_dns])
}
