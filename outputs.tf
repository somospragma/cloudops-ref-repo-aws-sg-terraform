output "sg_info" {
 value = [for sg in aws_security_group.sg : {"sg_id" : sg.id, "sg_name" : sg.name}]
}