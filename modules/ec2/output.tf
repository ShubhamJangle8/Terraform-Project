# output "ec2_public_ip_prom" {
#     value = aws_instance.ec2_instance.public_ip
#     description = "The private IP address of the EC2 instance"
# }

// In modules/ec2/outputs.tf

output "instance_id" {
  value = aws_instance.ec2_instance.id
}

output "availability_zone" {
  value = aws_instance.ec2_instance.availability_zone
}

output "instance_public_ip" {
  value = aws_instance.ec2_instance.public_ip
}