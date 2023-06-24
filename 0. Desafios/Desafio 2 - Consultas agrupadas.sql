/*DESAFIO 2 : CONSULTAS AGRUPADAS*/

--Utilizando  el  siguiente  set  de  datos:

CREATE DATABASE desafio2_Claudia_Ancamil_123;

CREATE TABLE IF NOT EXISTS INSCRITOS(cantidad INT, fecha DATE, fuente 
VARCHAR);
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

/*¿Cuántos registros hay? : Hay 16 registros.*/

SELECT COUNT(*) AS "Cantidad de registros" FROM inscritos;

/*¿Cuántos inscritos hay en total? : Hay 774 inscritos en total.*/

SELECT SUM(cantidad) AS "Total cantidad de inscritos" FROM inscritos; 

/*¿Cuál o cuáles son los registros de mayor antigüedad? (HINT: ocupar subconsultas): Los registros con fecha 
 * '2021-01-01'correspondiente a blog y pagina*/

SELECT  fecha AS "Fecha", fuente AS "Fuente", cantidad AS "Cantidad de inscritos"
FROM  inscritos
WHERE fecha IN (SELECT MIN(fecha) FROM inscritos);

/*¿Cuántos    inscritos   hay   por   día?   (entendiendo   un   día   como   una   fecha   distinta   de ahora en adelante)*/

SELECT  fecha AS "Dias", sum(cantidad) AS "Inscritos por dia" FROM inscritos 
GROUP BY fecha ORDER BY fecha ASC;

/*¿Cuántos inscritos hay por fuente? : Hay 441 inscritos en la página y 333 inscritos en el blog*/

SELECT fuente AS "Fuente", sum(cantidad) AS "Inscritos por fuente" FROM inscritos 
GROUP BY fuente;

/*Qué día se inscribió la mayor cantidad de personas? ¿Cuántas personas se inscribieron en ese día? : 
 * El dia '2021-08-01' se incribieron la mayor cantidad de personas correspondiente a 182 personas*/

SELECT fecha AS "Dia", SUM(cantidad) AS "Cantidad de personas" FROM inscritos 
GROUP BY fecha ORDER BY SUM (cantidad) DESC LIMIT 1;

/*¿Qué  días se inscribieron la mayor cantidad de personas utilizando el blog? ¿Cuántas personas fueron? 
 * HINT: si hay más de un registro, tomar el primero : El dia '2021-08-01' y fueron 83 personas.*/

SELECT fuente AS "Fuente", fecha AS "Dias", cantidad AS "Cantidad de personas" FROM inscritos
WHERE cantidad = (SELECT MAX (cantidad) FROM inscritos WHERE fuente = 'Blog');

/*¿Cuál es el promedio de personas inscritas por día?*/

SELECT fecha AS "Dias", AVG (cantidad) AS " Promedio de personas inscritas por dia" FROM inscritos 
GROUP BY fecha ORDER BY fecha ASC; 

/*¿Qué días se inscribieron más de 50 personas?*/

SELECT fecha AS "Dias", SUM(cantidad) AS "Cantidad de personas inscritas" FROM inscritos 
GROUP BY fecha HAVING SUM(cantidad) > 50 ORDER BY sum(cantidad) ASC;

/*¿Cuál es el promedio general de personas inscritas a partir del tercer día? HINT: Ingresa manualmente la fecha del tercer día : 
 * El promedio general corresponde a 46.1666666666666667*/

--Forma 1: Ingresando manualmente la fecha del tercer dia

SELECT AVG (cantidad) AS "Promedio general a partir del 3er dia" FROM inscritos 
WHERE fecha >= '2021-03-01';

--Forma 2: No ingresando manualmente la fecha del tercer dia.

SELECT AVG(total) AS "Promedio general a partir del 3er dia" 
FROM (SELECT fecha, AVG(cantidad) AS total
FROM inscritos WHERE fecha >= (SELECT MIN(fecha) FROM inscritos)
GROUP BY fecha ORDER BY fecha OFFSET 2) subquery;


--Sin embargo, tambien se puede obtener el promedio general a partir de la sumatoria entre blog y pagina por dia, 
--lo cual, aumenta el promedio a 92.3333333333333333 (a partir del tercer dia).

--Forma 1: Ingresando manualmente la fecha del tercer dia

SELECT AVG(total) AS "Promedio general a partir del 3er dia" 
FROM (SELECT fecha, SUM(cantidad) AS total
FROM inscritos WHERE fecha >= '2021-03-01' GROUP BY fecha) subquery;

--Forma 2: No ingresando manualmente la fecha del tercer dia.

SELECT AVG(total) AS "Promedio general a partir del 3er dia" 
FROM (SELECT fecha, SUM(cantidad) AS total
FROM inscritos WHERE fecha >= (SELECT MIN(fecha) FROM inscritos)
GROUP BY fecha ORDER BY fecha OFFSET 2) subquery;
