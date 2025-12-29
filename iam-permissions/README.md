# Permisos IAM Requeridos - Módulo Security Groups

Este documento detalla los permisos IAM necesarios para desplegar y gestionar el módulo Security Groups.

## 📋 Resumen de Permisos

Para desplegar este módulo, el usuario/rol de IAM necesita permisos para:

1. **Security Groups** - Crear y gestionar security groups
2. **Security Group Rules** - Gestionar reglas de ingress y egress
3. **VPC** - Describir VPCs
4. **Tags** - Gestionar etiquetas en recursos

## 🔐 Política IAM Mínima

Usa la política personalizada en: [`sg-deployment-policy.json`](./sg-deployment-policy.json)

**Aplicar la política:**
```bash
# Crear la política
aws iam create-policy \
  --policy-name SGModuleDeploymentPolicy \
  --policy-document file://iam-permissions/sg-deployment-policy.json

# Adjuntar a un usuario
aws iam attach-user-policy \
  --user-name tu-usuario \
  --policy-arn arn:aws:iam::ACCOUNT-ID:policy/SGModuleDeploymentPolicy
```

## 📝 Permisos Detallados

### Security Group Management
```json
{
  "Effect": "Allow",
  "Action": [
    "ec2:CreateSecurityGroup",
    "ec2:DeleteSecurityGroup",
    "ec2:DescribeSecurityGroups",
    "ec2:DescribeSecurityGroupRules",
    "ec2:AuthorizeSecurityGroupIngress",
    "ec2:AuthorizeSecurityGroupEgress",
    "ec2:RevokeSecurityGroupIngress",
    "ec2:RevokeSecurityGroupEgress",
    "ec2:ModifySecurityGroupRules"
  ],
  "Resource": "*"
}
```

## 🎯 Recursos Creados por el Módulo

Este módulo crea los siguientes recursos:

- ✅ N Security Groups (según configuración)
- ✅ N Ingress Rules
- ✅ N Egress Rules
- ✅ Tags en todos los recursos

## 💰 Costos Asociados

- **Security Groups**: Sin costo
- **Security Group Rules**: Sin costo

## 🔒 Mejores Prácticas

### 1. Limitar por VPC
```json
{
  "Condition": {
    "StringEquals": {
      "ec2:Vpc": "arn:aws:ec2:us-east-1:123456789012:vpc/vpc-xxxxx"
    }
  }
}
```

### 2. Limitar por Tags
```json
{
  "Condition": {
    "StringEquals": {
      "ec2:ResourceTag/ManagedBy": "Terraform"
    }
  }
}
```

## 🆘 Troubleshooting

### Error: "User is not authorized to perform: ec2:CreateSecurityGroup"
**Solución**: Adjuntar la política SGModuleDeploymentPolicy

### Error: "VPC not found"
**Solución**: Verificar que el VPC ID sea correcto y exista

### Error: "Access Denied" al modificar reglas
**Solución**: Verificar permisos `ec2:AuthorizeSecurityGroupIngress` y `ec2:AuthorizeSecurityGroupEgress`

## 📚 Referencias

- [AWS Security Groups Documentation](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html)
- [Security Groups IAM](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/security-iam.html)
