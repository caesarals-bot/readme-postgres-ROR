CREATE DATABASE cuestionario;

\c cuestionario;

--4. Crea las tablas respetando los nombres, tipos, claves primarias y foráneas y tipos de datos.
CREATE TABLE preguntas (id SERIAL PRIMARY KEY, pregunta VARCHAR(255), respuesta_correcta VARCHAR(255));

CREATE TABLE usuarios (id SERIAL PRIMARY KEY, nombre VARCHAR(255), edad INTEGER);

CREATE TABLE respuestas (id SERIAL PRIMARY KEY, respuesta VARCHAR(255), usuario_id INTEGER REFERENCES usuarios(id),pregunta_id INTEGER REFERENCES preguntas(id));

--5. Agrega datos, 5 usuarios y 5 preguntas, la primera pregunta debe estar contestada

INSERT INTO usuarios (nombre, edad) VALUES ('Marcos', 22), ('Berta', 45), ('Luis', 25), ('miguel', 34), ('octavio', 42);

INSERT INTO preguntas (pregunta, respuesta_correcta) VALUES ('¿Quien creo el sql?', 'ibm'), ('¿Quien creo ruby?', 'Yukihiro'), ('¿Quien creo ruby on rails?', 'David'), ('¿En que anho se crea javascript?', '1995'), ('¿Quien creo el hatml?', 'Tim Berners-Lee');

INSERT INTO respuestas (respuesta, usuario_id, pregunta_id) VALUES ('ibm', 1, 1), ('ibm', 2, 1), ('oracle', 3, 1), ('marck', 4, 1), ('oscar', 5, 1), ('grace', 1, 2), ('ritchie', 2, 2), ('Gates', 3, 2), ('Yukihiro', 4, 2), ('Linus', 5, 2), ('Oscar', 1, 3), ('Augusto', 2, 3), ('Eduardo', 3, 3), ('Hector', 4, 3), ('Matias', 5, 3), ('1700', 1, 4), ('1800', 2, 4), ('1900', 3, 4), ('2000', 4, 4), ('2010', 5, 4);

--6. Cuenta la cantidad de respuestas correctas totales por usuario (independiente de la pregunta)
SELECT usuarios.nombre, COALESCE(COUNT(respuestas.respuesta), 0) AS respuestas_correctas FROM usuarios LEFT JOIN respuestas ON usuarios.id = respuestas.usuario_id AND respuestas.respuesta = (SELECT respuesta_correcta FROM preguntas WHERE preguntas.id = respuestas.pregunta_id) GROUP BY usuarios.id;
 nombre  | respuestas_correctas
---------+----------------------
 Marcos  |                    1
 Berta   |                    1
 Luis    |                    0
 miguel  |                    1
 octavio |                    0

SELECT usuarios.nombre, COALESCE(COUNT(respuestas.respuesta), 0) AS respuestas_correctas 
FROM usuarios
LEFT JOIN respuestas ON usuarios.id = respuestas.usuario_id AND respuestas.respuesta = (SELECT respuesta_correcta FROM preguntas WHERE preguntas.id = respuestas.pregunta_id)
GROUP BY usuarios.id;
--7. Por cada pregunta, en la tabla preguntas, cuenta cuántos usuarios tuvieron la respuesta correcta.

SELECT preguntas.pregunta, COUNT(DISTINCT(respuestas.usuario_id)) as usuarios_correctos FROM preguntas INNER JOIN respuestas ON preguntas.id = respuestas.pregunta_id AND preguntas.respuesta_correcta = respuestas.respuesta GROUP BY preguntas.pregunta;
      pregunta       | usuarios_correctos
---------------------+--------------------
 ¿Quien creo el sql? |                  2
 ¿Quien creo ruby?   |                  1

SELECT preguntas.pregunta, COUNT(DISTINCT(respuestas.usuario_id)) as usuarios_correctos
FROM preguntas
INNER JOIN respuestas ON preguntas.id = respuestas.pregunta_id AND preguntas.respuesta_correcta = respuestas.respuesta
GROUP BY preguntas.pregunta;

--8. Implementa borrado en cascada de las respuestas al borrar un usuario y borrar el primer usuario para probar la implementación.

ALTER TABLE respuestas DROP CONSTRAINT respuestas_usuario_id_fkey, ADD CONSTRAINT respuestas_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE;
ALTER TABLE respuestas ADD CONSTRAINT fk_respuestas_usuario_id FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE;
DELETE FROM usuarios WHERE id = 1;

ERROR:  update or delete on table "usuarios" violates foreign key constraint "respuestas_usuario_id_fkey" on table "respuestas"
ALTER TABLE respuestas
ADD CONSTRAINT fk_respuestas_usuario_id
FOREIGN KEY (usuario_id)
REFERENCES usuarios(id)
ON DELETE CASCADE; 

ALTER TABLE respuestas
DROP CONSTRAINT respuestas_usuario_id_fkey,
ADD CONSTRAINT respuestas_usuario_id_fkey
  FOREIGN KEY (usuario_id)
  REFERENCES usuarios(id)
  ON DELETE CASCADE;

--9. Crea una restricción que impida insertar usuarios menores de 18 años en la base de datos.
ALTER TABLE usuarios ADD CONSTRAINT usuarios_edad_ck CHECK (edad >= 18);

--10. Altera la tabla existente de usuarios agregando el campo email con la restricción de único.
\


SELECT usuarios.nombre, COUNT(respuestas.respuesta) AS respuestas_correctas FROM usuarios LEFT JOIN respuestas ON usuarios.id = respuestas.usuario_id WHERE respuestas.respuesta = preguntas.respuesta_correcta GROUP BY usuarios.nombre;