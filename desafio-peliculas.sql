--1. Crear una base de datos llamada películas
--se crea la base de datos peliculas
CREATE DATABASE peliculas;

--2. Cargar ambos archivos a su tabla correspondiente y aplicar el truncado de estas.
--creando tablas
--PELICULAS
CREATE TABLE peliculas(id int NULL, pelicula varchar(64) NULL, "año de estreno" int NULL, director varchar(50) NULL, PRIMARY KEY (id));
--ACTORES
CREATE TABLE actores( id serial primary key, nombre VARCHAR(50) NOT NULL );
--acctores pelicula
CREATE TABLE actores_peliculas(id serial, actor_id int not null, pelicula_id int not null REFERENCES peliculas(id), PRIMARY KEY (id));

--aGREGANDO RESTRICCION A LA TABLA ACTORES PELICULAS
ALTER TABLE actores_peliculas ADD CONSTRAINT fk_actores_peliculas FOREIGN KEY (actor_id) REFERENCES actores(id);

--agregando restriccion a la tabla actores unique
AlTER TABLE actores ADD constraint UQ_actores_nombre unique (nombre);

--insertando datos table peliculas IMPORTAR
\COPY peliculas from 'c:\Users\slac_\OneDrive\Escritorio\peliculas.csv' WITH DELIMITER ',' CSV HEADER;

--insertando datos despues de etl tabla actores IMPORTAR
\COPY actores (  nombre)from 'c:\Users\slac_\OneDrive\Escritorio\reparto.csv' WITH DELIMITER ',' CSV HEADER;
--insertando datos manual a tabla actores pelicula
INSERT INTO actores_peliculas (actor_id, pelicula_id) VALUES (32, 3),(33, 3),(34, 3),(35, 3),(36, 3),(37, 3),(38, 3),(39, 3),(40, 3),(41, 3),(42, 3),(44, 3),(45, 3),(46, 3),(47, 3);

--insertando datos automatio a la tabla actores pelicula
INSERT INTO actores_peliculas (actor_id, pelicula_id) 
SELECT actores.id, reparto.id_pelicula 
FROM actores, peliculas, reparto 
WHERE peliculas.id = reparto.id_pelicula 
AND actores.nombre = reparto.nombre_actor;

--3. Obtener el ID de la película “Titanic”.
SELECT id FROM peliculas WHERE pelicula = 'Titanic';
 id
----
  2
(1 row)

4. Listar a todos los actores que aparecen en la película "Titanic"
SELECT actores.nombre FROM actores_peliculas JOIN actores ON actores.id = actores_peliculas.actor_id JOIN peliculas ON peliculas.id = actores_peliculas.pelicula_id WHERE peliculas.pelicula = 'Titanic';
      nombre
-------------------
 Leonardo DiCaprio
 Kate Winslet
 Billy Zane
 Kathy Bates
 Frances Fisher
 Bernard Hill
 Jonathan Hyde
 Danny Nucci
 David Warner
 Bill Paxton
 Gloria Stuart
 Victor Garber
 Suzy Amis

--5. Consultar en cuántas películas del top 100 participa Harrison Ford.
SELECT COUNT(*) AS total_peliculas_hf FROM actores_peliculas JOIN peliculas ON peliculas.id = actores_peliculas.pelicula_id JOIN actores ON actores.id = actores_peliculas.actor_id WHERE actores.nombre = 'Harrison Ford';
 total_peliculas_hf
--------------------
                  8

--6. Indicar las películas estrenadas entre los años 1990 y 1999 ordenadas por título de manera ascendente. 
--esta consulta se hizo desde pgAdmin por el tema de la Ñ
SELECT pelicula
FROM peliculas
WHERE "a¤o de estreno" BETWEEN 1990 AND 1999
ORDER BY pelicula ASC;


--7. Hacer una consulta SQL que muestre los títulos con su longitud, la longitud debe ser nombrado para la consulta como “longitud_titulo”.
SELECT pelicula, LENGTH(pelicula) AS longitud_titulo FROM peliculas;
                       pelicula                        | longitud_titulo
-------------------------------------------------------+-----------------
 Forest Gump                                           |              11
 Titanic                                               |               7
 El Padrino                                            |              10
 Gladiator                                             |               9
 El Se├▒or de los anillos: El retorno del rey          |              44
 El caballero oscuro                                   |              19
 Cadena perpetua                                       |              15
 Piratas del Caribe: La maldici├│n de la Perla Negra   |              51
 Braveheart                                            |              10
 La lista de Schindler                                 |              21
 Toy Story                                             |               9
 Eduardo Manostijeras                                  |              20
 El Se├▒or de los anillos: La comunidad del anillo     |              49


--8. Consultar cual es la longitud más grande entre todos los títulos de las películas.
SELECT  MAX(LENGTH(pelicula)) AS longitud_mas_grande FROM peliculas;
 longitud_mas_grande
---------------------
                  53





