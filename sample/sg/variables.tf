###########################################
########## Common variables ###############
###########################################

variable "profile" {
  type = string
  description = "Profile name containing the access credentials to deploy the infrastructure on AWS"
}

variable "common_tags" {
  type = map(string)
  description = "Common tags to be applied to the resources"
}

variable "aws_region" {
  type = string
  description = "AWS region where resources will be deployed"
}

variable "environment" {
  type = string
  description = "Environment where resources will be deployed"
  validation {
    condition     = contains(["dev", "qa", "pdn"], var.environment)
    error_message = "El entorno debe ser uno de: dev, qa, pdn."
  }
}

variable "client" {
  type = string
  description = "Client name"
}

variable "project" {
  type = string  
  description = "Project name"
}

variable "vpc_id" {
  type = string
  description = "ID of the VPC where security groups will be created"
}

###########################################
####### Security Group variables ##########
###########################################

variable "sg_config" {
  description = "Configuración de Security Groups"
  type = map(object({
    description     = string
    vpc_id          = string
    service         = string
    application     = string
    additional_tags = optional(map(string), {})
    
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
      cidr_blocks     = list(string)
      security_groups = list(string)
      prefix_list_ids = list(string)
      self            = bool
      description     = string
    }))
  }))
  
  default = {}
}
