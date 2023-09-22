postgres=# CREATE DATABASE producciones;
CREATE DATABASE
postgres=# \c producciones
You are now connected to database "producciones" as user "postgres".

CREATE TABLE peliculas(id int, nombre varchar(25), anho int, PRIMARY KEY (id));

CREATE TABLE tags(id int, nombre varchar(32), PRIMARY KEY (id));

CREATE TABLE tags_peliculas(id int , id_pelicula int REFERENCES peliculas(id), id_tag int REFERENCES tags(id), primary key (id));

INSERT INTO peliculas(id, nombre, anho) VALUES (1, "Pride ande prejudice", 2005), (2, "V for vendetta", 2005), (3, "The rock", 1996), (4 , "Notting hill", 1999), (5 , "Pretty woman", 1990 ));

INSERT INTO peliculas(id, nombre, anho) VALUES (1, 'Pride ande prejudice', 2005), (2, 'V for vendetta', 2005), (3, 'The rock', 1996), (4 , 'Notting hill', 1999), (5 , 'Pretty woman', 1990 );
INSERT 0 5
SELECT * FROM peliculas;
 id |        nombre        | anho
----+----------------------+------
  1 | Pride ande prejudice | 2005
  2 | V for vendetta       | 2005
  3 | The rock             | 1996
  4 | Notting hill         | 1999
  5 | Pretty woman         | 1990

INSERT INTO tags(id, nombre) VALUES (1, 'accion'), (2, 'romance'), (3, 'terror'), (4 , 'drama'), (5 , 'comedia' );
INSERT 0 5
SELECT * FROM tags;
 id | nombre
----+---------
  1 | accion
  2 | romance
  3 | terror
  4 | drama
  5 | comedia

INSERT INTO tags_peliculas(id, id_pelicula, id_tag) VALUES (1, 1, 2),(2, 1, 4), (3, 1, 5), (4 , 2, 1), (5, 2 ,4);
INSERT 0 5
SELECT * FROM tags_peliculas;
 id | id_pelicula | id_tag
----+-------------+--------
  1 |           1 |      2
  2 |           1 |      4
  3 |           1 |      5
  4 |           2 |      1
  5 |           2 |      4

SELECT peliculas.nombre, COALESCE(COUNT(tags_peliculas.id_tag), 0) AS total_tags FROM peliculas LEFT JOIN tags_peliculas ON peliculas.id = tags_peliculas.id_pelicula GROUP BY peliculas.nombre;
        nombre        | total_tags
----------------------+------------
 V for vendetta       |          2
 Pride ande prejudice |          3
 Pretty woman         |          0
 The rock             |          0
 Notting hill         |          0
(5 rows)

--borrar database 
DROP DATABASE cuestionario;