resource "aws_instance" "my-test-instance" {
  ami             = "${data.aws_ami.ubuntu.id}"
  instance_type   = "t2.micro"
  key_name        = "${aws_key_pair.my-test-key.key_name}"

  security_groups = [
    "${aws_security_group.allow_ssh.name}",
    "${aws_security_group.allow_rails.name}",
    "${aws_security_group.allow_outbound.name}"
  ]
  
      
  provisioner "remote-exec" {
    inline = [
      "curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -",
      "sudo apt-get install -y nodejs",
      "sudo mkdir /data && sudo chown -R ubuntu /data"
    ]

    connection {
      type          = "ssh"
      user          = "ubuntu"
      private_key   = "${file("./id_rsa")}"
    }
  }

  provisioner "file" {
    source      = "src"
    destination = "/data/"
    connection {
      type          = "ssh"
      user          = "ubuntu"
      private_key   = "${file("./id_rsa")}"
    }
  }
  

  tags {
    Name = "test-instance"
  }
}
