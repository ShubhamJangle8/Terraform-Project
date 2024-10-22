variable "instance_configs" {
  description = "Map of configurations for each instance"
  type = map(object({
    ami_id         = string
    instance_type  = string
    key_name       = string
    user_data      = string
    my_environment = string
    enable_root_volume = string
  }))
}

variable "bucket_configs" {
  description = "Map of configurations for each bucket"
  type = map(object({
    bucket_name = string
  }))
}
