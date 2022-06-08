-- 1 Obtener el listado de todos los productos

select distinct Nombre
from pedidos.producto;

-- 2 Obtener el número de pedido, dni del repartidor y hora de reparto de aquellos pedidos que se toman nota después de las siete de la tarde.

SELECT Numero, DNI_R, hora_rep
FROM pedido
WHERE hora_rep > ("19:00:00") and Hora_rep IS NOT NULL;

-- 3 Obtener todos los campos de empleados que cobran entre 900 y 1000 euros

SELECT DNI,Nombre,Salario
From empleado
Where Salario >= 900 and Salario <= 1000 AND Salario IS NOT NULL;

-- 4 Obtener el número de pedido e importe de aquellos que han sido registrados en el mes de noviembre de 2020 y su importe es mayor a 15 Euros.

SELECT Numero,Importe,Fecha
FROM pedido
Where Importe > 15 AND Importe IS NOT NULL	
AND Fecha BETWEEN "2020-11-01" AND "2020-11-30";

-- 5 Obtener por cada uno de los repartidores su DNI junto a la cantidad de pedidos entregados.
SELECT DNI_R, COUNT(*) AS TOTAL_PEDIDOS_REPARTIDOS 
FROM pedido WHERE dni_R IS NOT null GROUP BY dni_R;

-- 6 obtener por cada mes (con el formato de nombre y no de número ej. Noviembre),la cantidad de pedidos realizados.
SET lc_time_names = "es_Es";
SELECT MONTHNAME(fecha) AS Día, count(*) as Cantidad_Pedidos
FROM pedido
WHERE fecha IS NOT null GROUP BY monthname(fecha);

-- 7 Obtener un listado con el nombre y dni de los empleados en el mismo campo y anteponiendo el dni al nombre de la siguiente forma (ej; 45776633P, Juan Rodríguez López) 
-- que tenga turno de “tarde” o "noche". Ordenar el listado por dni.
SELECT concat(DNI," , ",Nombre) As "DNI - NOMBRE", Turno
FROM empleado
Where turno="tarde" Or turno="noche"
order by DNI;

-- 8 Obtener el nombre, código y precio de aquellos productos que superen o igualen la media de todos los precios. Ordenar de mayor a menor precio.

SELECT Nombre, codigo, precio
From producto
where Precio>=
(SELECT AVG (Precio) 
FROM Producto)
ORDER BY Precio desc;

-- 9 Obtener un listado con el nombre y DNI de los empleados que no han preparado nunca ningún pedido.
SELECT dni,Nombre
From empleado 
left join Pedido
On empleado.DNI=pedido.DNI_EP
WHERE Numero Is NULL;

-- 10 Obtener el código, nombre y precio de los productos(estos dos últimos en el mismo 
-- campo) que están contenidos en los pedidos que ha tomado nota "Luis" o "María Luisa".
-- Ordena el listado de mayor a menor valor por fecha del pedido.

Select producto.codigo, concat(empleado.nombre," - ",producto.precio) as "Nombre - Precio"
From pedido
join empleado on pedido.DNI_ETM=empleado.DNI
join consta On pedido.Numero=consta.Numero_P
join producto on consta.Codigo_Pr=producto.Codigo
WHERE empleado.Nombre Like "%Luis%" or "%María Luisa%";

-- 11 0Obtener por cada repartidor, su nombre, cantidad de pedidos y el tiempo medio 
-- que tardan en entregar los pedidos una vez preparados. Ordenar el listado el 
-- tiempo medio que tardan en entregarlos

SELECT repartidor.nombre as "Nombre Repartidor" , COUNT(*) as "Numero de Pedidos", TIME_FORMAT(AVG(TIMEDIFF(hora_rep,hora_pre)),"%T") AS "Tiempo medio preparacion"
FROM pedido INNER JOIN repartidor ON repartidor.dni = pedido.dni_r 
GROUP BY repartidor.dni;

-- 12 obtener un listado obteniendo el código, nombre y el precio de los productos cuyos precios sea el más barato o el más caro de todos

Select Codigo,nombre,precio
From producto
where precio = (
select max(precio) from producto)
or precio = (select min(precio) from producto)
order by precio desc;

-- 13 obtener por cada producto , el nombre y código el número total de pedidos en los que se encuentra teniendo en cuenta que el total de pedidos en los cuales se 
-- encuentre sea superior o igual a dos. Ordena el listado de mayor a menor número de productos.
-- Codigo,producto.Nombre

Select nombre, codigo, COUNT(*) AS cantidad_pedidos
from pedido
join consta on pedido.Numero=consta.Numero_P
join producto on consta.Codigo_Pr=producto.Codigo
group by Codigo_Pr
having cantidad_pedidos > 1
Order by Cantidad desc;

-- 14 Mostrar listado de los empleados (código y NSS en la misma columna) que 
-- han tomado nota de algún pedido y contienen el producto de código 13 y 
-- además el repartidor sea 'Laura'.

Select empleado.Nombre, concat(empleado.DNI," - ",empleado.Nss) AS "DNI - N° Seguridad Social", count(*) AS numero_pedidos
From empleado
join pedido ON empleado.dni=pedido.DNI_ETM
join consta on pedido.Numero=consta.Numero_P
join producto on consta.Codigo_Pr=producto.Codigo
join repartidor on pedido.DNI_R=repartidor.DNI
WHERE Codigo_Pr=13 AND repartidor.Nombre like "%Laura%"
GROUP BY empleado.DNI;


-- 15. Obtener el nombre del producto que es menú junto con el código de los 
-- productos que lo componen en aquellos pedidos del mes de septiembre de 
-- 2020

SELECT producto.Nombre,producto.Codigo,Codigo_P_compuesto
FROM producto
INNER JOIN esta_compuesto ON producto.codigo = esta_compuesto.codigo_p
INNER JOIN consta ON consta.codigo_pr = producto.codigo
INNER JOIN pedido ON pedido.numero = consta.numero_p
WHERE nombre LIKE "%menú%"
AND pedido.fecha BETWEEN "2020-09-01" AND "2020-09-30";

-- 16. Insertar un nuevo registro en la tabla EMPLEADOS con los siguientes datos:
-- DNI:98567432x
-- Nombre: Luis Fernández Cáceres
-- Nss:09809809822
-- Turno: tarde Salario:850

INSERT INTO empleado
  (DNI,Nombre,Nss,Turno,Salario)
  VALUES ('98567432x','Luis Fernández Cáceres','09809809822','tarde','850');

-- 17. El pedido con número 010 se la ha asignado el repartidor 11245621Q y se ha sido entregado a la hora 
-- 22:20:45.
-- Modifica los datos en la tabla correspondiente

SELECT *
FROM pedido;

-- El producto fruta (17) está agotado, por favor borrar de la tabla correspondiente
Select * 
From producto;

-- Insertar los siguientes datos en la tabla PEDIDO teniendo en cuenta que debes insertar sólo los valores 
-- necesarios en los campos correspondientes

Select *
From pedido;
