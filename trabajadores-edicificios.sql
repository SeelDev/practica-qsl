-- Modifique la relación trabajador agregando la edad del mismo. 
ALTER TABLE trabajador ADD COLUMN edad integer

--Modifique la relación edificio agregando un atributo que permita guardar la ciudad del edificio. 

ALTER TABLE edificio ADD COLUMN ciudad varchar(255);

--Actualice la relación asignaciones incrementando en 4 los números de días en las asignaciones. 

UPDATE asignacion
SET num_dias = num_dias + 4;

-- Actualice el nivel de calidad de los edificios que son oficinas cambiando 4 por 5 y la categoría de 1 por 4. 

UPDATE edificio
SET nivel_calidad = 5, categoria = 4

WHERE tipo = 'oficina'AND nivel_calidad = 4 AND categoria = 1;

--Elimine todos los plomeros. 

-- primero lo borro de 'asignacion' -> foranea
DELETE from asignacion 
where legajo in (select legajo from trabajador where oficio = 'plomero');

delete from trabajador where oficio = ' plomero';

--Elimine los edificios que son residencias.
DELETE from asignacion 
where id_e in (select id_e from edificio where tipo = 'residencia');

delete from edificio where tipo = 'residencia'


--Nombre de los trabajadores cuya tarifa está entre 10 y 12 pesos.

SELECT t.nombre, t.tarifa FROM trabajador t
WHERE tarifa BETWEEN 10 AND 12;

--Cuáles son los oficios de los trabajadores asignados al
--edificio 435? 

SELECT DISTINCT t.oficio 
from trabajador t
JOIN asignacion a
	ON t.legajo_supv = a.legajo
WHERE a.id_e = 435;

--Nombre de los trabajadores asignados a oficinas. 

SELECT t.nombre from trabajador t 
JOIN asignacion a 
	ON t.legajo_supv = a.legajo 
JOIN edificio e
	ON a.id_e = e.id_e
WHERE e.tipo = 'oficina'

--Indicar el nombre del trabajador y el de su supervisor. 
-- Hace un join con sigo mismo renombrando el nombre de supervisor
select t.nombre as trabajador , s.nombre as supervisor FROM trabajador t
JOIN trabajador s
	ON t.legajo_supv = s.legajo;

--¿Qué trabajadores reciben una tarifa por hora mayor
--que la de su supervisor? 
select t.nombre as trabajador,
	   t.tarifa as tarifa_trabajador,
	   s.nombre as supervisor,
	   s.tarifa as tarifa_supervisor 
from trabajador t 
join trabajador s
	ON t.legajo_supv = s.legajo
WHERE t.tarifa > s.tarifa

--¿Cuál es el número total de días que se han dedicado
--a plomería en el edificio 312? 


select SUM(num_dias) as total_numero_dias from asignacion s 
JOIN trabajador t 
	ON s.legajo = t.legajo_supv
JOIN edificio e
	ON s.id_e = e.id_e
WHERE t.oficio = 'plomeria' AND e.id_e = 312

--¿Cuántos tipos de oficios diferentes hay?
-- CUENTA LOS DISTINTOS OFICIOS 
select COUNT(DISTINCT oficio) as total_oficios from trabajador

-- Para cada supervisor, ¿cuál es la tarifa por hora más
--alta que se paga a un trabajador que informa a ese 
--supervisor? 

SELECT MAX(t.tarifa) as tarifa_max_trabajador,
	   s.nombre as supervisor
from trabajador t
JOIN trabajador s 
	ON s.legajo = t.legajo_supv
GROUP BY s.nombre --ordeno por nombre si uso s.nombre

--Para cada tipo de edificio, ¿cuál es el nivel de calidad
--medio de los edificios con categoría 1? Considérense sólo
--aquellos tipos de edificios que tienen un nivel de calidad
--máximo no mayor que 3. 

SELECT e.tipo, AVG(nivel_calidad) as nivel_medio
from edificio e
WHERE categoria = 1
GROUP BY e.tipo
HAVING MAX(nivel_calidad) < 3

--¿Qué trabajadores reciben una tarifa por hora 
--menor que la del promedio? 

SELECT nombre 
FROM trabajador t
WHERE tarifa < (SELECT AVG(tarifa) from trabajador)
			-- hago este select pq en el WHERE no se 
			-- puede usar funciones de agregacion -> AVG

--¿Qué trabajadores reciben una tarifa por hora menor que 
--la del promedio de los trabajadores que tienen su mismo 
--oficio? 

SELECT nombre from trabajador t1
WHERE t1.tarifa < (SELECT AVG(tarifa) from trabajador t2 
					WHERE t1.oficio = t2.oficio) 
					
--Seleccione el nombre de los electricistas asignados al 
--edificio 435 y la fecha en la que empezaron a trabajar en él. 

SELECT t.nombre, s.id_e, s.fecha_inicio from trabajador t
JOIN asignacion s 
	ON t.legajo = s.legajo
WHERE t.oficio = 'electricista' AND s.id_e = 435

--¿Qué supervisores tienen trabajadores que tienen 
--una tarifa por hora por encima de los 12 euros? 

SELECT DISTINCT s.nombre as supervisor
from trabajador t
JOIN trabajador s 
	ON t.legajo_supv = s.legajo
WHERE t.tarifa > 12



