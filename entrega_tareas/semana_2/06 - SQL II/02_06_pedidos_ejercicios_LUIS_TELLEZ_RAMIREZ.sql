# Ejercicio Diapositiva 5

SELECT PR.Codigo, CONCAT(PR.Nombre, ' ' , PR.Precio) AS NOMBRE_PRECIO
FROM PRODUCTO PR, PEDIDO P, CONSTA C, EMPLEADO E
WHERE PR.Codigo = C.Codigo_Pr
AND P.Numero= C.Numero_P
AND P.DNI_ETM= E.DNI
AND E.nombre LIKE '%Luis%' OR "%María Luisa%"
ORDER BY P.Fecha DESC;


SELECT codigo, CONCAT(producto.nombre,', ',precio)
FROM producto INNER JOIN consta ON codigo = codigo_pr
INNER JOIN pedido ON numero_p = numero
INNER JOIN empleado ON empleado.dni = pedido.dni_etm
WHERE empleado.nombre LIKE "%Luis%"
ORDER BY pedido.fecha DESC;

# Ejercicio Diapositiva 6

SELECT * FROM REPARTIDOR;
SELECT * FROM PEDIDO;

SELECT REPARTIDOR.nombre, COUNT(*) AS cantidad_repartos,
TIME_FORMAT(AVG(TIMEDIFF(Hora_rep, Hora_pre)),'%T') AS tiempo_entrega
FROM REPARTIDOR, PEDIDO
WHERE REPARTIDOR.DNI = PEDIDO.DNI_R
GROUP BY REPARTIDOR.DNI
ORDER BY 3;


SELECT repartidor.nombre, count(*) as cantidad_repartos,
 TIME_FORMAT(AVG(TIMEDIFF(Hora_rep, Hora_pre)),'%T') AS tiempo_entrega 
FROM repartidor INNER JOIN pedido on repartidor.DNI = pedido.DNI_R
GROUP BY repartidor.DNI
ORDER BY tiempo_entrega;

# Ejercicio Diapositiva 7



select Codigo, Nombre, Precio
from producto
where Precio = (select max(Precio) from producto)
or Precio = (select min(Precio) from producto);


# Ejercicio Diapositiva 8

SELECT PRODUCTO.nombre, PRODUCTO.codigo, count(*) as cantidad_pedidos
FROM PEDIDO, PRODUCTO, CONSTA
WHERE PEDIDO.numero = CONSTA.numero_P
AND PRODUCTO.codigo = CONSTA.codigo_Pr
GROUP BY PRODUCTO.codigo
HAVING cantidad_pedidos > 1
ORDER BY total_pedidos DESC;



CREATE VIEW query_intermedia AS
	SELECT producto.nombre, producto.codigo, count(numero) as total_pedidos
	FROM producto
	INNER JOIN consta ON codigo = codigo_pr
	INNER JOIN pedido on numero_P = numero
	GROUP BY producto.codigo
	# HAVING total_pedidos > 1
	ORDER BY total_pedidos DESC;

SELECT * 
FROM query_intermedia
WHERE total_pedidos > 1;


# Ejercicio Diapositiva 9
SELECT EMPLEADO.Nombre, CONCAT(EMPLEADO.DNI,' ',EMPLEADO.Nss) as Identificación
FROM EMPLEADO, PEDIDO, CONSTA, REPARTIDOR
WHERE EMPLEADO.DNI = PEDIDO.DNI_EP
AND PEDIDO.DNI_R = REPARTIDOR.DNI
AND PEDIDO.Numero = CONSTA.Numero_P
AND CONSTA.Codigo_Pr = '13'
AND REPARTIDOR.Nombre LIKE '%Laura%';


DROP VIEW query_aver;

CREATE VIEW query_aver AS
	SELECT empleado.nombre, CONCAT(empleado.dni," ", empleado.nss), COUNT(*) AS cantidad_pedidos FROM empleado
	INNER JOIN pedido ON empleado.dni = pedido.dni_etm
	INNER JOIN repartidor ON repartidor.dni = pedido.dni_r
	INNER JOIN consta ON pedido.numero = consta.numero_p
	WHERE repartidor.nombre LIKE "%Laura%" AND consta.codigo_pr = '13'
	GROUP BY empleado.dni;

SELECT * FROM query_aver;

SELECT * FROM empleado
INNER JOIN pedido ON empleado.dni = pedido.dni_etm
INNER JOIN repartidor ON repartidor.dni = pedido.dni_r
INNER JOIN consta ON pedido.numero = consta.numero_p
WHERE repartidor.nombre LIKE "%Laura%" AND consta.codigo_pr = '13'
GROUP BY empleado.dni;

Select empleado.Nombre,
 concat(empleado.DNI," - ",empleado.Nss) AS "DNI - N° Seguridad Social",
 count(*) AS numero_pedidos
FROM EMPLEADO, PEDIDO, CONSTA, REPARTIDOR
WHERE EMPLEADO.DNI = PEDIDO.DNI_EP
AND PEDIDO.DNI_R = REPARTIDOR.DNI
AND PEDIDO.Numero = CONSTA.Numero_P
AND Codigo_Pr = 13 
AND repartidor.Nombre like "%Laura%"
GROUP BY empleado.DNI;



# Ejercicio Diapositiva 10
SELECT P.numero AS numero_pedido,PR.nombre , PR.codigo,
EC.codigo_P_compuesto as
producto_que_lo_compone, PRODUCTO.nombre as descripción_p_que_lo_compone
FROM producto PR, pedido P, esta_compuesto EC, consta C, producto PRODUCTO
WHERE PR.codigo=EC.codigo_p AND PR.codigo=C.codigo_PR
AND P.numero=C.numero_P AND PRODUCTO.codigo= EC.codigo_p_compuesto
AND P.fecha BETWEEN '2020-09-01' AND '2020-09-30';


SELECT pedido.numero AS numero_pedido,producto.nombre , producto.codigo,
esta_compuesto.codigo_P_compuesto as
producto_que_lo_compone, PRODUCTO.nombre as descripción_p_que_lo_compone
FROM producto, pedido, esta_compuesto, consta
WHERE producto.codigo = esta_compuesto.codigo_p
AND producto.codigo = consta.codigo_PR
AND pedido.numero = consta.numero_P 
AND producto.codigo = esta_compuesto.codigo_p_compuesto
AND pedido.fecha BETWEEN '2020-09-01' AND '2020-09-30';







SELECT * 

FROM producto
INNER JOIN esta_compuesto ON producto.codigo = esta_compuesto.codigo_p
INNER JOIN consta ON consta.codigo_pr = producto.codigo
INNER JOIN pedido ON pedido.numero = consta.numero_p
WHERE nombre LIKE "%menu%"
AND pedido.fecha BETWEEN "2020-09-01" AND "2020-09-30";




SELECT * 
FROM producto, pedido, esta_compuesto, consta
WHERE producto.codigo = esta_compuesto.codigo_p
AND producto.codigo = consta.codigo_PR
AND pedido.numero = consta.numero_P; 


SELECT PR.Nombre, PR.Codigo, esta_compuesto.Codigo_P_compuesto, PRODUCTO.nombre
FROM producto PR, pedido, esta_compuesto, consta, producto PRODUCTO
WHERE PR.codigo = esta_compuesto.codigo_p
AND PR.codigo = consta.codigo_PR
AND pedido.numero = consta.numero_P
AND PRODUCTO.codigo = esta_compuesto.codigo_p_compuesto
AND pedido.Fecha BETWEEN '2020-09-01' AND '2020-09-30';


# AND PRODUCTO.CODIGO IN CODIGO_P_COMPUESTO
# AND FECHA.DATE BETWEEN '2020-09-01' AND '2020-09-30';

SELECT P.numero AS numero_pedido,
PR.nombre , PR.codigo,
EC.codigo_P_compuesto as producto_que_lo_compone,
 PRODUCTO.nombre as descripción_p_que_lo_compone
FROM producto PR, pedido P, esta_compuesto EC, consta C, producto PRODUCTO
WHERE PR.codigo=EC.codigo_p AND PR.codigo=C.codigo_PR
AND P.numero=C.numero_P AND PRODUCTO.codigo= EC.codigo_p_compuesto
AND P.fecha BETWEEN '2020-09-01' AND '2020-09-30';

select * from empleado;

select * from pedido;

INSERT INTO RANKING_PRODUCTOS
SELECT PR.codigo, PR.Nombre, SUM(C.cantidad) as Total_de_pedidos
FROM PRODUCTO PR, consta C
WHERE PR.Codigo = C.Codigo_Pr
GROUP BY C.Codigo_Pr
ORDER BY 3 DESC;