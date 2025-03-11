###########################################
####### Security Group Resources ##########
###########################################
resource "aws_security_group" "sg" {
  provider    = aws.project
  for_each    = var.sg_config

  name        = join("-", [var.client, var.project, var.environment, "sg", each.value.service, each.value.application])
  description = each.value.description
  vpc_id      = each.value.vpc_id
   tags = {
    Name = join("-", [var.client, var.project, var.environment, "sg", each.value.service, each.value.application])
  }
}

# Create Rule Ingress
resource "aws_security_group_rule" "ingress_rules" {
  provider    = aws.project
  for_each = {
    for idx, rule in flatten([
      for sg_key, sg in var.sg_config : [
        for i, ingress in sg.ingress : {
          sg_key     = sg_key
          rule       = ingress
          idx        = "${sg_key}_ingress_${i}"
        }
      ]
    ]) : rule.idx => rule
  }

  type              = "ingress"
  from_port         = each.value.rule.from_port
  to_port           = each.value.rule.to_port
  protocol          = each.value.rule.protocol
  security_group_id = aws_security_group.sg[each.value.sg_key].id
  cidr_blocks       = each.value.rule.self == false && length(each.value.rule.cidr_blocks) > 0 ? each.value.rule.cidr_blocks : null
  source_security_group_id = (contains(keys(each.value.rule), "security_groups") && each.value.rule.self == false && length(each.value.rule.security_groups) > 0) ? (startswith(each.value.rule.security_groups[0], "sg-") ? each.value.rule.security_groups[0] : aws_security_group.sg[each.value.rule.security_groups[0]].id) : null
  self              = each.value.rule.self == true ? true : null
  prefix_list_ids   = each.value.rule.self == false && length(each.value.rule.prefix_list_ids) > 0 ? each.value.rule.prefix_list_ids : null
  description       = each.value.rule.description
}

# Create Rule Egress
resource "aws_security_group_rule" "egress_rules" {
  provider    = aws.project
  for_each = {
    for idx, rule in flatten([
      for sg_key, sg in var.sg_config : [
        for i, egress in sg.egress : {
          sg_key     = sg_key
          rule       = egress
          idx        = "${sg_key}_egress_${i}"
        }
      ]
    ]) : rule.idx => rule
  }

  type              = "egress"
  from_port         = each.value.rule.from_port
  to_port           = each.value.rule.to_port
  protocol          = each.value.rule.protocol
  security_group_id = aws_security_group.sg[each.value.sg_key].id
  cidr_blocks       = each.value.rule.cidr_blocks
  source_security_group_id = (contains(keys(each.value.rule), "security_groups") && length(each.value.rule.security_groups) > 0) ? (startswith(each.value.rule.security_groups[0], "sg-") ? each.value.rule.security_groups[0] : aws_security_group.sg[each.value.rule.security_groups[0]].id) : null
  prefix_list_ids   = contains(keys(each.value.rule), "prefix_list_ids") ? each.value.rule.prefix_list_ids : null
  description       = each.value.rule.description
}