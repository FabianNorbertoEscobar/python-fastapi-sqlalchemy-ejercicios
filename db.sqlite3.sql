BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "usuario" (
	"id"	INTEGER NOT NULL,
	"username"	VARCHAR,
	"password"	VARCHAR,
	"nombre"	VARCHAR,
	"apellido"	VARCHAR,
	"direccion"	VARCHAR,
	"telefono"	VARCHAR,
	"correo"	VARCHAR,
	"creacion"	DATETIME,
	"estado"	BOOLEAN,
	UNIQUE("username"),
	UNIQUE("correo"),
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "venta" (
	"id"	INTEGER NOT NULL,
	"usuario_id"	INTEGER,
	"venta"	INTEGER,
	"ventas_productos"	INTEGER,
	FOREIGN KEY("usuario_id") REFERENCES "usuario"("id") ON DELETE CASCADE,
	PRIMARY KEY("id")
);
INSERT INTO "usuario" ("id","username","password","nombre","apellido","direccion","telefono","correo","creacion","estado") VALUES (1,'fescobar','$2b$12$mQaW5/YuKCADGNsaCV8bKOqJnZMYSKVaBjqU8eui9IPBmBQQNtTWi','Fabián Norberto','Escobar','Rivadavia 12345','1122334455','fescobar@testtest.com.ar','2025-04-23 13:55:30.358569',0);
COMMIT;
