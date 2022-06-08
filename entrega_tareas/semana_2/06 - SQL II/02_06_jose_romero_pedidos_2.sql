-- Obtener el código, nombre y precio de los productos(estos dos últimos en el mismo
-- campo) que están contenidos en los pedidos que ha tomado nota "Luis" o "María
-- Luisa". Ordena el listado de mayor a menor valor por fecha del pedido.

SELECT codigo, CONCAT(producto.nombre,', ',precio)
FROM producto INNER JOIN consta ON codigo = codigo_pr
INNER JOIN pedido ON numero_p = numero
INNER JOIN empleado ON empleado.dni = pedido.dni_etm
WHERE empleado.nombre LIKE "%Luis%"
ORDER BY dni_etm DESC;

-- Obtener por cada repartidor, su nombre, cantidad de pedidos y el tiempo medio
-- que tardan en entregar los pedidos una vez preparados. Ordenar el listado el
-- tiempo medio que tardan en entregarlos
SELECT repartidor.nombre, AVG(TIMEDIFF(hora_rep,hora_pre)) AS tiempo_medio_preparacion, COUNT(numero) as pedidos
FROM pedido INNER JOIN repartidor ON repartidor.dni = pedido.dni_r GROUP BY repartidor.dni ORDER BY AVG(TIMEDIFF(hora_rep,hora_pre));
-- Obtener un listado obteniendo el código, nombre y el precio de los productos
-- cuyo precios sea el más barato o el más caro de todos.
 SELECT * FROM PRODUCTO WHERE precio = (select max(precio) from producto) OR precio = (select min(precio) from producto);
-- Obtener por cada producto , el nombre y código el número total de pedidos en
-- los que se encuentra teniendo en cuenta que el total de pedidos en los cuales se
-- encuentre sea superior o igual a dos. Ordena el listado de mayor a menor
-- número de productos.
SELECT producto.nombre, producto.codigo, count(numero) as total_de_pedidos
FROM producto
INNER JOIN consta ON codigo = codigo_pr 
INNER JOIN pedido on numero_P = numero 
GROUP BY producto.codigo
HAVING count(numero) >= 2
ORDER BY numero DESC;
-- Mostrar listado de los empleados (código y NSS en la misma columna) que
-- han tomado nota de algún pedido y contienen el producto de código 13 y
-- además el repartidor sea 'Laura'.
SELECT EMPLEADO.Nombre, CONCAT(EMPLEADO.DNI,' ',EMPLEADO.Nss) as Identificación
FROM EMPLEADO, PEDIDO, CONSTA, REPARTIDOR
WHERE EMPLEADO.DNI = PEDIDO.DNI_EP
AND PEDIDO.DNI_R = REPARTIDOR.DNI
AND PEDIDO.Numero = CONSTA.Numero_P
AND CONSTA.Codigo_Pr = '13'
AND REPARTIDOR.Nombre LIKE '%Laura%';
-- Obtener el nombre del producto que es menú junto con el código de los
-- productos que lo componen en aquellos pedidos del mes de septiembre de
-- 2020.
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
SELECT * FROM EMPLEADO;
---------------------------------------------------------------------------------------
-- El pedido con número 010 se la ha asignado el repartidor 11245621Q y se ha sido entregado a la hora
-- 22:20:45.
-- Modifica los datos en la tabla correspondiente
SELECT * FROM PEDIDO;
-- El producto fruta (17) está agotado, por favor borrar de la tabla correspondiente
SELECT * FROM PRODUCTO;
-- Incrementar un 10% el importe de todos los pedidos que se han realizado en el mes de Noviembre de
-- 2020.(Debes hacerlo con una única sentencia)
UPDATE PEDIDO SET Importe = Importe * 1.1 WHERE Fecha between '2020-11-01' and
'2020-11-30';
-- Eliminar los pedidos cuyo tiempo de reparto ha sido de 25 minutos o más (desde que éstos estaban
-- preparados) y además estaban asignados al repartidor de nombre Alejandro Pardo López. (Debes hacerlo
-- con una única sentencia).
DELETE FROM PEDIDO WHERE MINUTE(TIMEDIFF(HORA_REP,HORA_PRE))>=25 AND DNI_R
= (SELECT DNI FROM REPARTIDOR WHERE NOMBRE='Alejandro Pardo López');

UPDATE repartidor set incentivo = incentivo +50 WHERE dni in (SELECT dni_r FROM
tarea5_bd2021.pedido group by dni_r having count(dni_r)>=2)

INSERT INTO PEDIDOS_FINALIZADOS SELECT *, TIMEDIFF(Hora_rep ,Hora_tm) FROM PEDIDO
WHERE Hora_rep IS NOT NULL;

