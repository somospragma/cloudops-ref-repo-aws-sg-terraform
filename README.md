# **Módulo Terraform: cloudops-ref-repo-aws-sg-terraform**

## Descripción:

Este módulo facilita la creación de un Security Group en AWS, el cual requiere de los siguientes recursos, los cuales debieron ser previamente creados:

- vpc_id: ID de la vpc.

Consulta CHANGELOG.md para la lista de cambios de cada versión. *Recomendamos encarecidamente que en tu código fijes la versión exacta que estás utilizando para que tu infraestructura permanezca estable y actualices las versiones de manera sistemática para evitar sorpresas.*

## Estructura del Módulo

El módulo cuenta con la siguiente estructura:

```bash
cloudops-ref-repo-aws-sg-terraform/
└── sample/sg
    ├── data.tf
    ├── main.tf
    ├── outputs.tf
    ├── providers.tf
    ├── terraform.tfvars.sample
    └── variables.tf
├── .gitignore
├── CHANGELOG.md
├── data.tf
├── main.tf
├── outputs.tf
├── providers.tf
├── README.md
├── variables.tf
```

- Los archivos principales del módulo (`data.tf`, `main.tf`, `outputs.tf`, `variables.tf`, `providers.tf`) se encuentran en el directorio raíz.
- `CHANGELOG.md` y `README.md` también están en el directorio raíz para fácil acceso.
- La carpeta `sample/` contiene un ejemplo de implementación del módulo.

## Seguridad & Cumplimiento
 
Consulta a continuación la fecha y los resultados de nuestro escaneo de seguridad y cumplimiento.

<!-- BEGIN_BENCHMARK_TABLE -->
| Benchmark | Date | Version | Description | 
| --------- | ---- | ------- | ----------- | 
| ![checkov](https://img.shields.io/badge/checkov-passed-green) | 2023-09-20 | 3.2.232 | Escaneo profundo del plan de Terraform en busca de problemas de seguridad y cumplimiento |
<!-- END_BENCHMARK_TABLE -->
 
## Provider Configuration

Este módulo requiere la configuración de un provider específico para el proyecto. Debe configurarse de la siguiente manera:

```hcl
sample/sg/providers.tf
provider "aws" {
  alias = "alias01"
  # ... otras configuraciones del provider
}

sample/sg/main.tf
module "security_groups" {
  source = ""
  providers = {
    aws.project = aws.alias01
  }
  # ... resto de la configuración
}
```

## Uso del Módulo:

```hcl
module "security_groups" {
  source = ""
  
  providers = {
    aws.project = aws.project
  }

  # Common configuration 
  profile     = "profile01"
  aws_region  = "us-east-1"
  environment = "dev"
  client      = "cliente01"
  project     = "proyecto01"
  common_tags = {
    environment   = "dev"
    project-name  = "proyecto01"
    cost-center   = "xxx"
    owner         = "xxx"
    area          = "xxx"
    provisioned   = "xxx"
    datatype      = "xxx"
  }

  # Security Group configuration
  sg_config = [
    {
        application = "sm"
        description = "Security group description"
        vpc_id      = module.vpc.vpc_id
        ingress = [
            {
                from_port       = 443
                to_port         = 443
                protocol        = "tcp"
                cidr_blocks     = [
                    "0.0.0.0/0"
                ]
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
            cidr_blocks     = [
                "0.0.0.0/0"
            ]
            prefix_list_ids = []
            description     = "Allow all outbound traffic"
        }
      ]
    }
  ]
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.31.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws.project"></a> [aws.project](#provider\_aws) | >= 4.31.0 |

## Resources

| Name | Type |
|------|------|
| [aws_vpc_endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |

## Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="application"></a> [application](#input\_application_) | Nombre de la aplicación | `string` | n/a | yes |
| <a name="vpc_id"></a> [vpc_id](#input\_vpc_id) | Id de la VPC | `string` | n/a | yes |
| <a name="description"></a> [description](#input\_description) | Descripción del ecurity group | `string` | n/a | yes |
| <a name="ingress.description"></a> [ingress.description](#input\_ingress.description) | Descripción de la regla de ingreso | `string` | n/a | yes |
| <a name="ingress.from_port"></a> [ingress.from_port](#input\_ingress.from_port) | Puerto de inicio | `string` | n/a | yes |
| <a name="ingress.to_port"></a> [ingress.to_port](#input\_ingress.to_port) | Puerto final | `string` | n/a | yes |
| <a name="ingress.protocol"></a> [ingress.protocol](#input\_ingress.protocol) | Protocolo | `string` | n/a | yes |
| <a name="ingress.prefix_list_ids"></a> [ingress.prefix_list_ids](#input\_ingress.prefix_list_ids) | Lista de prefijos de la lista de IDs | `string` | n/a | yes |
| <a name="ingress.cidr_blocks"></a> [ingress.cidr_blocks](#input\_ingress.cidr_blocks) | Lista de los bloques CIDR | `string` | n/a | yes |
| <a name="ingress.security_groups"></a> [ingress.security_groups](#input\_ingress.security_groups) | Lista de los grupos de seguridad | `string` | n/a | yes |
| <a name="ingress.self"></a> [ingress.self](#input\_ingress.self) | Si el grupo de seguridad en sí se agregará | `string` | n/a | yes |
| <a name="egress.description"></a> [egress.description](#input\_egress.description) | Descripción de la regla de egreso | `string` | n/a | yes |
| <a name="egress.from_port"></a> [egress.from_port](#input\_egress.from_port) | Puerto de inicio | `string` | n/a | yes |
| <a name="egress.to_port"></a> [egress.to_port](#input\_egress.to_port) | Puerto final | `string` | n/a | yes |
| <a name="egress.protocol"></a> [egress.protocol](#input\_egress.protocol) | Protocolo | `string` | n/a | yes |
| <a name="egress.prefix_list_ids"></a> [egress.prefix_list_ids](#input\_egress.prefix_list_ids) | Lista de prefijos de la lista de IDs | `string` | n/a | yes |
| <a name="egress.cidr_blocks"></a> [egress.cidr_blocks](#input\_egress.cidr_blocks) | Lista de los bloques CIDR | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="sg_info.id"></a> [sg_info.id](#output\sg_info.id) | ID del grupo de seguridad creado |
| <a name="sg_info.name"></a> [sg_info.name](#output\sg_info.name) | Nombre del grupo de seguridad creado |