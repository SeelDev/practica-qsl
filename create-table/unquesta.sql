create table alumno (
	legajo INT PRIMARY KEY not null,
	nombre varchar(255),
	dni varchar(255),
	telefono varchar(10),
	fecha_nacimiento date
);

create table comision(
	numero int not null,
	materia varchar(255) not null,
	nombre_profesor varchar(255) ,
	constraint comision_pk PRIMARY KEY (numero, materia),
	constraint profesor_unico UNIQUE (nombre_profesor)
);

create table pregunta (
	consigna varchar(255),
	numero int not null,
	materia varchar(255) not null,
	tema varchar(255) CHECK (tema = 'Matematica' and tema = 'Lengua' and tema = 'geografia' and tema ='Historia'),
	dificultad int check (dificultad between 0 and 10),
	constraint pregunta_pk PRIMARY KEY  (consigna, numero, materia),
	constraint comision_pregunta_fk FOREIGN KEY (numero, materia) references comision (numero, materia)
);

create table respuesta (
	legajo int not null, 
	consigna varchar(255),
	numero int not null,
	materia varchar(255) not null,
	opcion int,
	puntaje decimal check (puntaje between 0 and 100),
	legajo_docente int,
	constraint respuesta_pk PRIMARY KEY (legajo, consigna, numero, materia, legajo_docente),
	constraint alumno_respuesta_fk FOREIGN KEY (legajo) references alumno(legajo),
	constraint pregunta_respuesta_fk FOREIGN KEY (consigna, numero, materia) references pregunta(consigna, numero, materia)
);
