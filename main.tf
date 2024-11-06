resource "aws_security_group" "sg" {
  count       = length(var.sg_config) > 0 ? length(var.sg_config) : 0
  name        = join("-", tolist([var.client, var.project, var.environment, "sg", var.sg_config[count.index].application_id, var.sg_config[count.index].service, count.index + 1]))
  description = var.sg_config[count.index].description
  vpc_id      = var.sg_config[count.index].vpc_id

  dynamic "ingress" {
    for_each = var.sg_config[count.index].ingress
    content {
      from_port       = ingress.value["from_port"]
      to_port         = ingress.value["to_port"]
      protocol        = ingress.value["protocol"]
      cidr_blocks     = ingress.value["cidr_blocks"]
      security_groups = ingress.value["security_groups"]
      prefix_list_ids = ingress.value["prefix_list_ids"]
      self            = ingress.value["self"]
      description     = ingress.value["description"]
    }
  }

  dynamic "egress" {
    for_each = var.sg_config[count.index].egress
    content {
      from_port       = egress.value["from_port"]
      to_port         = egress.value["to_port"]
      protocol        = egress.value["protocol"]
      cidr_blocks     = egress.value["cidr_blocks"]
      prefix_list_ids = egress.value["prefix_list_ids"]
      description     = egress.value["description"]
    }
  }

  tags = merge(
    { Name = "${join("-", tolist([var.client, var.project, var.environment, "sg", var.sg_config[count.index].application_id, var.sg_config[count.index].service, count.index + 1]))}" }
  )
}