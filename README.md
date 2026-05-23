# Gestión de Citas Inteligente - Base de Datos

Repositorio de base de datos del proyecto **Gestión de Citas Inteligente**, orientado a la organización de scripts, migraciones y documentación técnica de persistencia.

Este repositorio evidencia el uso de **Liquibase** para el control de cambios de base de datos en PostgreSQL y documenta la estructura de datos utilizada por los microservicios del sistema.

---

## Objetivo del repositorio

Este repositorio tiene como propósito centralizar la estructura de base de datos del proyecto, permitiendo mantener trazabilidad sobre:

- Cambios estructurales de las tablas.
- Datos iniciales de prueba.
- Migraciones controladas con Liquibase.
- Organización por capas SQL.
- Evidencia técnica del componente de base de datos.

---

## Tecnologías utilizadas

- PostgreSQL
- Liquibase
- YAML
- SQL
- Git / GitHub

---

## Arquitectura de base de datos del proyecto

El proyecto **Gestión de Citas Inteligente** utiliza persistencia distribuida por microservicio.

### Bases de datos relacionales con PostgreSQL

Los siguientes microservicios utilizan PostgreSQL:

- `users-service`
- `turnos-service`
- `notifications-service`

### Base de datos NoSQL con MongoDB

El microservicio de auditoría utiliza MongoDB:

- `audit-service`

La auditoría se almacena en una colección llamada:

- `audit_logs`

---

## Estructura del repositorio

```txt
Gestion-De-Citas-Inteligente-db/
│
├── changelog-master.yaml
├── liquibase.properties.example
│
├── 01_ddl/
│   └── 03_tables/
│
├── 02_dml/
│   └── 00_inserts/
│
├── 03_dcl/
│
├── 04_tcl/
│
└── README.md
```

---

## Descripción de carpetas

| Carpeta / archivo | Descripción |
|---|---|
| `changelog-master.yaml` | Archivo principal de orquestación de Liquibase. |
| `liquibase.properties.example` | Archivo de ejemplo para configurar la conexión a la base de datos. |
| `01_ddl` | Contiene cambios estructurales de la base de datos, como creación de tablas. |
| `02_dml/00_inserts` | Contiene datos iniciales o registros de prueba. |
| `03_dcl` | Reservado para permisos y seguridad. |
| `04_tcl` | Reservado para operaciones transaccionales especiales. |
| `README.md` | Documentación técnica del repositorio. |

---

## Capas activas

Actualmente las capas principales utilizadas son:

- `01_ddl/03_tables`
- `02_dml/00_inserts`

Estas carpetas contienen la estructura y datos iniciales necesarios para evidenciar la gestión de base de datos con Liquibase.

---

## Tablas principales del proyecto

### PostgreSQL

Las tablas principales manejadas por los microservicios son:

- `users`
- `turnos`
- `notifications`

### MongoDB

La colección principal del servicio de auditoría es:

- `audit_logs`

---

## Datos iniciales

El repositorio contempla datos iniciales de prueba para apoyar la validación del sistema, tales como:

- Usuarios de prueba.
- Turnos de prueba.
- Registros base para pruebas de funcionamiento.

---

## Uso básico de Liquibase

### 1. Crear la base de datos PostgreSQL

Primero se debe contar con una base de datos PostgreSQL creada.

Ejemplo:

```sql
CREATE DATABASE gestion_citas_db;
```

---

### 2. Configurar el archivo de propiedades

Tomar como base el archivo:

```txt
liquibase.properties.example
```

y configurar los datos de conexión correspondientes:

```properties
url=jdbc:postgresql://localhost:5432/gestion_citas_db
username=postgres
password=yeison
changeLogFile=changelog-master.yaml
```

---

### 3. Validar los cambios

```bash
liquibase validate
```

Este comando permite verificar que los archivos de migración estén correctamente definidos.

---

### 4. Ejecutar las migraciones

```bash
liquibase update
```

Este comando aplica los cambios definidos en los changelogs sobre la base de datos.

---

## Validación de Liquibase desde Docker

En el proyecto integrado, Liquibase se valida consultando la tabla `databasechangelog` dentro de cada base de datos PostgreSQL.

### Users

```powershell
docker exec -it users-db-main psql -U postgres -d usersdb_main -c "SELECT id, author, filename, dateexecuted, exectype FROM databasechangelog;"
```

### Turnos

```powershell
docker exec -it turnos-db-main psql -U postgres -d turnosdb_main -c "SELECT id, author, filename, dateexecuted, exectype FROM databasechangelog;"
```

### Notifications

```powershell
docker exec -it notifications-db-main psql -U postgres -d notificationsdb_main -c "SELECT id, author, filename, dateexecuted, exectype FROM databasechangelog;"
```

El resultado esperado es que los cambios aparezcan con estado:

```txt
EXECUTED
```

---

## Validación de bloqueo de Liquibase

También se puede verificar que Liquibase no haya quedado bloqueado:

```powershell
docker exec -it users-db-main psql -U postgres -d usersdb_main -c "SELECT * FROM databasechangeloglock;"
docker exec -it turnos-db-main psql -U postgres -d turnosdb_main -c "SELECT * FROM databasechangeloglock;"
docker exec -it notifications-db-main psql -U postgres -d notificationsdb_main -c "SELECT * FROM databasechangeloglock;"
```

El resultado esperado es:

```txt
locked = f
```

Esto indica que Liquibase terminó correctamente y no dejó procesos bloqueados.

---

## Relación con los microservicios

Este repositorio está relacionado con los siguientes componentes del sistema:

| Microservicio | Base de datos | Tecnología |
|---|---|---|
| `users-service` | `usersdb` | PostgreSQL + Liquibase |
| `turnos-service` | `turnosdb` | PostgreSQL + Liquibase |
| `notifications-service` | `notificationsdb` | PostgreSQL + Liquibase |
| `audit-service` | `auditdb` | MongoDB |

---

## Ambientes del proyecto

El proyecto maneja tres ambientes principales:

```txt
develop -> qa -> main
```

Cada ambiente cuenta con bases de datos separadas para evitar cruces de información entre desarrollo, pruebas y versión final.

### Develop

- `usersdb_develop`
- `turnosdb_develop`
- `notificationsdb_develop`
- `auditdb_develop`

### QA

- `usersdb_qa`
- `turnosdb_qa`
- `notificationsdb_qa`
- `auditdb_qa`

### Main

- `usersdb_main`
- `turnosdb_main`
- `notificationsdb_main`
- `auditdb_main`

---

## Importancia de Liquibase en el proyecto

Liquibase es importante porque permite controlar los cambios de base de datos de forma ordenada y trazable.

Con Liquibase se evita crear tablas manualmente en cada ambiente. En su lugar, los cambios quedan registrados en archivos versionados y se ejecutan automáticamente al iniciar los servicios.

Esto permite demostrar:

- Control de versiones en base de datos.
- Reproducibilidad de la estructura.
- Evidencia de cambios aplicados.
- Separación entre código y persistencia.
- Validación técnica en ambientes `develop`, `qa` y `main`.

---

## Estado del repositorio

El repositorio contiene la estructura necesaria para evidenciar el componente de base de datos del proyecto, incluyendo:

- Organización por capas SQL.
- Archivo maestro de Liquibase.
- Configuración de ejemplo.
- Documentación técnica.
- Relación con PostgreSQL y MongoDB.
- Soporte para el flujo de ramas `develop`, `qa` y `main`.

---

## Flujo Git utilizado

El repositorio sigue el flujo:

```txt
develop -> qa -> main
```

Este flujo permite desarrollar cambios, validarlos y posteriormente promoverlos a la rama principal.

---

## Comandos básicos de Git

```bash
git add .
git commit -m "Actualizar documentacion del repositorio de base de datos"
git push origin main
```

Para propagar cambios a las demás ramas:

```bash
git checkout develop
git merge main
git push origin develop

git checkout qa
git merge main
git push origin qa

git checkout main
```

---

## Conclusión

El repositorio **Gestion-De-Citas-Inteligente-db** permite evidenciar la gestión de base de datos del proyecto mediante Liquibase y PostgreSQL, complementando la arquitectura distribuida del sistema.

Además, documenta la relación con MongoDB para el servicio de auditoría, mostrando una solución con persistencia relacional y no relacional dentro del proyecto **Gestión de Citas Inteligente**.
