###########################################
######### VPC Endpoint module #############
###########################################

module "security_groups" {
  source = "../../"
  providers = {
    aws.project = aws.alias01              #Write manually alias (the same alias name configured in providers.tf)
  }

  # Common configuration
  client      = var.client
  project     = var.project
  environment = var.environment

  # SG configuration
  sg_config = [
    {
      application = "sm"
      description = "Security group for VPC Endpoint"
      vpc_id      = module.vpc.vpc_id

      ingress = [
        {
          from_port       = 443
          to_port         = 443
          protocol        = "tcp"
          cidr_blocks     = ["0.0.0.0/0"]
          security_groups = []
          prefix_list_ids = []
          self            = false
          description     = "Allow HTTPS inbound"
        }
      ]

      egress = [
        {
          from_port       = 0
          to_port         = 0
          protocol        = "-1"
          cidr_blocks     = ["0.0.0.0/0"]
          prefix_list_ids = []
          description     = "Allow all outbound traffic"
        }
      ]
    }
  ]
  depends_on = [module.vpc]
}