--Creo la base de datos
CREATE DATABASE desafio_cesar_londono_001;

--Creo la tabla clientes
CREATE TABLE clientes(email varchar(50), nombre varchar, telefono varchar(16), empresa varchar(50), prioridad smallint);

--insertar clientes
INSERT INTO clientes(email, nombre, telefono, empresa, prioridad) VALUES('correo@correo.com', 'catalina', '273', 'la preferida', '4');
INSERT INTO clientes(email, nombre, telefono, empresa, prioridad) VALUES('correo1@correo.com', 'adriana', '274', 'despertar', '4');
INSERT INTO clientes(email, nombre, telefono, empresa, prioridad) VALUES('correo1@correo.com', 'adriana', '274', 'despertar', '4');
INSERT INTO clientes(email, nombre, telefono, empresa, prioridad) VALUES('correo3@correo.com', 'felisa', '276', 'nubes', '9');
INSERT INTO clientes(email, nombre, telefono, empresa, prioridad) VALUES('correo4@correo.com', 'gaby', '277', 'latidos', '7');

--consultas
SELECT nombre, telefono as telefono_cliente FROM clientes;

--traer nombre y email cuando la prioridad es mayor a 5
SELECT nombre, correo FROM clientes where prioridad > 5;

--traer todos los codigos en orden descendente deacuerdo a prioridad
SELECT * from clientes order by prioridad desc;
--pregunta prueba
--traemos los clientes de mayor prioridad,  ordenamos prioridad en descendente, limitamos los datos a los 3 mprimeros
SELECT * from clientes ORDER BY prioridad DESC LIMIT 3;

--PREGUNTA DE PRUEBA 2
SELECT * from clientes LIMIT 2;
--BUSCAMOS DATOS QUE SE REPITEN
SELECT prioridad, COUNT(*) AS filas from clientes GROUP BY prioridad HAVING COUNT(*) > 1;
--anexamos el detalle de los datos
SELECT nombre, prioridad FROM clientes WHERE prioridad IN( SELECT prioridad FROM clientes GROUP BY prioridad HAVING COUNT(*) > 1 );

GROUP BY Utilizada para clasificar los registros seleccionados en grupos específicos
HAVING Utilizada para expresar la condición que debe satisfacer cada grupo
COUNT Utilizada para devolver el número de registros de la selección

