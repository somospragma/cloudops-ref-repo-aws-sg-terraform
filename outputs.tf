# outputs.tf
output "sg_info" {
  value = {
    for k, sg in aws_security_group.sg : k => {
      "sg_id" : sg.id,
      "sg_name" : sg.name
    }
  }
}