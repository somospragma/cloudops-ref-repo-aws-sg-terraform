###########################################
######## Local Transformations ############
###########################################

# PC-IAC-026: Patrón de Transformación en Root
# Flujo: terraform.tfvars → variables.tf → locals.tf → main.tf → module

locals {
  # Prefijo de gobernanza
  governance_prefix = "${var.client}-${var.project}-${var.environment}"
  
  # Transformación de sg_config con inyección de VPC ID desde data source
  sg_config_transformed = {
    for key, config in var.sg_config :
    key => merge(config, {
      # Inyectar VPC ID desde data source si está vacío
      vpc_id = length(config.vpc_id) > 0 ? config.vpc_id : data.aws_vpc.selected.id
    })
  }
}
