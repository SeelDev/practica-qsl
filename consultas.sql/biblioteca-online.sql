-- Modifique la relación “ejemplar” agregando como atributo el año de la Edición. 
Alter table ejemplar ADD Column  anioEdicion TIMESTAMP;

--Modifique la relación “socio” agregando un atributo que permita guardar el domicilio del Socio. 
ALTER TABLE socio ADD COLUMN domicilio text;

--Actualice la relación “socio” incrementando en 10 pesos el monto de la cuota. 

UPDATE socio
SET monto_cuota = monto_cuota + 10;

ALTER TABLE nacionalidad alter COLUMN nacionalidad type varchar(255);

INSERT INTO nacionalidad (nombre_pais, nacionalidad) VALUES ('Colombia', 'Colombiana');

UPDATE socio
SET pais = 'Mexico'
where cod_socio = 03;

UPDATE socio
SET pais = 'Colombia'
where cod_socio = 54;



DELETE
from nacionalidad
where nacionalidad = 'Peruana'


DELETE 
FROM ejemplar
where cod_ejemplar = 98;


DELETE 
FROM ejemplar
where cod_ejemplar = 223;




--Obtener la duración (en cantidad de días) de cada préstamo. 
Select * , ( fecha_devolucion - fecha_prestamo ) AS duracion_dias from prestamo 
  
/*
Calcular cuánto paga cada socio por año, 
sabiendo que la matrícula se paga una vez 
al año y la cuota es mensual. */

Select (monto_cuota * 12  + matricula) AS pago_anual_couta
from socio 



