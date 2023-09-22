
--cear DB
CREATE DATABASE desafio2_cesar_londono_339;

--creamos las tablas
CREATE TABLE IF NOT EXISTS inscritos(cantidad INT, fecha DATE, fuente VARCHAR);

--Insertar datos
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 44, '01/01/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 56, '01/01/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 39, '01/02/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 81, '01/02/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 12, '01/03/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 91, '01/03/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 48, '01/04/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 45, '01/04/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 55, '01/05/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 33, '01/05/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 18, '01/06/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 12, '01/06/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 34, '01/07/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 24, '01/07/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 83, '01/08/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 99, '01/08/2021', 'Página' );

--1-¿Cuántos registros hay? 
SELECT COUNT(*) FROM inscritos;

 count
-------
    16
(1 row)

--2-¿Cuántos inscritos hay en total?
SELECT SUM(cantidad) as total_inscritos from inscritos;

total_inscritos
-----------------
      774
(1 row)

--3- ¿Cuál o cuáles son los registros de mayor antigüedad?
SELECT fecha, cantidad FROM inscritos WHERE fecha IN(SELECT MIN(fecha) FROM inscritos);

   fecha    | cantidad
------------+----------
 2021-01-01 |       44
 2021-01-01 |       56
(2 rows)

--4-¿Cuántos inscritos hay por día? (entendiendo un día como una fecha distinta de ahora en adelante)

SELECT fecha, SUM(cantidad) from inscritos GROUP BY FECHA HAVING COUNT(*) > 1 ORDER BY FECHA DESC;

   fecha    | sum
------------+-----
 2021-01-08 | 182
 2021-01-07 |  58
 2021-01-06 |  30
 2021-01-05 |  88
 2021-01-04 |  93
 2021-01-03 | 103
 2021-01-02 | 120
 2021-01-01 | 100
(8 rows)

--5- ¿Qué día se inscribieron la mayor cantidad de personas y cuántas personas se inscribieron en ese día?
SELECT fecha, cantidad FROM inscritos WHERE cantidad IN(SELECT MAX(cantidad) FROM inscritos);
   fecha    | cantidad
------------+----------
 2021-01-08 |       99
(1 row)