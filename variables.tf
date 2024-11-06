variable "client" {
  type = string
}

variable "environment" {
  type = string
}


variable "sg_config" {
  type = list(object({
    description = string
    vpc_id      = string
    application_id = string
    service = string
    ingress = list(object({
      from_port   = string
      to_port     = string
      protocol    = string
      cidr_blocks = list(string)
      prefix_list_ids = list(string)
      security_groups = list(string)
      description = string
      
    }))

    egress = list(object({
      from_port   = string
      to_port     = string
      protocol    = string
      prefix_list_ids = list(string)
      cidr_blocks = list(string)
      description = string
    }))
  }))
}