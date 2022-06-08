SELECT * FROM PRODUCTO;

SELECT numero, dni_r, hora_rep FROM pedido WHERE hora_rep > '19:00' AND hora_rep IS NOT null;

SELECT * FROM empleado HAVING salario >=900 AND salario <= 1000 AND salario IS NOT null;

-- SELECT * FROM empleado WHERE salario (900,1000);

SELECT * FROM empleado WHERE salario BETWEEN 900 AND 1000;

SELECT numero, importe FROM pedido WHERE fecha BETWEEN '2020-11-01' AND '2020-11-30' AND importe > 15;

SELECT DNI_R, COUNT(*) AS TOTAL_PEDIDOS_REPARTIDOS FROM pedido WHERE dni_R IS NOT null GROUP BY dni_R;

SET lc_time_names = 'es_ES';
SELECT MONTHNAME(fecha) as Mes, COUNT(Numero) as Cant_pedidos FROM PEDIDO P
WHERE P.Numero and fecha IS NOT NULL GROUP BY MONTH(fecha);

SELECT CONCAT(DNI,', ', Nombre) as Identificación_completa FROM EMPLEADO WHERE Turno
IN ('tarde','noche') ORDER BY dni DESC;

SELECT * FROM producto
WHERE precio >= (select AVG(precio) FROM producto)
ORDER BY precio DESC;

select nombre, dni FROM EMPLEADO WHERE dni NOT IN (SELECT DISTINCT Dni_EP FROM PEDIDO);
SELECT nombre, dni FROM empleado LEFT JOIN pedido on empleado.dni=pedido.dni_ep WHERE pedido.dni_ep IS null;



