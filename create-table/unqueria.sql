create table comiqueria(
	nombre_comiqueria varchar(255) PRIMARY KEY,
	forma_contributiva varchar(255) check (forma_contributiva = ' Esquema Piramidal' or forma_contributiva = 'monotributo' or forma_contributiva = ' cooperativa' or forma_contributiva = 'empresa'),
	ciudad varchar(255),
	direccion varchar(255),
	piso int ,
	local varchar(255),
	constraint nombre_comiqueria_unico UNIQUE (nombre_comiqueria)
);

create table editorial (
	nombre_editorial varchar(255) PRIMARY KEY,
	jefe varchar(255),
	nro_empleados int,
	al_dia_con_afip BOOLEAN
);

create table comic (
	nombre varchar(255) not null,
	tomo int not null,
	demografia varchar(255) check (demografia = ' shonen' and demografia = 'shoujo' and demografia = 'josei'),
	origen varchar(255),
	nombre_editorial varchar(255) ,
	constraint comic_pk PRIMARY KEY (nombre, tomo),
	constraint editorial_comic_fk FOREIGN KEY (nombre_editorial) references editorial(nombre_editorial)
);

create table venta(
	nombre varchar(255) not null,
	tomo int not null, 
	nombre_comiqueria varchar(255),
	fecha date,
	cantidad_comprada int,
	forma_pago varchar(255),
	constraint venta_pk PRIMARY KEY (nombre, tomo, nombre_comiqueria, fecha),
	constraint comic_venta_fk FOREIGN KEY (nombre, tomo) references comic(nombre, tomo),
	constraint comiqueria_venta_fk FOREIGN KEY (nombre_comiqueria) references comiqueria(nombre_comiqueria)
);

