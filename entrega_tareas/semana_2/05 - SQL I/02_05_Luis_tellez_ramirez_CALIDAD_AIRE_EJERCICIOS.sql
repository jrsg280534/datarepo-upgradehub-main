# Ejercicio 1
select distinct nombre
from estacion inner join medicion on estacion.id = medicion.idestacion
where medicion.tipoContaminante = 'NO2';

SELECT nombre
FROM estacion, tipocontaminante
WHERE tipoContaminante="NO2";

# Ejercicio 2
select count(*) 
from (
	select distinct idestacion, tipocontaminante
	from Medicion 
	where tipoContaminante = 'NO2') as TablaDerivada;


select count(*) 
from estacion, tipocontaminante
where tipocontaminante = 'NO2';


# Ejercicio 3
select count(*), tipoContaminante
from(
select distinct medicion.idestacion, medicion.tipoContaminante
from Medicion) as Tabla_derivada
group by tipoContaminante;


# Ejercicio 4
select * 
from medicion inner join estacion on estacion.id = medicion.idEstacion
where medicion.fecha = '2021-05-03' and medicion.tipoContaminante = 'NO2'
order by medicion.hora asc;


# Ejercicio 5
# Modificamos el Ejercicio 1
select distinct nombre
from estacion inner join medicion on estacion.id = medicion.idestacion
where medicion.tipoContaminante = 'SH2';


# Ejercicio 6
# Modificamos el Ejercicio 5
select medicion.fecha, estacion.nombre, avg(valor) as media_valor 
from estacion inner join medicion on estacion.id = medicion.idestacion
where medicion.tipoContaminante = 'SH2'
group by medicion.fecha, estacion.nombre;

# select medicion.fecha, avg(valor) 
# from estacion inner join medicion on estacion.id = medicion.idestacion
# where medicion.tipoContaminante = 'SH2'
# group by medicion.fecha;




# Ejercicio 7
# Modificamos el Ejercicio 6
select medicion.fecha, estacion.nombre, avg(valor) 
from estacion inner join medicion on estacion.id = medicion.idestacion
where medicion.tipoContaminante = 'SH2'
group by medicion.fecha, estacion.nombre
having avg(valor) > 10;


# Ejercicio 8
select estacion.nombre, medicion.valor, medicion.tipocontaminante, tip.unidad
from estacion inner join medicion on estacion.id = medicion.idestacion
inner join tipocontaminante tip on tip.tipoContaminante = medicion.tipoContaminante
where Medicion.fecha = '2021-05-03';