--crear base de datos
create database mawashi_phone;

--crear tabla
create table phone(id int primary key, modelo varchar(50), mac_address int unique, fecha_fabricaion varchar(50));


--modificando nombre de columna mas escrita
ALTER TABLE phone RENAME COLUMN fecha_fabracacion TO fecha_fabricacion;

--cambiando restriccion de not null
ALTER TABLE phone ALTER COLUMN mac_address set not null;

--Cambiando tipo de dato no sirve
ALTER TABLE phone ALTER COLUMN fecha_fabricacion TYPE date;

--cambiado type si sirve utilizan USING
ALTER TABLE phone ALTER COLUMN fecha_fabricaion TYPE date USING fecha_fabricaion::date;

--insertando datos en la table
INSERT INTO phone(id, modelo, mac_address, fecha_fabricacion)VALUES(1,'iphone 14','1B:2A:3C:4D:5F:6G','2023-09-09');
insert into phone(id,modelo, mac_address, fecha_fabricacion)VALUES(2,'android 12','6B:2A:3C:4D:5F:19G','2022-09-14');
insert into phone(id,modelo, fecha_fabricacion)VALUES(3,'android 13','2022-09-14');

--cambiamos la restriccion null columna mac_address
ALTER TABLE phone ALTER COLUMN mac_address set not null;-- no se elimina por ya tener datos que no cumplen

--actualizando para poder cambiar la restriccion
UPDATE phone set mac_address = '3A:6B:2C:8D:1F:9G' where id = 3;


--hacer respaldo definiendo ruta de guardado
pg_dump -U postgres -fc mawashi_phone /Volumes/DD/INFORCAP/2023/0050/dump_mawashi.sq

--importando desde postgres
copy peliculas
from '/Volumes/DD/INFORCAP/2023/0050/Guiados/peliculas.csv'
DELIMITER ','
CSV Header;
copy peliculas
from '../../../bootcamp.inforcap/DB/definicion_tablas/second-day/challenge/Apoyo Desafío evaluado - Definición de tablas/Apoyo Desafío - Top 100/peliculas.csv'
DELIMITER ','
CSV Header;

CREATE TABLE public.peliculas (
 id int4 NULL,
 pelicula varchar(64) NULL,
 "Año estreno" int4 NULL,
 director varchar(50) NULL
);

CREATE TABLE actores(
    id serial primary key
    nombre varchar(50) not null unique
);

--restriccion FK ALTER
ALTER table actores_peliculas
ADD CONSTRAINT fk_actores_peliculas
foreign key (actor_id)
REFERENCES actores(id);

-- tabla actores
CREATE TABLE actores(
    id serial primary key,
    nombre varchar(50) not null unique
);
-- tabla peliculas
CREATE TABLE peliculas(
    id serial primary key,
    pelicula varchar(50) not null,
    genero varchar(50) not null
);

-- tabla relacional actores_peliculas
CREATE TABLE actores_peliculas(
    id serial primary key,
    actor_id int not null,
    pelicula_id int not null
    foreign key(pelicula_id) REFERENCES peliculas(id)
    
);

-- restriccion FK ALTER
ALTER table actores_peliculas
add constraint fk_actores_peliculas
foreign key (actor_id) 
REFERENCES actores(id);

--join obtener todo lo que este relacionado

SELECT * from actores_peliculas ap
INNER JOIN actores ac 
ON ap.actor_id  = ac.id 
INNER JOIN peliculas pe ON ap.pelicula_id = pe.id

SELECT ac.*, pe.* 
FROM actores_peliculas ap
INNER JOIN actores ac ON ap.actor_id = ac.id
INNER JOIN peliculas pe ON ap.pelicula_id = pe.id