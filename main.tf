terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
}

# resource "aws_iam_user" "user1" {
#   name = "shubham"
# }

# resource "aws_iam_user" "user2" {
#   name = "renuka"
# }
# data "aws_availability_zones" "available" {}

# resource "aws_ebs_volume" "additional_volume" {
#   availability_zone = module.ec2_instance["instance1"].availability_zone   # Use the first availability zone
#   size              = 15   # Size in GB
#   tags = {
#     Name = "Jenkins_Volume"
#   }
# }

# resource "aws_volume_attachment" "attach_additional_volume" {
#   device_name = "/dev/sdf"  # Specify the device name (e.g., /dev/sdf)
#   volume_id   = aws_ebs_volume.additional_volume.id
#   instance_id = module.ec2_instance["instance1"].instance_id
# }

module "ec2_instance" {
  source             = "./modules/ec2"
  for_each           = var.instance_configs
  my_environment     = each.value.my_environment
  key_name           = each.value.key_name
  instance_type      = each.value.instance_type
  ami_id             = each.value.ami_id
  user_data          = each.value.user_data
  enable_root_volume = each.value.enable_root_volume
  subnet_id          = module.vpc.subnet_id
  vpc_security_group_ids = [module.sg.sg_id]
}

module "sg" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id
}

module "s3" {
  source = "./modules/s3"
  for_each      = var.bucket_configs
  bucket_name   = each.value.bucket_name
}

module "vpc" {
  source = "./modules/vpc"
  vpc_cidr   = var.vpc_cidr
  subnet_cidr = var.subnet_cidr
}