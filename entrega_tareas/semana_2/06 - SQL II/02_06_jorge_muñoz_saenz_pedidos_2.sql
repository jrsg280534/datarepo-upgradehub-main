/*CREACIÓN DE LA BASE DE DATOS Y SUS TABLAS*/
DROP DATABASE IF EXISTS Pedidos;
CREATE DATABASE IF NOT EXISTS Pedidos; 
USE Pedidos;

CREATE TABLE IF NOT EXISTS PRODUCTO (
Codigo char(3) PRIMARY KEY,
Nombre VARCHAR(50) UNIQUE,
Precio FLOAT(6,2)
);


CREATE TABLE IF NOT EXISTS  EMPLEADO (
DNI CHAR(9) PRIMARY KEY,
Nombre VARCHAR(50),
Nss VARCHAR(11),
Turno enum('mañana', 'tarde','noche'),
Salario FLOAT(6,2)
);


CREATE TABLE IF NOT EXISTS REPARTIDOR (
DNI CHAR(9) PRIMARY KEY,
Nombre VARCHAR(50),
Turno enum('mañana', 'tarde','noche'),
Incentivo FLOAT(6,2)
);


CREATE TABLE IF NOT EXISTS PEDIDO (
Numero char(4) PRIMARY KEY,
Fecha DATE NOT NULL,
Importe FLOAT(6,2),
DNI_ETM CHAR(9),
DNI_EP CHAR(9),
DNI_R CHAR(9),
Hora_tm time,
Hora_pre time,
Hora_rep time,
CONSTRAINT  Pe_dniETM_FK FOREIGN KEY (DNI_ETM) REFERENCES EMPLEADO(DNI) ON DELETE CASCADE,
CONSTRAINT  Pe_dniEP_FK FOREIGN KEY (DNI_EP) REFERENCES EMPLEADO(DNI) ON DELETE CASCADE,
CONSTRAINT  Pe_dniR_FK FOREIGN KEY (DNI_R) REFERENCES REPARTIDOR(DNI) ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS esta_compuesto (
Codigo_P char(3),
Codigo_P_compuesto char(3),
CONSTRAINT EC_PK PRIMARY KEY (Codigo_P,Codigo_P_compuesto),
CONSTRAINT  EC_coP_FK FOREIGN KEY (Codigo_P) REFERENCES PRODUCTO(Codigo) ON DELETE CASCADE,
CONSTRAINT  EC_coPC_FK FOREIGN KEY (Codigo_P_compuesto) REFERENCES PRODUCTO(Codigo) ON DELETE CASCADE

);

CREATE TABLE IF NOT EXISTS consta(
Codigo_Pr char(3),
Numero_P char(4),
cantidad TINYINT,
CONSTRAINT CO_PK PRIMARY KEY (Codigo_Pr,Numero_P),
CONSTRAINT  CO_coP_FK FOREIGN KEY (Codigo_Pr) REFERENCES PRODUCTO(Codigo) ON DELETE CASCADE,
CONSTRAINT  CO_nuP_FK FOREIGN KEY (Numero_P) REFERENCES PEDIDO(Numero) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS PEDIDOS_FINALIZADOS (
Numero char(4) PRIMARY KEY,
Fecha DATE NOT NULL,
Importe FLOAT(6,2),
DNI_ETM CHAR(9),
DNI_EP CHAR(9),
DNI_R CHAR(9),
Hora_tm time,
Hora_pre time,
Hora_rep time,
CONSTRAINT  Pe_dniETM1_FK FOREIGN KEY (DNI_ETM) REFERENCES EMPLEADO(DNI) ON DELETE CASCADE,
CONSTRAINT  Pe_dniEP1_FK FOREIGN KEY (DNI_EP) REFERENCES EMPLEADO(DNI) ON DELETE CASCADE,
CONSTRAINT  Pe_dniR1_FK FOREIGN KEY (DNI_R) REFERENCES REPARTIDOR(DNI) ON DELETE CASCADE,
Tiempo_transcurrido time
);

CREATE TABLE RANKING_PRODUCTOS(
Codigo char(3) PRIMARY KEY,
Nombre VARCHAR(50) UNIQUE,
Total int(3)
);

/*INSERCCIÓN DE DATOS*/

/* VALORES EN TABLA PRODUCTO */
INSERT INTO PRODUCTO VALUES ('01','Hamburguesa',2.6);
INSERT INTO PRODUCTO VALUES ('02','Patatas',2.0);
INSERT INTO PRODUCTO VALUES ('03','tomate',0.50);
INSERT INTO PRODUCTO VALUES ('04','Queso',1.0);
INSERT INTO PRODUCTO VALUES ('05','Lechuga',0.50);
INSERT INTO PRODUCTO VALUES ('06','Pollo',3.6);
INSERT INTO PRODUCTO VALUES ('08','Bacon',1.5);
INSERT INTO PRODUCTO VALUES ('09','Coca cola',3.0);
INSERT INTO PRODUCTO VALUES ('19','Fanta',3.0);
INSERT INTO PRODUCTO VALUES ('10','Nestea',3.0);
INSERT INTO PRODUCTO VALUES ('18','Agua',2.0);
INSERT INTO PRODUCTO VALUES ('11','Menú de Pollo',5.0);
INSERT INTO PRODUCTO VALUES ('12','Menú de Hamburguesa con queso',6.0);
INSERT INTO PRODUCTO VALUES ('13','Menú de Pollo con queso',6.0);
INSERT INTO PRODUCTO VALUES ('14','Menú de Hamburguesa',6.0);
INSERT INTO PRODUCTO VALUES ('15','Helado',1.0);
INSERT INTO PRODUCTO VALUES ('16','Tarta',2.0);
INSERT INTO PRODUCTO VALUES ('17','Fruta',1.0);


/* VALORES EN TABLA está_compuesto */
/* menu de pollo*/
INSERT INTO esta_compuesto VALUES ('11','06');
INSERT INTO esta_compuesto VALUES ('11','02');
INSERT INTO esta_compuesto VALUES ('11','03');
INSERT INTO esta_compuesto VALUES ('11','18');
INSERT INTO esta_compuesto VALUES ('11','17');
/* menu de hamburguesa con queso*/
INSERT INTO esta_compuesto VALUES ('12','01');
INSERT INTO esta_compuesto VALUES ('12','02');
INSERT INTO esta_compuesto VALUES ('12','04');
INSERT INTO esta_compuesto VALUES ('12','10');
INSERT INTO esta_compuesto VALUES ('12','16');
/* menu de pollo con queso */
INSERT INTO esta_compuesto VALUES ('13','06');
INSERT INTO esta_compuesto VALUES ('13','08');
INSERT INTO esta_compuesto VALUES ('13','04');
INSERT INTO esta_compuesto VALUES ('13','02');
INSERT INTO esta_compuesto VALUES ('13','09');
INSERT INTO esta_compuesto VALUES ('13','15');
/* menu de hamburguesa */
INSERT INTO esta_compuesto VALUES ('14','03');
INSERT INTO esta_compuesto VALUES ('14','05');
INSERT INTO esta_compuesto VALUES ('14','08');
INSERT INTO esta_compuesto VALUES ('14','01');
INSERT INTO esta_compuesto VALUES ('14','02');
INSERT INTO esta_compuesto VALUES ('14','09');
INSERT INTO esta_compuesto VALUES ('14','15');

/* VALORES EN TABLA EMPLEADO */
INSERT INTO EMPLEADO VALUES ('11111111Q','Luis Ramírez Pardo','23445556666' , 'mañana', 900);
INSERT INTO EMPLEADO VALUES ('22222222S','María Sánchez Cid','11112223334' , 'tarde', 1000);
INSERT INTO EMPLEADO VALUES ('33333333M','Martín Guerrero López','33344455566' , 'tarde', 1000);
INSERT INTO EMPLEADO VALUES ('04444444T','Úrsula Delta Camacho', '11177788899', 'mañana', 900);
INSERT INTO EMPLEADO VALUES ('55555555J','Carmen Hernández Pío','99966633311' , 'mañana', 900);
INSERT INTO EMPLEADO VALUES ('77777777M','Pedro Jiménez Ruiz','23456785432' , 'tarde', 1000);
INSERT INTO EMPLEADO VALUES ('99999999X','Raúl Rodrigo Roca','55566677789' , 'tarde', 1000);
INSERT INTO EMPLEADO VALUES ('88888888O','Soledad Campillo Molina','00088877754' , 'noche', 1200);
INSERT INTO EMPLEADO VALUES ('03232323P','María Luisa Galdón Ter','43534534567', 'noche', 1200);
INSERT INTO EMPLEADO VALUES ('14567555L','Piedad Colmenero Zapillo','23456734534' , 'noche', 1200);
INSERT INTO EMPLEADO VALUES ('14111155T','Sergio Lérida Campos','55577700089' , 'tarde', 1000);


/* VALORES EN TABLA REPARTIDOR */
INSERT INTO REPARTIDOR VALUES ('14188151T','Carlos Sánchez Ruíz', 'tarde', 300);
INSERT INTO REPARTIDOR VALUES ('11245621Q','Juan Pardo Rubio', 'noche', 400);
INSERT INTO REPARTIDOR VALUES('04477744T','Laura Jiménez Jiménez', 'noche', 400);
INSERT INTO REPARTIDOR VALUES('51235555J','Carmen Capel Pío', 'tarde', 300);
INSERT INTO REPARTIDOR VALUES('55675675J','Juan Sánchez López', 'mañana', 200);
INSERT INTO REPARTIDOR VALUES('99009900J','Alejandro Pardo López', 'mañana', 400);

/* VALORES EN TABLA PEDIDOS */
INSERT INTO PEDIDO VALUES('0001','2020-10-15',10,'11111111Q','04444444T','55675675J','12:00','12:15','12:45');
INSERT INTO PEDIDO VALUES('0002','2020-11-11',15,'22222222S','77777777M','99009900J','13:30','13:45','14:05');
INSERT INTO PEDIDO VALUES('0003','2020-10-15',13,'77777777M','22222222S','99009900J','15:00','15:15','15:45');
INSERT INTO PEDIDO VALUES('0004','2020-11-10',13,'99999999X','77777777M','04477744T','14:02','14:30','14:45');
INSERT INTO PEDIDO VALUES('0005','2020-09-05',14,'14567555L','03232323P','14188151T','19:02','19:30','19:45');
INSERT INTO PEDIDO VALUES('0006','2020-11-15',23,'14567555L','88888888O','04477744T','21:02','21:35','21:45');
INSERT INTO PEDIDO VALUES('0007','2020-09-25',17,'03232323P','88888888O','14188151T','23:05','23:12','23:35');
INSERT INTO PEDIDO VALUES('0008','2020-09-15',14,'99999999X','33333333M','11245621Q','18:02','18:30','18:45');
INSERT INTO PEDIDO VALUES('0009','2020-11-23',25,'04444444T','55555555J','99009900J','11:02','11:30','11:55');
INSERT INTO PEDIDO VALUES('0010','2020-11-05',45,'88888888O','14567555L',null,'22:05','22:12',null);
INSERT INTO PEDIDO VALUES('0011','2020-11-05',45,'88888888O','14567555L',null,'22:05',null,null);
INSERT INTO PEDIDO VALUES('0012','2020-11-16',20,'03232323P','044444444T',null,'18:00','18:03',null);


/* VALORES EN TABLA consta */
INSERT INTO consta VALUES ('11','0001',2);
INSERT INTO consta VALUES ('12','0001',1);
INSERT INTO consta VALUES ('11','0002',1);
INSERT INTO consta VALUES ('12','0002',2);
INSERT INTO consta VALUES ('15','0002',2);
INSERT INTO consta VALUES ('14','0003',2);
INSERT INTO consta VALUES ('17','0003',1);
INSERT INTO consta VALUES ('13','0004',3);
INSERT INTO consta VALUES ('04','0004',1);
INSERT INTO consta VALUES ('13','0005',2);
INSERT INTO consta VALUES ('12','0005',1);
INSERT INTO consta VALUES ('02','0005',1);
INSERT INTO consta VALUES ('12','0006',2);
INSERT INTO consta VALUES ('13','0006',1);
INSERT INTO consta VALUES ('19','0006',1);
INSERT INTO consta VALUES ('18','0006',1);
INSERT INTO consta VALUES ('12','0007',2);
INSERT INTO consta VALUES ('09','0007',1);
INSERT INTO consta VALUES ('02','0007',1);
INSERT INTO consta VALUES ('13','0008',2);
INSERT INTO consta VALUES ('11','0008',1);
INSERT INTO consta VALUES ('13','0009',4);
INSERT INTO consta VALUES ('15','0009',1);
INSERT INTO consta VALUES ('12','0010',3);
INSERT INTO consta VALUES ('13','0010',3);
INSERT INTO consta VALUES ('16','0010',3);
INSERT INTO consta VALUES ('04','0010',3);
INSERT INTO consta VALUES ('04','0011',2);

-- Obtener el listado de todos los productos

SELECT * FROM producto;

-- Obtener el número de pedido, dni del repartidor y hora de reparto de aquellos
-- pedidos que se toman nota después de las siete de la tarde.

SELECT Numero, DNI_R, Hora_rep FROM pedido WHERE hora_rep > '19:00:00';
-- SELECT numero, dni_r, Hora_rep FROM pedido HAVING hora_rep > '19:00:00';

-- Obtener todos los campos de empleados que cobran entre 900 y 1000 euros.

SELECT * FROM empleado WHERE Salario BETWEEN 900 AND 1000 AND Salario IS NOT NULL;
-- SELECT * FROM empleado WHERE Salario >= 900 AND Salario <= 1000 AND Salario IS NOT NULL;

-- Obtener el número de pedido e importe de aquellos que han sido registrados en el
-- mes de noviembre de 2020 y su importe es mayor a 15 Euros.

SELECT Numero, Importe FROM pedido WHERE Importe > 15.00 AND Fecha BETWEEN "2020-11-01" AND "2020-11-30";

-- Obtener por cada uno de los repartidores su DNI junto a la cantidad de pedidos entregados.

SELECT DNI_R, COUNT(*) AS TOTAL_PEDIDOS_REPARTIDOS FROM pedido WHERE DNI_R IS NOT null GROUP BY DNI_R;

-- Obtener por cada mes (con el formato de nombre y no de número ej. Noviembre),la cantidad
-- de pedidos realizados.

SET lc_time_names = 'es_ES';

SELECT MONTHNAME(Fecha) AS Mes, COUNT(*) AS PEDIDOS_MENSUALES FROM pedido GROUP BY MONTHNAME(Fecha);

SELECT MONTHNAME(fecha) as Mes, COUNT(Numero) as Cant_pedidos FROM PEDIDO P
WHERE P.Numero and fecha IS NOT NULL GROUP BY MONTH(fecha);

-- Obtener un listado con el nombre y dni de los empleados en el mismo campo y
-- anteponiendo el dni al nombre de la siguiente forma (ej; 45776633P, Juan Rodríguez López)
-- que tenga turno de “tarde” o "noche". Ordenar el listado por dni.

SELECT CONCAT (DNI,', ', Nombre) AS 'DNI-Nombre' FROM empleado WHERE turno = 'tarde' or turno = 'noche' ORDER BY DNI;

-- Obtener el nombre, código y precio de aquellos productos que superen o igualen
-- la media de todos los precios. Ordenar de mayor a menor precio.

SELECT Nombre, Codigo, Precio FROM producto WHERE Precio >= (SELECT avg(Precio) FROM producto) ORDER BY Precio desc;

-- Obtener un listado con el nombre y DNI de los empleados que no han preparado
-- nunca ningún pedido.

SELECT Nombre, DNI FROM empleado LEFT JOIN pedido ON empleado.DNI = pedido.DNI_EP WHERE Numero IS NULL; 

SELECT nombre, dni FROM empleado LEFT JOIN pedido ON empleado.dni = pedido.dni_ep WHERE pedido.dni_ep IS NULL;

SELECT Nombre, DNI FROM empleado WHERE DNI NOT IN (SELECT DISTINCT dni_EP FROM pedido);

-- Obtener el código, nombre y precio de los productos(estos dos últimos en el mismo
-- campo) que están contenidos en los pedidos que ha tomado nota "Luis" o "María
-- Luisa". Ordena el listado de mayor a menor valor por fecha del pedido.

SELECT codigo, CONCAT(producto.nombre,', ',precio)
FROM producto INNER JOIN consta ON codigo = codigo_pr
INNER JOIN pedido ON numero_p = numero
INNER JOIN empleado ON empleado.dni = pedido.dni_etm
WHERE empleado.nombre LIKE "%Luis%"
ORDER BY dni_etm DESC;

SELECT PR.Codigo, CONCAT(PR.Nombre, ' ' , PR.Precio) AS NOMBRE_PRECIO
FROM PRODUCTO PR, PEDIDO P, CONSTA C, EMPLEADO E
WHERE PR.Codigo = C.Codigo_Pr
AND P.Numero= C.Numero_P
AND P.DNI_ETM= E.DNI
AND E.nombre LIKE '%Luis%' OR "%María Luisa%"
ORDER BY P.Fecha DESC;

-- Obtener por cada repartidor, su nombre, cantidad de pedidos y el tiempo medio
-- que tardan en entregar los pedidos una vez preparados. Ordenar el listado el
-- tiempo medio que tardan en entregarlos:

SELECT repartidor.nombre, TIME_FORMAT(AVG(TIMEDIFF(hora_rep,hora_pre)),"%T") AS tiempo_medio_preparacion, COUNT(*) AS Cantidad_repartos
FROM pedido INNER JOIN repartidor ON repartidor.dni = pedido.dni_r GROUP BY repartidor.dni ORDER BY tiempo_medio_preparacion;

SELECT repartidor.nombre, count(*) as cantidad_repartos,
TIME_FORMAT(AVG(TIMEDIFF(Hora_rep, Hora_pre)),'%T') AS tiempo_entrega
FROM repartidor INNER JOIN pedido on repartidor.DNI = pedido.DNI_R
GROUP BY repartidor.DNI
ORDER BY tiempo_entrega;

-- Obtener un listado obteniendo el código, nombre y el precio de los productos
-- cuyo precios sea el más barato o el más caro de todos.

SELECT Codigo, Nombre, Precio 
From producto 
WHERE precio = (SELECT MAX(precio) FROM producto)
OR precio = (SELECT MIN(precio) FROM producto);


-- Obtener por cada producto , el nombre y código el número total de pedidos en
-- los que se encuentra teniendo en cuenta que el total de pedidos en los cuales se
-- encuentre sea superior o igual a dos. Ordena el listado de mayor a menor
-- número de productos.

SELECT nombre, codigo, COUNT(*) AS cantidad_pedidos 
FROM producto
INNER JOIN consta ON producto.codigo = consta.codigo_pr
INNER JOIN pedido ON pedido.numero = consta.numero_p
GROUP BY codigo_pr
HAVING cantidad_pedidos > 1;


-- Mostrar listado de los empleados (código y NSS en la misma columna) que
-- han tomado nota de algún pedido y contienen el producto de código 13 y
-- además el repartidor sea 'Laura'.

SELECT empleado.Nombre, CONCAT(empleado.DNI,', ',empleado.Nss) AS DNI_Nss
FROM empleado, pedido, repartidor, consta
WHERE empleado.DNI = pedido.DNI_EP
AND pedido.DNI_R = repartidor.DNI
AND pedido.Numero = consta.Numero_P
AND consta.Codigo_PR = '13'
AND repartidor.Nombre LIKE '%Laura%';


-- Obtener el nombre del producto que es menú junto con el código de los
-- productos que lo componen en aquellos pedidos del mes de septiembre de
-- 2020.

SELECT P.numero AS numero_pedido,
PR.nombre , PR.codigo,
EC.codigo_P_compuesto as producto_que_lo_compone,
PRODUCTO.nombre as descripción_p_que_lo_compone
FROM producto PR, pedido P, esta_compuesto EC, consta C, producto PRODUCTO
WHERE PR.codigo=EC.codigo_p AND PR.codigo=C.codigo_PR
AND P.numero=C.numero_P AND PRODUCTO.codigo= EC.codigo_p_compuesto
AND P.fecha BETWEEN '2020-09-01' AND '2020-09-30';

SELECT PR.Nombre, PR.Codigo, esta_compuesto.Codigo_P_compuesto, PRODUCTO.nombre
FROM producto PR, pedido, esta_compuesto, consta, producto PRODUCTO
WHERE PR.codigo = esta_compuesto.codigo_p
AND PR.codigo = consta.codigo_PR
AND pedido.numero = consta.numero_P
AND PRODUCTO.codigo = esta_compuesto.codigo_p_compuesto
AND pedido.Fecha BETWEEN '2020-09-01' AND '2020-09-30';


-- Insertar un nuevo registro en la tabla EMPLEADOS con los siguientes datos:
-- •DNI:98567432x
-- •Nombre: Luis Fernández Cáceres
-- •Nss:09809809822
-- •Turno: tarde
-- •Salario:850

-- INSERT INTO empleado
-- (DNI,Nombre,Nss,Turno,Salario)
-- VALUES ('98567432x','Luis Fernández Cáceres','09809809822','tarde','850');

select * from empleado; # De esta manera lo introducimos de manera manual

-- Modificar usando Workbench
-- El pedido con número 010 se la ha asignado el repartidor 11245621Q y se ha sido entregado a la hora
-- 22:20:45.
-- Modifica los datos en la tabla correspondiente

select * from pedido;

-- El producto fruta (17) está agotado, por favor borrar de la tabla correspondiente

select * from producto;

-- Insertar los siguientes datos en la tabla PEDIDO teniendo en cuenta que debes insertar sólo los valores
-- necesarios en los campos correspondientes.

select * from pedido;


-- Incrementar un 10% el importe de todos los pedidos que se han realizado en el mes de Noviembre de
-- 2020.(Debes hacerlo con una única sentencia).

UPDATE PEDIDO SET Importe = Importe * 1.1 WHERE Fecha between '2020-11-01' and '2020-11-30';

-- Eliminar los pedidos cuyo tiempo de reparto ha sido de 25 minutos o más (desde que éstos estaban
-- preparados) y además estaban asignados al repartidor de nombre Alejandro Pardo López. (Debes hacerlo
-- con una única sentencia).

DELETE FROM PEDIDO WHERE MINUTE(TIMEDIFF(HORA_REP,HORA_PRE))>=25 AND DNI_R
= (SELECT DNI FROM REPARTIDOR WHERE NOMBRE='Alejandro Pardo López');

UPDATE repartidor set incentivo = incentivo +50 WHERE dni in (SELECT dni_r FROM
tarea5_bd2021.pedido group by dni_r having count(dni_r)>=2);

INSERT INTO PEDIDOS_FINALIZADOS SELECT *, TIMEDIFF(Hora_rep ,Hora_tm) FROM PEDIDO
WHERE Hora_rep IS NOT NULL;





