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
}

variable "client" {
  type = string
  description = "Client name"
}

variable "project" {
  type = string  
    description = "Project name"
}


###########################################
####### Security Group variables ##########
###########################################

variable "sg_config" {
  type = list(object({
    description = string
    vpc_id      = string
    service     = string
    application = string
    ingress = list(object({
      from_port   = string
      to_port     = string
      protocol    = string
      cidr_blocks = list(string)
      prefix_list_ids = list(string)
      security_groups = list(string)
      self = bool
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
  description = <<EOF
    - description: (optional, string) Security group description. Defaults to Managed by Terraform. Cannot be "". NOTE: This field maps to the AWS GroupDescription attribute, for which there is no Update API. If you'd like to classify your security groups in a way that can be updated, use tags.
    - vpc_id: (optional, string) VPC ID. Defaults to the region's default VPC.
    - service: (string) Service AWS (ecs - alb - rds)
    - application: (string) Application name in order to name security group.
    - ingres:
      - from_port: (string) Start port (or ICMP type number if protocol is icmp or icmpv6).
      - to_port: (string) End range port (or ICMP code if protocol is icmp).
      - protocol: (string) Protocol. If you select a protocol of -1 (semantically equivalent to all, which is not a valid value here), you must specify a from_port and to_port equal to 0. The supported values are defined in the IpProtocol argument on the IpPermission API reference. This argument is normalized to a lowercase value to match the AWS API requirement when using with Terraform 0.12.x and above, please make sure that the value of the protocol is specified as lowercase when using with older version of Terraform to avoid an issue during upgrade.
      - cidr_blocks: (optional, list(string)) List of CIDR blocks.
      - prefix_list_ids: (optional, list(string)) List of Prefix List IDs.
      - security_groups: (optional, list(string)) List of security groups. A group name can be used relative to the default VPC. Otherwise, group ID.
      - self: (optional, bool) Whether the security group itself will be added as a source to this ingress rule.
      - description: (optional, string) Description of this ingress rule.
    - egress:
      from_port: (string) Start port (or ICMP type number if protocol is icmp)
      to_port: (string) End range port (or ICMP code if protocol is icmp).
      protocol: (string) Protocol. If you select a protocol of -1 (semantically equivalent to all, which is not a valid value here), you must specify a from_port and to_port equal to 0. The supported values are defined in the IpProtocol argument in the IpPermission API reference. This argument is normalized to a lowercase value to match the AWS API requirement when using Terraform 0.12.x and above. Please make sure that the value of the protocol is specified as lowercase when used with older version of Terraform to avoid issues during upgrade.
      prefix_list_ids: (optional, list(string)) List of Prefix List IDs.
      cidr_blocks: (optional, list(string)) List of CIDR blocks.
      description: (optional, string) Description of this egress rule.
  EOF
}
