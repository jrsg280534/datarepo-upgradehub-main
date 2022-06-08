SELECT * FROM producto;

 

SELECT numero, dni_r, hora_rep FROM pedido WHERE hora_rep > '19:00' AND hora_rep IS NOT null;

 

SELECT * FROM empleado WHERE salario >= 900 AND salario <= 1000 AND salario IS NOT null;

 

-- SELECT * FROM empleado WHERE salario (900,1000);

 

SELECT * FROM empleado WHERE salario BETWEEN 900 AND 1000;

 

SELECT numero, importe FROM pedido WHERE fecha BETWEEN '2020-11-01' AND '2020-11-30' AND importe > 15;

 

SELECT * FROM pedido WHERE fecha = '2020-09-25';

 

SELECT DNI_R, COUNT(*) AS TOTAL_PEDIDOS_REPARTIDOS FROM pedido WHERE dni_R IS NOT null GROUP BY dni_R;

 

-- SELECT dni_r,COUNT(*) AS total_pedidos from pedidos_finalizados WHERE dni_r IS NOT null GROUP BY dni_r;

 

-- SELECT DNI, Nombre, Count(*) AS PEDIDOS_REPARTIDOS FROM repartidor inner join pedido on repartidor.DNI= pedido.DNI_R;
SET lc_time_names = 'es_ES';
SELECT dayname(fecha) as Dia, COUNT(Numero) as Cant_pedidos FROM PEDIDO P 
WHERE P.Numero and fecha IS NOT NULL GROUP BY DAYNAME(fecha);

 

SELECT CONCAT(DNI,', ', Nombre) as Identificación_completa FROM EMPLEADO  WHERE Turno
IN ('tarde','noche') ORDER BY dni;

 

SELECT * FROM producto WHERE precio >= (SELECT AVG(precio) FROM producto) ORDER BY precio ASC;

 

-- SELECT * nombre, codigo, precio FROM producto WHERE precio >= (SELECT VG(precio) FROM producto)ORDER BY precio DESC

 

SELECT nombre, dni FROM EMPLEADO WHERE dni NOT IN (SELECT DISTINCT
dni_EP FROM PEDIDO);

 

SELECT nombre, dni FROM empleado LEFT JOIN pedido ON empleado.dni = pedido.dni_ep WHERE pedido.dni_ep IS null;

 

-- SELECT dni,Nombre FROM empleado LEFT JOIN pedido ON empleado.DNI = pedido.DNI_EP WHERE pedido.Numero IS NULL;
 