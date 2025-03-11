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
  description = "Configuración de Security Groups"
  type = map(object({
    description   = string
    vpc_id        = string
    service       = string
    application   = string
    ingress       = list(object({
      from_port       = number
      to_port         = number
      protocol        = string
      cidr_blocks     = list(string)
      security_groups = list(string)
      prefix_list_ids = list(string)
      self            = bool
      description     = string
    }))
    egress        = list(object({
      from_port       = number
      to_port         = number
      protocol        = string
      cidr_blocks     = list(string)
      prefix_list_ids = list(string)
      security_groups = list(string)
      self            = bool
      description     = string
    }))
  }))
  
  validation {
    condition = alltrue([
      for sg_key in keys(var.sg_config) : !startswith(sg_key, "sg-")
    ])
    error_message = "Las claves en sg_config no deben comenzar con 'sg-' para evitar confusiones con los IDs de security groups de AWS."
  }
}