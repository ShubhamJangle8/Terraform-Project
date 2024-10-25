variable "ami_id" {

}

variable "my_environment" {

}

variable "instance_type" {

}

variable "key_name" {
  
}

variable "user_data" {
  
}

variable "enable_root_volume" {
  
}

variable "subnet_id" {
  
}

variable "vpc_security_group_ids" {
  description = "List of VPC security group IDs to associate with the EC2 instance"
  type        = list(string)
}

