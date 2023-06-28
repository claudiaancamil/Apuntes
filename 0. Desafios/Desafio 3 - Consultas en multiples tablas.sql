//Requerimientos

--Creacion de base de datos

CREATE DATABASE "desafio3_123";

/*1. Crea   y   agrega   al   entregable   las  consultas  para  completar  el  setup  de  acuerdo  a  lo pedido.*/

/Creando tabla ususarios/

CREATE TABLE usuarios (id serial, email varchar(50), 
nombre varchar (25), apellido varchar(25), 
rol varchar); 

/Registros para la tabla usuarios/

INSERT INTO usuarios (email, nombre, apellido, rol)
VALUES  ('andrea.pinilla@gmail.com', 'Andrea', 'Pinilla', 'Administrador'),
	    ('camila.barra@gmail.com','Camila','Barra','Usuario'),
	    ('ignacio.fuentes@gmail.com','Ignacio','Fuentes','Usuario'),
        ('diego.vega@gmail.com','Diego','Vega','Usuario'),
		('constanza.espinoza@gmail.com','Constanza','Espinoza','Usuario');
		
/Creando tabla post/
	
CREATE TABLE posts (id serial, titulo varchar, contenido text,
			 fecha_creacion timestamp, fecha_actualizacion timestamp,
			 destacado boolean, usuario_id bigint);

/Registros pertenecientes al usuario administrador (id 1 y 2) en la tabla post

INSERT INTO posts (titulo, contenido, fecha_creacion, fecha_actualizacion, destacado, usuario_id)
VALUES ('Mi primer post', 'Contenido del primer post', '2023-06-21 10:00:00', '2023-06-21 10:00:00', false, 1),
       ('El mejor post', 'Contenido del mejor post', '2023-06-22 14:30:00', '2023-06-22 14:30:00', true, 1);

/Registros asignados a otros usuarios (id 3 y 4) en la tabla post/

INSERT INTO posts (titulo, contenido, fecha_creacion, fecha_actualizacion, destacado, usuario_id)
VALUES ('Nuevo post', 'Contenido del nuevo post', '2023-06-23 09:45:00', '2023-06-23 09:45:00', false, 3),
       ('Post interesante', 'Contenido del post interesante', '2023-06-24 16:20:00', '2023-06-24 16:20:00', true, 4);

/Registro de post_sin_usuario asignado (id 5) en la tabla post/

INSERT INTO posts (titulo, contenido, fecha_creacion, fecha_actualizacion, destacado, usuario_id)
VALUES ('Post sin usuario', 'Contenido del post sin usuario', '2023-06-25 11:10:00', '2023-06-25 11:10:00', false, NULL);

/Creando tabla comentarios/

CREATE TABLE comentarios (id serial, contenido text, 
		     fecha_creacion timestamp, usuario_id bigint, 
		     post_id bigint);

/Registros pertenecientes a los comentarios de la tabla comentarios/

INSERT INTO comentarios (id, contenido, fecha_creacion, post_id, usuario_id)
VALUES
    (1, '¡Qué hermoso lugar! Me encantaría visitarlo algún día.', '2023-06-01 09:15:00', 1, 1),
    (2, 'Excelente artículo, gracias por compartir tus experiencias.', '2023-06-01 10:30:00', 1, 2),
    (3, 'Me sorprende la belleza de este destino. Definitivamente lo agregaré a mi lista de viajes.', '2023-06-02 14:45:00', 1, 3),
    (4, '¡El segundo destino que mencionas también se ve increíble! Planeo visitarlo pronto.', '2023-06-02 16:20:00', 2, 1),
    (5, 'Gracias por los consejos. Estoy emocionado por explorar estos lugares.', '2023-06-03 11:10:00', 2, 2);
    
/Verificando registros en tabla usuarios, posts y comentarios

SELECT * FROM usuarios;

SELECT * FROM posts;

SELECT * FROM comentarios;

/*2. Cruza los datos de la tabla usuarios y posts mostrando las siguientes columnas: nombre e email del usuario junto al título y 
     contenido del post.*/ 

# Usuarios que tienen asociados un titulo y contenido del post

SELECT usuarios.nombre, usuarios.email, posts.titulo, posts.contenido
FROM usuarios 
INNER JOIN posts
ON usuarios.id = posts.usuario_id 
   
# Usuarios que tienen asociados un titulo y contenido del post; titulo  y contenido del post que "no" tienen asociados usuario ni 
email; usuarios y email que "no" tienen asociados titulos ni contenido del post.

SELECT usuarios.nombre, usuarios.email, posts.titulo, posts.contenido
FROM usuarios 
FULL JOIN posts
ON usuarios.id = posts.usuario_id 

/*3. Muestra el id,  título  y contenido  de  los posts de los administradores. El administrador puede ser cualquier id.*/

# Ingresando manualmente cualquier id como administrador.

SELECT posts.usuario_id AS usuario_id, posts.titulo, posts.contenido 
FROM usuarios 
INNER JOIN posts 
ON usuarios.id = posts.usuario_id 
WHERE posts.usuario_id = 1; -- Aqui modificar manualmente el usuario_id.
   
# Utilizando "RANDOM" para consultar cualquier id como administrador.

SELECT p.usuario_id AS usuario_id, p.titulo, p.contenido
FROM usuarios u
LEFT JOIN posts p ON u.id = p.usuario_id
WHERE p.usuario_id = (
SELECT usuario_id
FROM posts
WHERE usuario_id IS NOT NULL
ORDER BY RANDOM()
LIMIT 1);

/Observación: posts.usuarios.id "no" tiene registros asociados a id 2 y 5, por ende, las tablas filtradas "no" entregarán registros.

*Nota: Se muestra el id del usuario, en otras palabras, el id administrador (cualquier id) asociado al post.

/*4.      Cuenta  la  cantidad  de  posts  de  cada  usuario.  La  tabla resultante debe mostrar el id e email del usuario junto con la 
 cantidad de posts de cada usuario.*/

# Respuesta: Al probar los tipos de "JOIN", la manera ideal es usar LEFT_JOIN porque al unir la tabla de "origen" (usuarios) con la tabla 
de "union" (posts), se indica en la consulta la cantidad de post de cada usuario (considerando "si" han realizado un post o "no"). 
En cambio, INNER_JOIN se orienta en conocer solamente quienes "si" han realizado un post, descartando en la consulta a quienes "no" han 
realizado un post. Finalmente, RIGHT_JOIN muestra quienes "si" han realizado un post pero "no" asocia que id tienen un conteo de cero post.

SELECT usuarios.id AS id_usuario, usuarios.email, count(posts.usuario_id) AS "cantidad de post"
FROM usuarios 
LEFT JOIN posts
ON usuarios.id = posts.usuario_id
GROUP BY usuarios.id, usuarios.email 
ORDER BY usuarios.id ASC;

/*5.      Muestra  el  email del usuario que ha creado más posts. Aquí la tabla resultante tiene un único registro y muestra solo el email.*/

# Respuesta :

SELECT usuarios.email AS "Email"
FROM usuarios 
INNER JOIN posts 
ON usuarios.id = posts.usuario_id
GROUP BY usuarios.email
ORDER BY COUNT(posts.usuario_id) DESC 
LIMIT 1;

*Nota: En caso de querer conocer la cantidad de posts, añado la siguiente query.

SELECT usuarios.email AS "Email" , COUNT(posts.usuario_id) AS "Cantidad de posts"
FROM usuarios 
INNER JOIN posts 
ON usuarios.id = posts.usuario_id
GROUP BY usuarios.email
ORDER BY COUNT(posts.usuario_id) DESC 
LIMIT 1;   

/*6.      Muestra la fecha del último post de cada usuario.*/

# Respuesta:

SELECT usuarios.id, usuarios.nombre, usuarios.apellido, 
	   MAX(posts.fecha_creacion) as "fecha del ultimo post"
FROM usuarios 
LEFT JOIN posts 
ON usuarios.id = posts.usuario_id
GROUP BY usuarios.id, usuarios.nombre, usuarios.apellido
ORDER BY usuarios.id;

*Nota: Los usuarios de id 2 y 5 "no" han realizado ningun post.

# Adicionalmente, incluyo query de la fecha del ultimo post de solo los  usuarios que tienen asociado posts.

SELECT usuarios.id, usuarios.nombre, usuarios.apellido, 
	   MAX(posts.fecha_creacion) as "fecha del ultimo post"
FROM usuarios 
INNER JOIN posts 
ON usuarios.id = posts.usuario_id
GROUP BY usuarios.id, usuarios.nombre, usuarios.apellido
ORDER BY usuarios.id;

/*7. Muestra el título y contenido del post (artículo) con más comentarios.*/

# Forma 1: Muestra las columnas solicitadas

SELECT posts.id AS articulo, posts.titulo, posts.contenido
FROM posts 
INNER JOIN comentarios 
ON posts.id = comentarios.post_id 
GROUP BY posts.id, posts.titulo, posts.contenido
ORDER BY count(post_id) DESC
LIMIT 1;

Forma 2: Muestra las columnas solicitadas mas el conteo de post, segun corresponda.

SELECT posts.id AS articulo, posts.titulo, posts.contenido, count(post_id) AS cantidad_de_comentarios
FROM posts 
INNER JOIN comentarios 
ON posts.id = comentarios.post_id 
GROUP BY posts.id, posts.titulo, posts.contenido
ORDER BY cantidad_de_comentarios DESC
LIMIT 1;

/*8. Muestra en una tabla el título de cada post, el contenido de cada post y el contenido de cada comentario asociado a los posts 
mostrados, junto con el email del usuario que lo escribió. */

SELECT posts.titulo AS "titulo del post" , posts.contenido AS "contenido del post",
	   comentarios.contenido "contenido del comentario del post", usuarios.email "email de usuario del post"
FROM usuarios 
RIGHT JOIN posts ON usuarios.id = posts.usuario_id 
LEFT JOIN comentarios ON posts.id = comentarios.post_id
ORDER BY posts.id ASC;

/*9. Muestra el contenido del último comentario de cada usuario.*/

# Respuesta: La siguiente query muestra el contenido del ultimo comentario de cada usuario, "sin" importar "si" tiene un comentario asociado
o "no". Por lo cual, intencionalmente los posts "sin" comentarios asociados se visualizan como "[NULL]".

SELECT u.nombre, u.apellido, COALESCE(c.contenido) AS "contenido del comentario"
FROM usuarios u
LEFT JOIN comentarios c 
ON u.id = c.usuario_id AND c.fecha_creacion = 
(SELECT MAX(c2.fecha_creacion)
FROM comentarios c2
WHERE c2.usuario_id = u.id)
ORDER BY u.id ASC;

# Otra perspectiva: Consultar los ultimos comentarios de cada usuario solo "si" tienen comentarios asociados y mostrando la fecha correspondiente.

SELECT u.nombre, u.apellido, c.contenido AS "contenido del comentario", c.fecha_creacion
FROM usuarios u
INNER JOIN comentarios c ON u.id = c.usuario_id
INNER JOIN (SELECT usuario_id, MAX(c2.fecha_creacion) AS max_fecha_creacion
FROM comentarios c2
GROUP BY usuario_id) max_c 
ON c.usuario_id = max_c.usuario_id AND c.fecha_creacion = max_c.max_fecha_creacion
ORDER BY u.id ASC;

/*10.  Muestra los emails de los usuarios que no han escrito ningún comentario.*/

SELECT usuarios.email
FROM usuarios 
LEFT JOIN comentarios ON usuarios.id = comentarios.usuario_id
GROUP BY  usuarios.email, comentarios.usuario_id, usuarios.id
HAVING comentarios.usuario_id IS NULL
ORDER BY usuarios.id ASC;
