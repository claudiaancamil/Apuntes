/*Entrar a terminal*

Ingresar a simbolo del sistema

/*Ingresa al cliente de postgreSQL desde el terminal*/

psql -U postgres
Contraseña: <tu contraseña>

/*Crea una base de datos llamada desaﬁo-tuNombre-tuApellido-3digitos*/

CREATE DATABASE desafio_nombre_apellido_111;

/*Ingresa a la base de datos creada*/

/c desafio_nombre_apellido_111;

/*Crea una tabla llamada clientes, con una columna llamada email de tipo varchar(50), una columna llamada nombre de tipo varchar sin limitación, una columna llamada 
teléfono de tipo varchar(16), un campo llamado empresa de tipo varchar(50) y una columna de tipo smallint, para indicar la prioridad del cliente. Ahí se debe ingresar un valor entre 1 y 10, donde 10 es más prioritario. */

CREATE TABLE clientes (email varchar(50),nombres varchar,
telefono varchar (16), empresa varchar (50),
prioridad smallint);

/*Ingresa    5    clientes    distintos    con    distintas    prioridades,    el   resto   de   los   valores   los 
puedes inventar*/

INSERT INTO clientes (email, nombres, telefono, empresa, prioridad) VALUES ('empresa 1@gmail.com','nombre 1', '+56911111111', 'empresa 1', 10);
INSERT INTO clientes (email, nombres, telefono, empresa, prioridad) VALUES ('empresa 2@gmail.com','nombre 2', '+56922222222', 'empresa 2', 9);
INSERT INTO clientes (email, nombres, telefono, empresa, prioridad) VALUES ('empresa 3@gmail.com','nombre 3', '+56933333333', 'empresa 3', 8);
INSERT INTO clientes (email, nombres, telefono, empresa, prioridad) VALUES ('empresa 4@gmail.com','nombre 4', '+56944444444', 'empresa 4', 7);
INSERT INTO clientes (email, nombres, telefono, empresa, prioridad) VALUES ('empresa 5@gmail.com','nombre 5', '+56955555555', 'empresa 5', 6);
INSERT INTO clientes (email, nombres, telefono, empresa, prioridad) VALUES ('empresa 1@gmail.com','nombre 1', '+56911111111', 'empresa 1', 4;

/*Selecciona los tres clientes de mayor prioridad*/

SELECT* FROM clientes Order BY prioridad DESC LIMIT 3;

/*Selecciona,    de    la    tabla    clientes,    una    prioridad    o    una    empresa,    de    forma    que    el 
resultado devuelva 2 registros*/

SELECT* FROM clientes WHERE empresa= 'empresa 1';

/*Sal de postgreSQL*/

\q

--FIN--
