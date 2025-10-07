/*
Master Cocina 
restaurante < razon_social (PK), fundacion, cant_estrellas> maestro <nombre (PK), restaurante (PK, FK), fecha_nac, tiempo_profesional> 
participante < apodo (PK), edad, ciudad, maestro (PK, FK), restaurante(PK,FK)>  
programa < numero (PK), fecha, hora_inicio, grabacion>
plato < plato (PK), apodo (PK, FK), nombre (PK, FK),  razon_social (PK, FK), tipo, es_vegano, numero(FK)>

donde:
a. edad, numero, grabacion, tiempo_profesional y cant_estrellas son enteros.
b. fecha es dia, mes y año (YYYY/MM/DD).
c. hora_inicio es hora y minuto.  
d. es_vegano es un booleano. 
e. fecha_nac y fundacion son un instante en el tiempo. Los demás atributos son cadenas de texto. 
*/

create table restaurante (
	razon_social varchar(255) PRIMARY KEY,
	fundacion varchar(225),
	cant_estrellas INTEGER
);

create table maestro (
	nombre varchar(255),
	razon_social varchar(255), --restaurante
	fecha_nac date,
	tiempo_profesional INTEGER,
	constraint maestro_pk PRIMARY KEY (nombre, razon_social),
	constraint maestro_fk FOREIGN KEY (razon_social) references restaurante (razon_social)
);


create table participante (
	apodo varchar(255),
	edad INTEGER,
	ciudad varchar(255),
	nombre varchar(255), 
	razon_social varchar(255), --restaurante
	constraint participante_pk PRIMARY KEY ( apodo, nombre, razon_social),
	constraint maestro_participante_fk FOREIGN KEY ( nombre, razon_social) REFERENCES maestro(nombre, razon_social)
);

create table programa (
	numero INTEGER PRIMARY KEY,
	fecha date,
	hora_inicio TIMESTAMP, 
	grabacion INTEGER
);

create table plato (
	plato varchar(255),
	apodo varchar(255),
	nombre varchar(255),
	razon_social varchar(255),
	tipo varchar(255),
	es_vegano BOOLEAN,
	numero INTEGER,
	constraint plato_pk PRIMARY KEY (plato, apodo, razon_social),
	constraint participante_plato_fk FOREIGN KEY (nombre, razon_social, apodo) references participante( nombre, razon_social , apodo),
	constraint programa_plato_fk FOREIGN KEY (numero) references programa(numero)
);
