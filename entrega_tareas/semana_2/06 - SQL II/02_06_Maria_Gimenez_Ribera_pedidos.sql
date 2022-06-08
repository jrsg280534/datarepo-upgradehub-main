-- Obtener el listado de todos los productos
SELECT nombre FROM producto;
SELECT nombre, precio FROM producto;

-- Obtener el número de pedido, dni del repartidor y hora de reparto de aquellos
-- pedidos que se toman nota después de las siete de la tarde.
SELECT numero, dni_r, hora_rep FROM pedido WHERE hora_rep > "19:00" AND hora_rep IS NOT null;
SELECT numero, dni_r, hora_rep FROM pedido HAVING hora_rep > "19:00" AND hora_rep IS NOT null;


-- Obtener todos los campos de empleados que cobran entre 900 y 1000 euros.
SELECT * FROM empleado WHERE salario BETWEEN 900 AND 1000 AND salario IS NOT null;
SELECT * FROM empleado HAVING salario BETWEEN 900 AND 1000 AND salario IS NOT null;


-- Obtener el número de pedido e importe de aquellos que han sido registrados en el
-- mes de noviembre de 2020 y su importe es mayor a 15 Euros.
SELECT numero, importe FROM pedido WHERE importe > 15.00 AND fecha BETWEEN "2020-11-01" AND "2020-11-30"; 

-- Obtener por cada uno de los repartidores su DNI junto a la cantidad de pedidos entregados.
SELECT dni_r, COUNT(*) AS total_pedidos FROM pedido WHERE dni_r IS NOT null GROUP BY dni_r;

-- Obtener por cada mes (con el formato de nombre y no de número ej. Noviembre),la cantidad
-- de pedidos realizados.
SELECT EXTRACT(MONTH FROM fecha), COUNT(*) AS pedidos_por_mes FROM pedido WHERE fecha IS NOT null GROUP BY EXTRACT(MONTH FROM fecha);
SELECT MONTHNAME(fecha) AS mes, COUNT(*) AS pedidos_por_mes FROM pedido WHERE fecha IS NOT null GROUP BY MONTHNAME(fecha);

-- Obtener un listado con el nombre y dni de los empleados en el mismo campo y
-- anteponiendo el dni al nombre de la siguiente forma (ej; 45776633P, Juan Rodríguez López)
-- que tenga turno de “tarde” o "noche". Ordenar el listado por dni.
SELECT CONCAT(dni,", " ,nombre) AS dni_con_nombre, turno 
FROM repartidor WHERE turno = "tarde" OR turno = "noche" ORDER BY dni;

SELECT CONCAT(dni,", " ,nombre) AS dni_con_nombre, turno 
FROM repartidor WHERE turno IN ("tarde","noche") ORDER BY dni DESC;

-- Obtener el nombre, código y precio de aquellos productos que superen o igualen
-- la media de todos los precios. Ordenar de mayor a menor precio.
SELECT nombre, codigo, precio FROM producto 
WHERE precio > (SELECT AVG(precio) FROM producto) 
ORDER BY precio DESC;

-- Obtener un listado con el nombre y DNI de los empleados que no han preparado
-- nunca ningún pedido.
SELECT nombre, dni 
FROM empleado LEFT JOIN pedido 
ON empleado.dni = pedido.dni_ep
WHERE numero IS null;

SELECT nombre, dni FROM EMPLEADO 
WHERE dni 
NOT IN (SELECT DISTINCT dni_EP FROM PEDIDO);
 
SELECT nombre, dni FROM empleado LEFT JOIN pedido ON empleado.dni = pedido.dni_ep WHERE pedido.dni_ep IS null;

-- Obtener el código, nombre y precio de los productos(estos dos últimos en el mismo
-- campo) que están contenidos en los pedidos que ha tomado nota "Luis" o "María
-- Luisa". Ordena el listado de mayor a menor valor por fecha del pedido.

SELECT codigo, CONCAT(producto.nombre,', ',precio) 
FROM producto INNER JOIN consta ON codigo = codigo_pr 
INNER JOIN pedido ON numero_p = numero
INNER JOIN empleado ON empleado.dni = pedido.dni_etm
WHERE empleado.nombre LIKE "%Luis%"
ORDER BY fecha DESC;

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
SELECT repartidor.nombre, TIME_FORMAT(AVG(TIMEDIFF(hora_rep,hora_pre)),"%T") AS tiempo_medio_preparacion, COUNT(*)
FROM pedido INNER JOIN repartidor ON repartidor.dni = pedido.dni_r 
GROUP BY repartidor.dni
ORDER BY tiempo_medio_preparacion;

-- Obtener un listado obteniendo el código, nombre y el precio de los productos
-- cuyo precios sea el más barato o el más caro de todos.
select Codigo, Nombre, Precio
from producto
where Precio = (select max(Precio) from producto)
or Precio = (select min(Precio) from producto);

-- Obtener por cada producto , el nombre y código el número total de pedidos en
-- los que se encuentra teniendo en cuenta que el total de pedidos en los cuales se
-- encuentre sea superior o igual a dos. Ordena el listado de mayor a menor
-- número de productos.

CREATE VIEW query_having AS
	SELECT nombre, codigo, COUNT(*) AS numero_pedidos FROM producto 
	INNER JOIN consta ON producto.codigo = consta.codigo_pr
	INNER JOIN pedido ON pedido.numero = consta.numero_p
	GROUP BY codigo_pr
	-- HAVING numero_pedidos > 1;
    ;
SELECT * FROM query_having WHERE numero_pedidos > 1
ORDER BY numero_pedidos DESC;

SELECT PRODUCTO.nombre, PRODUCTO.codigo, count(*) as cantidad_pedidos
FROM PEDIDO, PRODUCTO, CONSTA
WHERE PEDIDO.numero = CONSTA.numero_P
AND PRODUCTO.codigo = CONSTA.codigo_Pr
GROUP BY PRODUCTO.codigo
HAVING cantidad_pedidos > 1
ORDER BY total_pedidos DESC;

-- Mostrar listado de los empleados (dni y NSS en la misma columna) que
-- han tomado nota de algún pedido y contienen el producto de código 13 y
-- además el repartidor sea 'Laura'.
DROP VIEW query_aver;
CREATE VIEW query_aver AS
	SELECT empleado.nombre, CONCAT(empleado.dni," ", empleado.nss) AS identificadores_empleados, COUNT(*) AS cantidad_pedidos FROM empleado
	INNER JOIN pedido ON empleado.dni = pedido.dni_etm
	INNER JOIN repartidor ON repartidor.dni = pedido.dni_r
	INNER JOIN consta ON pedido.numero = consta.numero_p
    WHERE repartidor.nombre LIKE "%Laura%" AND consta.codigo_pr = "13"
	GROUP BY empleado.dni;
    
SELECT * FROM query_aver;

-- Obtener el nombre del producto que es menú junto con el código de los
-- productos que lo componen en aquellos pedidos del mes de septiembre de
-- 2020.
SELECT * FROM producto
RIGHT JOIN esta_compuesto ON producto.codigo = esta_compuesto.codigo_p
INNER JOIN consta ON consta.codigo_pr = producto.codigo
INNER JOIN pedido ON pedido.numero = consta.numero_p
WHERE nombre LIKE "%menu%"
AND pedido.fecha BETWEEN "2020-09-01" AND "2020-09-30";

SELECT PR.Nombre, PR.Codigo, esta_compuesto.Codigo_P_compuesto, PRODUCTO.nombre
FROM producto PR, pedido, esta_compuesto, consta, producto PRODUCTO
WHERE PR.codigo = esta_compuesto.codigo_p
AND PR.codigo = consta.codigo_PR
AND pedido.numero = consta.numero_P
AND PRODUCTO.codigo = esta_compuesto.codigo_p_compuesto
AND pedido.Fecha BETWEEN '2020-09-01' AND '2020-09-30';

SELECT * FROM empleado;
SELECT * FROM producto;
SELECT * FROM pedido;
SELECT * FROM consta;

SELECT * FROM pedido;
-- El pedido con número 010 se la ha asignado el repartidor 11245621Q y se ha sido entregado a la hora
-- 22:20:45.
-- Modifica los datos en la tabla correspondiente
UPDATE pedido SET Importe = Importe * 1.1 
WHERE Fecha between '2020-11-01' and '2020-11-30';
