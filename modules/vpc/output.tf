output "vpc_cidr" {
  value = aws_vpc.myvpc.cidr_block
}

output "vpc_id" {
  value = aws_vpc.myvpc.id
}

output "subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "subnet_cidr" {
  value = aws_subnet.public_subnet.cidr_block
}