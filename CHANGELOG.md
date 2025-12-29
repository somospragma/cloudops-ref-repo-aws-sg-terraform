# Changelog

Todos los cambios notables en este proyecto serán documentados en este archivo.

El formato está basado en [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
y este proyecto adhiere a [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.1] - 2024-12-29

### 📚 Documentación
- **IAM Permissions**: Agregada documentación completa de permisos IAM requeridos
  - Nuevo directorio `iam-permissions/` con README detallado
  - Política IAM mínima en formato JSON (`sg-deployment-policy.json`)
  - Guía de troubleshooting y mejores prácticas
- **README**: Actualizado con sección de permisos IAM

### 🔧 Mejoras
- Sin cambios en funcionalidad del módulo
- Mejora en documentación para facilitar adopción

## [1.0.0] - 2024-12-29

### 🎉 First Official Release

Este es el primer release oficial del módulo Security Groups con cumplimiento completo de las 26 Reglas de Gobernanza PC-IAC.

### ✨ Added
- **PC-IAC Compliance**: Full compliance with 26 PC-IAC governance rules
- **New Files**:
  - `versions.tf`: Terraform and provider version requirements (PC-IAC-006)
  - `sample/sg/locals.tf`: Transformation pattern implementation (PC-IAC-026)
  - `sample/sg/data.tf`: Data sources for dynamic ID injection
- **Validations**: Added input validations for `client` and `project` variables
- **Documentation**: Complete PC-IAC compliance section in README

### 🔧 Changed
- **providers.tf**: Now contains only provider injection comment (PC-IAC-005)
- **data.tf**: Updated with PC-IAC-011 guidance
- **sample/**: Follows PC-IAC-026 transformation pattern (tfvars → data → locals → main)
- **Provider alias**: Changed from `alias01` to `principal` in sample

### 📝 Documentation
- Added PC-IAC compliance section to README
- Updated examples to follow new patterns
- Enhanced security and best practices documentation

### 🔒 Security
- Enhanced validation rules
- Improved data source handling
- Better separation of concerns
- Security reports included (Checkov analysis)

### 📊 PC-IAC Compliance Summary
- ✅ PC-IAC-001: Complete structure (10 root + 8 sample files)
- ✅ PC-IAC-002: Variables with validations
- ✅ PC-IAC-003: Centralized nomenclature in locals.tf
- ✅ PC-IAC-005: Provider injection pattern
- ✅ PC-IAC-006: Version pinning in versions.tf
- ✅ PC-IAC-007: Granular outputs (4 outputs)
- ✅ PC-IAC-009: map(object) implementation
- ✅ PC-IAC-010: for_each in resources
- ✅ PC-IAC-011: Data sources in Root (sample/)
- ✅ PC-IAC-012: Locals for transformations
- ✅ PC-IAC-026: Transformation pattern in sample/

### 🎓 Key Features
- ✅ **Security Group Mapping Logic**: Ability to reference SGs by key
- ✅ **Multiple Security Groups**: Support for multiple SGs using map(object())
- ✅ **Dynamic Rules**: Configurable ingress and egress rules
- ✅ **Self-Referencing**: Support for SG self-referencing
- ✅ **Flexible Tagging**: Additional tags support at module and resource level
- ✅ **Complete Sample**: Functional example following PC-IAC transformation pattern

### 🏗️ Module Structure
```
.
├── CHANGELOG.md
├── CHECKLIST.md
├── README.md
├── data.tf
├── locals.tf
├── main.tf
├── outputs.tf
├── providers.tf
├── sample/
│   └── sg/
│       ├── README.md
│       ├── data.tf
│       ├── locals.tf
│       ├── main.tf
│       ├── outputs.tf
│       ├── providers.tf
│       ├── terraform.tfvars.sample
│       └── variables.tf
├── security-reports/
│   ├── SECURITY-REPORT.md
│   └── checkov/
│       ├── results.json
│       └── results.txt
├── variables.tf
└── versions.tf
```

