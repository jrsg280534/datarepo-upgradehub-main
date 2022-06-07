-- 1 Generar una lista de las estaciones que estudien el tipo de contaminante NO2
SELECT nombre
FROM estacion,tipocontaminante
WHERE tipoContaminante="NO2";

-- 2 Hallar el número de estaciones para el tipo de contaminante NO2
SELECT count(nombre)
FROM estacion,tipocontaminante
WHERE tipoContaminante="NO2";

-- 3 Detallar el número de estaciones por tipo de contaminante
select count(*), tipoContaminante
from(
select distinct medicion.tipoContaminante,medicion.idestacion
from Medicion) as Tabla_derivada
group by tipoContaminante;

-- Ejercicio 4
select *
from medicion inner join estacion on estacion.id = medicion.idEstacion
where medicion.fecha = '2021-05-03' and medicion.tipoContaminante = 'NO2'
order by medicion.hora asc;

-- 5 Mostrar el nombre de las estaciones que tengan mediciones para el contaminante SH2(Sulfuro de Hidrógeno)
select distinct nombre
from estacion inner join medicion on estacion.id = medicion.idestacion
where medicion.tipoContaminante = 'SH2';

-- Ejercicio 6
select medicion.fecha, estacion.nombre, avg(valor)
from estacion inner join medicion on estacion.id = medicion.idestacion
where medicion.tipoContaminante = 'SH2'
group by medicion.fecha, estacion.nombre;

-- Ejercicio 7
select medicion.fecha, estacion.nombre, avg(valor)
from estacion inner join medicion on estacion.id = medicion.idestacion
where medicion.tipoContaminante = 'SH2'
group by medicion.fecha, estacion.nombre
having avg(valor) >10;

-- 8 Mostrar el nombre de la estación, valor, tipo de contaminante y unidad de las mediciones realizadas el 03/05/2021
select estacion.nombre, medicion.valor, medicion.tipocontaminante, tip.unidad
from estacion inner join medicion on estacion.id = medicion.idestacion
inner join tipocontaminante tip on tip.tipoContaminante = medicion.tipoContaminante
where Medicion.fecha = '2021-05-03';




