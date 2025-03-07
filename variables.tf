###########################################
########## Common variables ###############
###########################################

variable "environment" {
  type        = string
  description = "Environment where resources will be deployed"
}

variable "client" {
  type        = string
  description = "Client name"
}

variable "project" {
  type        = string
  description = "Project name"
}

###########################################
####### Security Group variables ##########
###########################################

variable "sg_config" {
  type = map(object({
    description   = string
    vpc_id        = string
    service       = string
    application   = string
    functionality = optional(string)

    ingress = list(object({
      from_port       = number
      to_port         = number
      protocol        = string
      cidr_blocks     = list(string)
      security_groups = list(string)
      prefix_list_ids = list(string)
      self            = bool
      description     = string
    }))

    egress = list(object({
      from_port       = number
      to_port         = number
      protocol        = string
      prefix_list_ids = list(string)
      cidr_blocks     = list(string)
      description     = string
    }))
  }))
  description = "Mapa de configuración de Security Groups"
}
