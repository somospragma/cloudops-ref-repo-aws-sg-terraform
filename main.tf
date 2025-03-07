###########################################
####### Security Group Resources ##########
###########################################

resource "aws_security_group" "sg" {
  provider    = aws.project
  for_each    = var.sg_config

  name        = join("-", [var.client, var.project, var.environment, "sg", each.value.service, each.value.application, each.value.functionality])
  description = each.value.description
  vpc_id      = each.value.vpc_id

  dynamic "ingress" {
    for_each = each.value.ingress
    content {
      from_port       = ingress.value.from_port
      to_port         = ingress.value.to_port
      protocol        = ingress.value.protocol
      cidr_blocks     = ingress.value.cidr_blocks
      security_groups = [
        for sg in ingress.value.security_groups : aws_security_group.sg[sg].id
        if contains(keys(aws_security_group.sg), sg) # Solo incluir SGs creados en este módulo
      ]
      prefix_list_ids = ingress.value.prefix_list_ids
      self            = ingress.value.self
      description     = ingress.value.description
    }
  }

  dynamic "egress" {
    for_each = each.value.egress
    content {
      from_port       = egress.value.from_port
      to_port         = egress.value.to_port
      protocol        = egress.value.protocol
      cidr_blocks     = egress.value.cidr_blocks
      prefix_list_ids = egress.value.prefix_list_ids
      description     = egress.value.description
    }
  }

  tags = {
    Name = join("-", [var.client, var.project, var.environment, "sg", each.value.service, each.value.application])
  }
}
