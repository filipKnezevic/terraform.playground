provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "web" {
  ami           = "ami-0747bdcabd34c712a"
  instance_type = "t3.micro"
  vpc_security_group_ids = ["${aws_security_group.instance.id}"]

  user_data = <<-EOF
              #!/bin/bash
              echo "Pusi kurac papku" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

 tags = {
    Name = "terraform_example"
  }
}

resource "aws_security_group" "instance" {
  name        = "allow_8080"
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

