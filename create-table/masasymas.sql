create table local_masas(
	ciudad varchar(255) NOT NULL,
	legajo_gerente INTEGER,
	cant_pisos INTEGER CHECK (cant_pisos > 0 ),
	horario_cierre timestamp NOT NULL,
	constraint local_masas_pk PRIMARY KEY (ciudad, legajo_gerente)
);

create table factura (
	nombre varchar(255) NOT NULL,
	gusto varchar(255), 
	peso INT CHECK (peso < 10 ) ,
	ancho INT NOT NULL,
	alto INT NOT NULL,
	tiene_crema BOOLEAN, 
	tiene_dll BOOLEAN,
	constraint factura_pk PRIMARY KEY (nombre, gusto)
);

create table pedido (
	cliente varchar(255) NOT NULL,
	nro_pedido INT not null,
	total_final float ,
	IVA float check ( IVA between 0 and 95.5),
	fentrega_estimada date,
	senia integer, 
	constraint pedido_pk PRIMARY KEY (cliente, nro_pedido)
);

create table incluye (
	nombre varchar(255) not null,
	gusto varchar(255),
	cliente varchar(255) NOT NULL,
	nro_pedido INT not null,
	constraint incluye_pk PRIMARY KEY (nombre, gusto, cliente, nro_pedido),
	constraint factura_incluye_fk FOREIGN KEY (nombre, gusto) references factura(nombre, gusto),
	constraint pedido_incluye_fk FOREIGN KEY (cliente, nro_pedido) references pedido(cliente, nro_pedido)
);

create table entrega (
	cliente varchar(255) NOT NULL,
	nro_pedido INT not null,
	ciudad varchar(255) NOT NULL, 
	legajo_gerente integer,
	fentrega_pedido date,
	constraint entrega_pk PRIMARY KEY (cliente, nro_pedido, ciudad, legajo_gerente),
	constraint pedido_entrega_fk FOREIGN KEY (cliente, nro_pedido) references pedido(cliente, nro_pedido),
	constraint local_masas_entrega_fk FOREIGN KEY (ciudad, legajo_gerente) references local_masas(ciudad, legajo_gerente)
);

