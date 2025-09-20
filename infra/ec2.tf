# Get Default VPC
data "aws_vpc" "default" {
  default = true
}

# Get Subnets in Default VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# SSH Key Pair
resource "aws_key_pair" "devops_key" {
  key_name   = "devops-key"
  public_key = file("${path.module}/id_rsa.pub")
}

# Security Group
resource "aws_security_group" "devops_sg" {
  name        = "devops-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance (Ubuntu with Docker + GHCR login + Container Run)
resource "aws_instance" "devops_ec2" {
  ami                    = "ami-04a81a99f5ec58529" # Ubuntu 20.04 LTS (us-east-1)
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.devops_key.key_name
  subnet_id              = tolist(data.aws_subnets.default.ids)[0]
  vpc_security_group_ids = [aws_security_group.devops_sg.id]

provisioner "remote-exec" {
  inline = [
    "sudo apt-get update -y",
    "sudo apt-get install -y docker.io",
    "sudo usermod -aG docker ubuntu",
    "newgrp docker <<EOF",
    "docker login ghcr.io -u USERNAME -p ${var.ghcr_pat}",
    "docker pull ghcr.io/USERNAME/your-image:latest",
    "docker run -d -p 80:80 ghcr.io/USERNAME/your-image:latest",
    "EOF"
  ]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = var.ec2_ssh_key
    host        = self.public_ip
  }
}



  tags = {
    Name = "DevOps-Kickstart-EC2"
  }
}
