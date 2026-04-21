# Gestion-De-Citas-Inteligente-db

Repositorio de base de datos del proyecto Gestión de Citas Inteligente usando Liquibase y PostgreSQL.

## Estructura

- `changelog-master.yaml`: orquestación principal
- `01_ddl`: cambios estructurales
- `02_dml`: datos iniciales y cargas
- `03_dcl`: reservado para permisos y seguridad
- `04_tcl`: reservado para operaciones transaccionales especiales
- `05_rollbacks`: reservado para reversas

## Capa activa hoy

Actualmente están activas:

- `01_ddl/03_tables`
- `02_dml/00_inserts`

## Tablas creadas

- `users`
- `turnos`

## Datos iniciales

- usuarios de prueba
- turnos de prueba

## Uso

1. Crear base de datos PostgreSQL
2. Configurar `liquibase.properties`
3. Ejecutar:

```bash
liquibase validate
liquibase update

---

# FASE 8 — Qué hacer con el repo principal

Tu repo principal sigue con:

- `users-service`
- `turnos-service`
- `api-gateway`
- frontend

y este nuevo repo `Gestion-De-Citas-Inteligente-db` queda solo para:

- estructura SQL
- migraciones Liquibase
- datos iniciales

Eso está bien y es coherente con el ejemplo que usaste como guía. 

---

# FASE 9 — Git

## Paso 15
En el repo DB:

```bash
git add .
git commit -m "feat: structure database repository with liquibase layers"
git push origin main
