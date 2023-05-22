
resource "aws_instance" "pub-servers" {
  count = 2
  ami = var.image
  key_name = "test"
  instance_type = var.type
  vpc_security_group_ids = var.sg
  subnet_id = var.sub-id[count.index]

  provisioner "local-exec" {
    command = "echo ${self.public_ip} >> ./public_ip.txt"
  }


 connection {
         type     = "ssh"
         private_key = file("../test.pem")
         user     = "ubuntu"
         host     = self.public_ip
     }

  provisioner "remote-exec" {
#     connection {
#         type     = "ssh"
#   	 private_key = file("../test.pem")
#	 user     = "ubuntu"
#    	 host     = self.public_ip
#     }
#     script = "./provisioner-script.sh"
#	
	 inline = [
    	  "sudo apt update -y",
	  "sudo apt install nginx -y",
     	  "sudo unlink /etc/nginx/sites-enabled/default",
      	  "sudo sh -c 'echo \"server { \n listen 80; \n location / { \n   proxy_pass http://${var.lb-dns}; \n }  \n  }\" > /etc/nginx/sites-available/reverse-proxy.conf'",
     	  "sudo ln -s /etc/nginx/sites-available/reverse-proxy.conf /etc/nginx/sites-enabled/reverse-proxy.conf",
          "sudo systemctl restart nginx",
    ]
}
}
