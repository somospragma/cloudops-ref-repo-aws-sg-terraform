# Ejemplo de implementación del módulo cloudops-ref-repo-aws-sg-terraform

Este directorio contiene un ejemplo completo de implementación del módulo de Security Groups para AWS, que demuestra cómo configurar y utilizar el módulo en escenarios reales de aplicación.

## Estructura de archivos

- `main.tf` - Configuración principal que muestra cómo invocar el módulo
- `variables.tf` - Definición de variables utilizadas en el ejemplo
- `providers.tf` - Configuración del proveedor AWS
- `outputs.tf` - Definición de outputs para acceder a la información de los recursos creados
- `terraform.tfvars.sample` - Ejemplo de archivo de variables (renombrar a terraform.tfvars para usar)
- `data.tf` - Archivo para definiciones de data sources

## Requisitos previos

- Terraform v1.0 o superior
- AWS CLI configurado con credenciales válidas
- Permisos IAM para crear y gestionar grupos de seguridad en AWS
- Una VPC existente donde crear los grupos de seguridad
- Conocimiento básico de reglas de seguridad de red en AWS

## Cómo usar este ejemplo

1. **Preparación de variables**:
   - Copie `terraform.tfvars.sample` a `terraform.tfvars`
   - Edite `terraform.tfvars` con sus valores específicos, incluyendo:
     - Información del cliente, proyecto y entorno
     - ID de la VPC donde se crearán los grupos de seguridad
     - Configuración específica de los grupos de seguridad

2. **Inicialización de Terraform**:
   ```bash
   terraform init
   ```

3. **Verificación del plan**:
   ```bash
   terraform plan
   ```

4. **Aplicación de la configuración**:
   ```bash
   terraform apply
   ```

5. **Verificación de recursos creados**:
   - Compruebe la consola AWS o use AWS CLI para verificar los grupos de seguridad creados:
     ```bash
     aws ec2 describe-security-groups --filters "Name=tag:Name,Values=cliente01-proyecto01-dev-sg-*"
     ```
   - Revise los outputs de Terraform para obtener los IDs y nombres de los recursos:
     ```bash
     terraform output
     ```

## Escenarios incluidos

Este ejemplo demuestra varios escenarios comunes de implementación de grupos de seguridad:

### 1. Grupo de seguridad para balanceador de carga (ALB)

Configuración de un grupo de seguridad para un balanceador de carga que permite tráfico HTTP y HTTPS entrante desde cualquier lugar, y todo el tráfico saliente.

```hcl
"web" = {
  service     = "alb"
  application = "web"
  description = "Security group for web servers"
  vpc_id      = var.vpc_id
  additional_tags = {
    application-tier = "web"
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
      description     = "Allow HTTP inbound"
    },
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
      security_groups = []
      self            = false
      description     = "Allow all outbound traffic"
    }
  ]
}
```

### 2. Grupo de seguridad para aplicación con referencia a otro grupo

Configuración de un grupo de seguridad para una aplicación que permite tráfico entrante solo desde el grupo de seguridad del balanceador de carga.

```hcl
"app" = {
  service     = "ecs"
  application = "api"
  description = "Security group for application servers"
  vpc_id      = var.vpc_id
  additional_tags = {
    application-tier = "app"
  }

  ingress = [
    {
      from_port       = 8080
      to_port         = 8080
      protocol        = "tcp"
      cidr_blocks     = []
      security_groups = ["web"]
      prefix_list_ids = []
      self            = false
      description     = "Allow traffic from web security group"
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
```

## Flujos de trabajo recomendados

### Añadir un nuevo grupo de seguridad

1. Edite el archivo `terraform.tfvars` y añada una nueva entrada en el mapa `sg_config`:
   ```hcl
   sg_config = {
     # Grupos existentes...
     
     "nuevo-grupo" = {
       service     = "servicio"
       application = "aplicacion"
       description = "Descripción del nuevo grupo"
       vpc_id      = var.vpc_id
       
       ingress = [
         # Reglas de ingress...
       ]
       
       egress = [
         # Reglas de egress...
       ]
     }
   }
   ```

2. Ejecute `terraform plan` para verificar los cambios
3. Ejecute `terraform apply` para aplicar los cambios

### Modificar reglas de un grupo existente

1. Edite el archivo `terraform.tfvars` y modifique las reglas del grupo de seguridad deseado
2. Ejecute `terraform plan` para verificar los cambios
3. Ejecute `terraform apply` para aplicar los cambios

## Integración con otros servicios AWS

Los grupos de seguridad creados pueden referenciarse en otros recursos AWS:

```hcl
resource "aws_instance" "web_server" {
  ami           = "ami-12345678"
  instance_type = "t3.micro"
  
  # Referencia al grupo de seguridad creado por el módulo
  vpc_security_group_ids = [module.security_groups.sg_ids["web"]]
  
  # Otras configuraciones...
}
```

## Solución de problemas comunes

- **Error al eliminar un grupo de seguridad**: Asegúrese de que no hay recursos que dependan del grupo de seguridad antes de eliminarlo.
- **Error al crear reglas circulares**: Evite crear referencias circulares entre grupos de seguridad.
- **Límite de reglas excedido**: AWS tiene un límite de reglas por grupo de seguridad. Considere agrupar reglas similares o solicitar un aumento de límite.

## Limpieza

Para eliminar todos los recursos creados por este ejemplo:

```bash
terraform destroy
```

> Nota: Asegúrese de que no hay recursos dependientes antes de eliminar los grupos de seguridad. Los recursos que utilizan estos grupos de seguridad deben ser eliminados primero.
