resource "aws_instance" "ec2_instance" {
    ami           = var.ami_id
    instance_type = var.instance_type
    key_name      = var.key_name  # Add this line to attach the key pair
    user_data = var.user_data
    tags = {
        Name = "${var.my_environment}_Instance"
    } 
    iam_instance_profile = "jenkins-s3"
    dynamic "root_block_device" {
    for_each = var.enable_root_volume ? [1] : []  # Apply root_block_device only if enabled
    content {
      volume_size           = 15
      volume_type           = "gp3"
      delete_on_termination = true
    }
  }
}

