# FastAPI, SQLAlchemy y SQLite: práctica de desarrollo

Repositorio de práctica creado para aprender a desarrollar una aplicación web y una API REST con Python. El proyecto incluye una interfaz HTML renderizada con Jinja2 y operaciones CRUD sobre usuarios, además de autenticación mediante JWT.

## Stack utilizado

| Área | Tecnología |
| --- | --- |
| Lenguaje | Python |
| Framework web/API | FastAPI |
| Servidor ASGI | Uvicorn |
| ORM y migraciones | SQLAlchemy y Alembic |
| Base de datos | SQLite (`db.sqlite3`) |
| Validación de datos | Pydantic |
| Plantillas HTML | Jinja2 |
| Cliente HTTP asincrónico | aiohttp |
| Autenticación | OAuth2, JWT y python-jose |
| Hash de contraseñas | Passlib con bcrypt |
| Pruebas | pytest, TestClient y Coverage |
| Variables de entorno | python-dotenv |
| Despliegue | Procfile para Uvicorn |

El archivo `requirements.txt` contiene las dependencias del proyecto. También incluye controladores de PostgreSQL y psycopg2 como opciones previstas de base de datos, aunque la configuración activa utiliza SQLite.

## Funcionalidades

- Gestión completa de usuarios: crear, consultar, actualizar y eliminar.
- Autenticación con usuario y contraseña.
- Contraseñas almacenadas mediante hash bcrypt.
- Generación de tokens JWT con una duración de 30 minutos.
- Protección del listado de usuarios mediante OAuth2/Bearer.
- Interfaz web con registro, inicio de sesión, listado y cierre de sesión.
- Persistencia de usuarios y ventas mediante SQLAlchemy.
- Migraciones de base de datos administradas con Alembic.
- Pruebas automatizadas de los endpoints principales.
- Documentación interactiva de la API generada automáticamente por FastAPI.

## Modelo de datos

El proyecto define dos entidades relacionadas:

- **Usuario**: identificador, usuario único, contraseña, nombre, apellido, dirección, teléfono, correo único, fecha de creación y estado.
- **Venta**: identificador, usuario asociado, venta y cantidad de ventas relacionadas con productos.

La relación elimina las ventas asociadas cuando se elimina el usuario.

## API REST

Las rutas principales se encuentran bajo `/user`:

| Método | Ruta | Descripción |
| --- | --- | --- |
| `GET` | `/user/` | Lista los usuarios; requiere un token Bearer. |
| `POST` | `/user/` | Crea un usuario. |
| `GET` | `/user/{user_id}` | Obtiene un usuario por identificador. |
| `PATCH` | `/user/{user_id}` | Actualiza los campos enviados de un usuario. |
| `DELETE` | `/user/{user_id}` | Elimina un usuario por identificador. |
| `POST` | `/login/` | Valida credenciales y devuelve un token JWT. |

FastAPI ofrece la documentación interactiva en:

- Swagger UI: `http://127.0.0.1:8000/docs`
- ReDoc: `http://127.0.0.1:8000/redoc`

## Interfaz web

Además de la API, el repositorio dispone de páginas Jinja2:

- `/`: página principal.
- `/register`: formulario de registro.
- `/login_web`: inicio de sesión web.
- `/mostrar_usuarios`: listado protegido por cookie de sesión.
- `/salir`: eliminación de la cookie de autenticación.

Las páginas se respaldan en los mismos endpoints REST de usuario y login. En el listado web, el token se obtiene de la cookie `access_token` y se valida antes de mostrar el contenido.

## Estructura del proyecto

```text
.
├── app/
│   ├── db/
│   │   ├── database.py       # Engine, sesión y dependencia de base de datos
│   │   └── models.py         # Modelos SQLAlchemy
│   ├── repository/
│   │   ├── auth.py           # Lógica de autenticación
│   │   └── user.py           # Operaciones CRUD
│   ├── routers/
│   │   ├── auth.py           # Endpoint de login
│   │   ├── user.py           # Endpoints REST de usuarios
│   │   └── web.py            # Rutas y vistas HTML
│   ├── templates/            # Plantillas Jinja2
│   ├── hashing.py            # Hash y verificación de contraseñas
│   ├── oauth.py              # Validación OAuth2
│   ├── schemas.py            # Esquemas Pydantic
│   └── token.py              # Creación y validación de JWT
├── core/
│   └── config.py             # Configuración y ruta SQLite
├── migrations/
│   └── versions/             # Migraciones de Alembic
├── test/
│   └── test_api.py           # Pruebas de API
├── main.py                   # Creación y arranque de la aplicación
├── alembic.ini               # Configuración de Alembic
├── requirements.txt          # Dependencias
└── Procfile                  # Comando de ejecución para despliegue
```

## Instalación y ejecución

Se recomienda utilizar un entorno virtual:

```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

Iniciar la aplicación:

```bash
python main.py
```

También puede iniciarse directamente con Uvicorn:

```bash
uvicorn main:app --reload --host 127.0.0.1 --port 8000
```

Al arrancar, FastAPI crea las tablas SQLite configuradas si todavía no existen.

## Migraciones

Para trabajar con Alembic desde la raíz del repositorio:

```bash
alembic upgrade head
alembic revision --autogenerate -m "descripción del cambio"
```

La migración inicial está disponible en `migrations/versions/`.

## Pruebas

Las pruebas crean una base SQLite separada en `test/test.db` y sobreescriben la dependencia de base de datos de la aplicación.

Ejecutar la suite:

```bash
pytest
```

La prueba elimina `test/test.db` al finalizar el último caso. Ejecutar pytest nuevamente recrea el archivo y los datos de prueba necesarios.
