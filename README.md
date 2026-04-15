# Gestion-De-Citas-Inteligente-db

Repositorio de base de datos del proyecto Gestión de Citas Inteligente usando Liquibase y PostgreSQL.

## Estructura

- `changelog-master.yaml`: orquesta todo el despliegue
- `01_ddl`: cambios estructurales
- `02_dml`: datos iniciales
- `03_dcl`: reservado para seguridad y permisos
- `04_tcl`: reservado para operaciones transaccionales especiales
- `05_rollbacks`: reservado para reversas

## Capas activas hoy

- `01_ddl/03_tables`
- `02_dml/00_inserts`

## Tablas definidas

- `users`
- `turnos`

## Uso básico

1. Configurar `liquibase.properties`
2. Crear la base de datos
3. Ejecutar:

```bash
liquibase validate
liquibase update