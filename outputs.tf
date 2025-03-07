output "sg_info" {
  value = { for k, sg in aws_security_group.sg : k => { id = sg.id, name = sg.name } }
}
