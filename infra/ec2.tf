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

# SSH Key Pair (public key only)
resource "aws_key_pair" "devops_key" {
  key_name   = "devops-key"
  public_key = file("${path.module}/id_rsa.pub") # safe to keep in repo
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

resource "aws_instance" "devops_ec2" {
  ami                    = "ami-04a81a99f5ec58529"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.devops_key.key_name
  subnet_id              = tolist(data.aws_subnets.default.ids)[0]
  vpc_security_group_ids = [aws_security_group.devops_sg.id]

  provisioner "remote-exec" {
    inline = [
      # Update & install required packages
      "sudo apt-get update -y",
      "sudo apt-get install -y software-properties-common",
      "sudo apt-add-repository --yes --update ppa:ansible/ansible",
      "sudo apt-get install -y ansible",
      
      # Add ubuntu to docker group for later playbook use
      #"sudo usermod -aG docker ubuntu"
    ]

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = var.ec2_ssh_key
    }
  }

  tags = {
    Name = "DevOps-Kickstart-EC2"
  }
}

