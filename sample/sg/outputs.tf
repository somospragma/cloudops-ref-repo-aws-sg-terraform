###########################################
######### Security Groups outputs #########
###########################################

output "sg_ids" {
  description = "IDs de los grupos de seguridad creados"
  value       = module.security_groups.sg_ids
}

output "sg_names" {
  description = "Nombres de los grupos de seguridad creados"
  value       = module.security_groups.sg_names
}

output "sg_arns" {
  description = "ARNs de los grupos de seguridad creados"
  value       = module.security_groups.sg_arns
}

output "alb_sg_id" {
  description = "ID del grupo de seguridad para el ALB"
  value       = module.security_groups.sg_ids["alb"]
}

output "ecs_sg_id" {
  description = "ID del grupo de seguridad para ECS"
  value       = module.security_groups.sg_ids["ecs"]
}

output "rds_sg_id" {
  description = "ID del grupo de seguridad para RDS"
  value       = module.security_groups.sg_ids["rds"]
}

output "sg_info" {
  description = "Información completa de los grupos de seguridad"
  value       = module.security_groups.sg_info
}
