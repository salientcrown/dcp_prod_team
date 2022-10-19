
resource "aws_instance" "docker_instance" {
  count = var.az_count


  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  key_name               = var.key_pair
  vpc_security_group_ids = [aws_security_group.sg.id]
  subnet_id              = element(aws_subnet.public.*.id, count.index)
  #   user_data              = file("docker_build_image.sh")
  tags = {
    Name = "${var.env}_docker_instance"
  }
}

# resource "null_resource" "noname" {
#   connection {
#     type        = "ssh"
#     user        = "ec2_user"
#     private_key = file("~/Downloads/congo.pem")
#     host        = aws_instance.docker_instance[0].public_ip
#   }

#   provisioner "file" {
#     source      = "~/Downloads/mypasswd.txt"
#     destination = "/home/ec2-user/mypasswd.txt"
#   }

#   provisioner "file" {
#     source      = "Dockerfile"
#     destination = "/home/ec2-user/Dockerfile"
#   }
#   # build_docker_image.sh from my computer
#   provisioner "file" {
#     source      = "docker_build_image"
#     destination = "/home/ec2-user/docker_build_image.sh"
#   }
#   #  ser permissions and run the build_docker_image.sh
#   provisioner "remote-exec" {
#     inline = [
#       "sudo chmod +x /home/ec2-user/docker_build_image.sh",
#       "sh /home/ec2-user/docker_build_image.sh",
#     ]
#   }

#   depends_on = [aws_instance.docker_instance]
# }

# # print the url of the container server

# output "container_url" {
#   value = join("", ["http://", aws_instance.docker_instance[0].public_dns])
# }
