DROP DATABASE IF EXISTS colegio;

CREATE DATABASE Colegio CHARACTER SET UTF8mb4 COLLATE utf8mb4_bin;

USE colegio;
-- CREATE DATABASE sirve para crear la base de datos.
-- CHARACTER SET sirve para dotar de un rango de lenguaje.
-- UTF8MB4: Acepta palabras de origen latino y emoticonos.
-- USE: selecciona la base de datos.

CREATE TABLE asignatura (
id INT NOT NULL auto_increment,
nombre VARCHAR(25) NOT NULL,
PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;

-- ¿Qué significa auto_increment?
-- ¿Y not null? ¿Y primary key? e ¿innodb?

CREATE TABLE alumno (
id INT NOT NULL auto_increment,
nombre VARCHAR(25) NOT NULL,
apellido VARCHAR (25) NOT NULL,
fecha_nacimiento DATE NOT NULL,
PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;

CREATE TABLE nota (
id INT NOT NULL auto_increment,
asignatura_id INT,
calificacion FLOAT NOT NULL,
fecha_examen DATE NOT NULL,
convocatoria INT,
alumno_id INT,
INDEX alum_ind (alumno_id),
FOREIGN KEY (alumno_id)
REFERENCES alumno(id)
ON DELETE CASCADE,
INDEX asignat_ind (asignatura_id),
FOREIGN KEY (asignatura_id)
REFERENCES asignatura(id)
ON DELETE CASCADE,
PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;

-- ¿Delete cascade?
-- ¿Update cascade?
-- ¿Qué son los índices?

CREATE TABLE labor_extra (
puesto VARCHAR(50) NOT NULL,
alumno_id INT NOT NULL,
INDEX alum_ind (alumno_id),
FOREIGN KEY (alumno_id)
REFERENCES alumno(id)
ON DELETE CASCADE,
PRIMARY KEY (puesto, alumno_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1
AUTO_INCREMENT=1;

SELECT * FROM asignatura;

-- insertar asignatura
INSERT INTO asignatura(nombre) VALUES ('Matemáticas');
INSERT INTO asignatura(nombre) VALUES ('Lengua');

-- insertar alumno
INSERT INTO alumno(nombre, apellido, fecha_nacimiento) VALUES ('Juan', 'Quesada', '1980-09-03');
INSERT INTO alumno(nombre, apellido, fecha_nacimiento) VALUES ('Manuel', 'Rico', '1992-11-10');
INSERT INTO alumno(nombre, apellido, fecha_nacimiento) VALUES ('Pedro', 'Riesgo', '1980-01-05');
INSERT INTO alumno(nombre, apellido, fecha_nacimiento) VALUES ('Maria', 'Valenzuela', '1986-12-19');

-- insertar nota
INSERT INTO nota(asignatura_id, calificacion, fecha_examen,convocatoria, alumno_id) VALUES (1, 7, '2018-12-19', 1, 1);
INSERT INTO nota(asignatura_id, calificacion, fecha_examen,convocatoria, alumno_id) VALUES (2, 5, '2018-11-03', 2, 1);
INSERT INTO nota(asignatura_id, calificacion, fecha_examen,convocatoria, alumno_id) VALUES (1, 3, '2018-11-03', 3, 2);
INSERT INTO nota(asignatura_id, calificacion, fecha_examen,convocatoria, alumno_id) VALUES (2, 8, '2018-11-03', 1, 2);
INSERT INTO nota(asignatura_id, calificacion, fecha_examen,convocatoria, alumno_id) VALUES (1, 2, '2018-07-05', 2, 3);
INSERT INTO nota(asignatura_id, calificacion, fecha_examen,convocatoria, alumno_id) VALUES (2, 5, '2018-11-03', 1, 3);
INSERT INTO nota(asignatura_id, calificacion, fecha_examen,convocatoria, alumno_id) VALUES (1, 9, '2018-09-13', 3, 4);
INSERT INTO nota(asignatura_id, calificacion, fecha_examen,convocatoria, alumno_id) VALUES (2, 5, '2018-11-23', 1, 4);		

-- insert labor extra
INSERT INTO labor_extra(puesto, alumno_id) VALUES ('Delegado', 1);
INSERT INTO labor_extra(puesto, alumno_id) VALUES ('Director', 2);

 -- seleccion de datos
select * from asignatura; -- //Selecciona todos los campos de asignatura
select nombre, apellido from alumno; -- //Es mejor anotar qué atributos mostrar.
select a.nombre, a.apellido from alumno a; -- //Podemos nombrar la tabla

-- Modificar una tabla, Alter Table
ALTER TABLE alumno ADD COLUMN apellido2 VARCHAR(25) AFTER apellido;

-- Ejemplos Actualizar
UPDATE alumno SET apellido2 = 'Palazon' WHERE id = 1;
UPDATE alumno SET apellido2 = 'Gomez' WHERE id = 2;
UPDATE alumno SET apellido2 = 'Leost' WHERE id = 3;
UPDATE alumno SET apellido2 = 'Martin' WHERE nombre = 'Maria' and apellido = 'Gutierrez';
-- Si actualizamos usando los campos nombre y apellido puede ocurrir que actualicemos varios alumnos que se llamen igual. 
-- Es mejor localizar a los registros por su clave primaria.

SELECT a.nombre, asig.nombre as asignatura, n.calificacion
FROM alumno a
INNER JOIN nota n ON a.id = n.alumno_id
INNER JOIN asignatura asig ON asig.id = n.asignatura_id
ORDER BY apellido;


SELECT a.nombre, asig.nombre as asignatura, n.calificacion
FROM alumno a, asignatura asig, nota n
WHERE a.id = n.alumno_id AND asig.id = n.asignatura_id
ORDER BY apellido;

-- Uso de IN
SELECT a.nombre, asig.nombre as asignatura, n.calificacion
FROM alumno a
INNER JOIN nota n ON a.id = n.alumno_id
INNER JOIN asignatura asig ON asig.id = n.asignatura_id
WHERE n.calificacion in (5, 6, 7, 8)
ORDER BY calificacion;

-- Uso de Where
SELECT * FROM nota WHERE calificacion = 6;
SELECT * FROM nota WHERE calificacion != 6;
SELECT * FROM nota WHERE calificacion < 6;
SELECT * FROM nota WHERE calificacion > 6;
SELECT * FROM nota WHERE calificacion <= 6;
SELECT * FROM nota WHERE calificacion >= 6;
SELECT * FROM nota WHERE calificacion not in (2,3,4);
SELECT * FROM nota WHERE calificacion between 2 and 4;
SELECT * FROM nota WHERE calificacion not between 2 and 4;

-- Left Outer Join
SELECT a.nombre, l.puesto
FROM alumno a
LEFT OUTER JOIN labor_extra l ON a.id = l.alumno_id;

-- Group By
SELECT a.nombre, a.apellido, avg(n.calificacion) as media
FROM alumno a
INNER JOIN nota n ON a.id = n.alumno_id
INNER JOIN asignatura asig ON asig.id = n.asignatura_id
GROUP BY a.nombre, a.apellido
ORDER BY media DESC;

-- Filtrados usando Having
SELECT a.nombre, a.apellido, avg(n.calificacion) as media
FROM alumno a
INNER JOIN nota n ON a.id = n.alumno_id
INNER JOIN asignatura asig ON asig.id = n.asignatura_id
GROUP BY a.nombre, a.apellido
HAVING media >= 6
ORDER BY media desc;

-- Delete
-- Opción menos recomendable - DELETE FROM labor_extra WHERE puesto = 'Director'
-- Opción recomendable - DELETE FROM labor_extra WHERE id = 1

-- Drop Tables
-- Una vez que se disponen de claves foráneas (FK) el borrado de tablas se debe realizar en un orden concreto ya que existen dependencias entre tablas.
-- En este caso he borrado las tablas en el orden inverso de creación para evitar estos problemas.
DROP TABLE labor_extra;
DROP TABLE nota;
DROP TABLE alumno;
DROP TABLE asignatura;

DROP DATABASE colegio;



























