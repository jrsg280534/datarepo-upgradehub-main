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

SELECT repartidor.nombre, count(*) as cantidad_repartos,
TIME_FORMAT(AVG(TIMEDIFF(Hora_rep, Hora_pre)),'%T') AS tiempo_entrega
FROM repartidor INNER JOIN pedido on repartidor.DNI = pedido.DNI_R
GROUP BY repartidor.DNI
ORDER BY tiempo_entrega;

select Codigo, Nombre, Precio
from producto
where Precio = (select max(Precio) from producto)
or Precio = (select min(Precio) from producto);

SELECT nombre, codigo, COUNT(*) AS cantidad_pedidos FROM producto
INNER JOIN consta ON producto.codigo = consta.codigo_pr
INNER JOIN pedido ON pedido.numero = consta.numero_p
GROUP BY codigo_pr
HAVING cantidad_pedidos > 1
ORDER BY numero DESC;



SELECT CONCAT(EMPLEADO.NOMBRE,EMPLEADO.NSS)
FROM EMPLEADO, PEDIDO, CONSTA, REPARTIDOR
WHERE EMPLEADO.DNI = PEDIDO.DNI_EP
AND PEDIDO.DNI_R = REPARTIDOR.DNI
AND PEDIDO.NUMERO = CONSTA.NUMERO_P
AND CONSTA.CODIGO_Pr ='13'
AND REPARTIDOR.NOMBRE like '%LAURA%';

