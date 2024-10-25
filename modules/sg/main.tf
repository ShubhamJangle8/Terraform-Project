locals {
  allowed_ports = [22, 8080, 9000, 9090, 8081]  # Define your allowed ports here
}

resource "aws_security_group" "allow_ssh" {
  vpc_id = var.vpc_id  # Replace with your VPC ID
  dynamic "ingress" {
    for_each = local.allowed_ports
    content {
        from_port   = ingress.value
        to_port     = ingress.value
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]  # Allow SSH access from everywhere
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-ssh"
  }
}
