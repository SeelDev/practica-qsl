create table protector (
	pasaporte varchar(255) PRIMARY KEY,
	altura INTEGER,
	peso INTEGER
);


CREATE table herramienta (
	nombre varchar(255),
	poder INTEGER,
	origen varchar(255),
	pasaporte varchar(255),
	constraint protector_herramienta_fk FOREIGN KEY (pasaporte) references protector(pasaporte)
);

create table ciudad (
	nombre_ciudad varchar(255) PRIMARY KEY,
	ubicacion varchar(255),
	poblacion INTEGER
);

create table protege (
	nombre_ciudad varchar(255),
	pasaporte varchar(255),
	fecha date,
	fue_exitoso BOOLEAN,
	constraint protege_pk PRIMARY KEY (nombre_ciudad, pasaporte, fecha),
	constraint ciudad_protege_fk FOREIGN KEY (nombre_ciudad) references ciudad(nombre_ciudad),
	constraint protector_protege_fk FOREIGN KEY (pasaporte) references protector(pasaporte)
);
