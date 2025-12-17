###########################################
######## Data Sources #####################
###########################################

# PC-IAC-011: Data Sources en el Root Module
# PC-IAC-026: Obtener IDs dinámicos para inyectar en locals.tf

# Obtener VPC por nomenclatura estándar
data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["${var.client}-${var.project}-${var.environment}-vpc"]
  }
}
