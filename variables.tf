variable "instance_configs" {
  description = "Map of configurations for each instance"
  type = map(object({
    ami_id         = string
    instance_type  = string
    key_name       = string
    user_data      = string
    my_environment = string
    enable_root_volume = string
    vpc_security_group_ids = list(string)
  }))
}

variable "bucket_configs" {
  description = "Map of configurations for each bucket"
  type = map(object({
    bucket_name = string
  }))
}

variable "vpc_cidr" {
  description = "Map of configurations for each bucket"
}

variable "subnet_cidr" {
  description = "Map of configurations for each bucket"
}

