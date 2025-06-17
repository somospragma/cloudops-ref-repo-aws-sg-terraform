###########################################
######### Security Groups module ###########
###########################################

module "security_groups" {
  source = "../../"
  providers = {
    aws.project = aws.alias01              # Write manually alias (the same alias name configured in providers.tf)
  }

  # Common configuration
  client      = var.client
  project     = var.project
  environment = var.environment
  additional_tags = {
    cost-center = "cc-123"
    owner       = "team-infra"
  }

  # SG configuration
  sg_config = {
    # ALB Security Group - Permite tráfico HTTP y HTTPS desde cualquier lugar
    "alb" = {
      service     = "alb"
      application = "web"
      description = "Security group for Application Load Balancer"
      vpc_id      = var.vpc_id
      additional_tags = {
        application-tier = "web"
        component        = "alb"
      }

      ingress = [
        {
          from_port       = 80
          to_port         = 80
          protocol        = "tcp"
          cidr_blocks     = ["0.0.0.0/0"]
          security_groups = []
          prefix_list_ids = []
          self            = false
          description     = "Allow HTTP inbound from anywhere"
        },
        {
          from_port       = 443
          to_port         = 443
          protocol        = "tcp"
          cidr_blocks     = ["0.0.0.0/0"]
          security_groups = []
          prefix_list_ids = []
          self            = false
          description     = "Allow HTTPS inbound from anywhere"
        }
      ]

      egress = [
        {
          from_port       = 0
          to_port         = 0
          protocol        = "-1"
          cidr_blocks     = ["0.0.0.0/0"]
          prefix_list_ids = []
          security_groups = []
          self            = false
          description     = "Allow all outbound traffic"
        }
      ]
    },
    
    # ECS Security Group - Permite tráfico al puerto 7007 desde ALB y desde sí mismo
    "ecs" = {
      service     = "ecs"
      application = "api"
      description = "Security group for ECS services"
      vpc_id      = var.vpc_id
      additional_tags = {
        application-tier = "app"
        component        = "ecs-cluster"
      }

      ingress = [
        {
          from_port       = 7007
          to_port         = 7007
          protocol        = "tcp"
          cidr_blocks     = []
          security_groups = ["alb"]
          prefix_list_ids = []
          self            = false
          description     = "Allow traffic on port 7007 from ALB"
        },
        {
          from_port       = 7007
          to_port         = 7007
          protocol        = "tcp"
          cidr_blocks     = []
          security_groups = []
          prefix_list_ids = []
          self            = true
          description     = "Allow traffic on port 7007 from the same security group"
        }
      ]

      egress = [
        {
          from_port       = 0
          to_port         = 0
          protocol        = "-1"
          cidr_blocks     = ["0.0.0.0/0"]
          prefix_list_ids = []
          security_groups = []
          self            = false
          description     = "Allow all outbound traffic"
        }
      ]
    },
    
    # RDS Security Group - Permite tráfico al puerto PostgreSQL (5432) solo desde ECS
    "rds" = {
      service     = "rds"
      application = "postgres"
      description = "Security group for PostgreSQL database"
      vpc_id      = var.vpc_id
      additional_tags = {
        application-tier = "data"
        component        = "database"
      }

      ingress = [
        {
          from_port       = 5432
          to_port         = 5432
          protocol        = "tcp"
          cidr_blocks     = []
          security_groups = ["ecs"]
          prefix_list_ids = []
          self            = false
          description     = "Allow PostgreSQL traffic from ECS security group"
        }
      ]

      egress = [
        {
          from_port       = 0
          to_port         = 0
          protocol        = "-1"
          cidr_blocks     = ["0.0.0.0/0"]
          prefix_list_ids = []
          security_groups = []
          self            = false
          description     = "Allow all outbound traffic"
        }
      ]
    }
  }
}