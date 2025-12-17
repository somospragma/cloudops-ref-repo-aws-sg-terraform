# Changelog

Todos los cambios notables en este proyecto serán documentados en este archivo.

El formato está basado en [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
y este proyecto adhiere a [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2024-12-17

### 🎯 PC-IAC Compliance Release

Este release implementa cumplimiento completo con las 26 Reglas de Gobernanza PC-IAC.

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

### ⚠️ BREAKING CHANGES
None - This release maintains full backward compatibility with v1.1.0

### 🔒 Security
- Enhanced validation rules
- Improved data source handling
- Better separation of concerns

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

### 🎓 Key Features Preserved
- ✅ **Security Group Mapping Logic**: Preserved ability to reference SGs by key
- ✅ **Backward Compatibility**: No breaking changes to existing implementations
- ✅ **All existing functionality**: Maintained 100%

## [1.1.0] - 2025-06-16

### Añadido
- Soporte para etiquetas adicionales a nivel de módulo y recurso
- Validaciones adicionales para variables
- Nuevos outputs para facilitar referencias a los recursos
- Archivo locals.tf para centralizar transformaciones de datos

### Cambiado
- Refactorización del código para usar locals en un archivo separado
- Mejora en la documentación de variables y outputs
- Actualización de la estructura del módulo según estándares

### Corregido
- Manejo mejorado de etiquetas en recursos
- Validación de protocolos permitidos

## [1.0.0] - 2023-03-07

### Añadido
- Implementación inicial del módulo de Security Groups
- Soporte para múltiples grupos de seguridad usando mapas
- Reglas de ingress y egress configurables
- Validaciones básicas para evitar conflictos con IDs de AWS

