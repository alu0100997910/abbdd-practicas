CREATE TABLE public."Construccion" (
    numero integer NOT NULL,
    calle character varying(45) NOT NULL,
    cp integer,
    m2_solar double precision,
    fecha_construccion date,
    zona character varying(45) NOT NULL
);

CREATE TABLE public."Bloque" (
    nombre character varying NOT NULL,
    m2_totales integer,
    num_plantas integer
)
INHERITS (public."Construccion");

CREATE TABLE public."Persona" (
    dni integer NOT NULL,
    fecha_nac date,
    nombre character varying(45),
    apellidos character varying(45)
);

CREATE TABLE public."Piso" (
    planta integer NOT NULL,
    m2_vivienda integer,
    m2_comun integer,
    portal character(1) NOT NULL
)
INHERITS (public."Bloque");

CREATE TABLE public."Propietario" (
)
INHERITS (public."Persona");


CREATE TABLE public."PropietarioPiso" (
    dni integer NOT NULL,
    numero integer NOT NULL,
    zona character varying(45) NOT NULL,
    calle character varying(45) NOT NULL,
    nombre character varying(45) NOT NULL,
    planta integer NOT NULL,
    portal character(1) NOT NULL
);

CREATE TABLE public."PropietarioVivienda" (
    dni integer NOT NULL,
    numero integer NOT NULL,
    calle character varying(45) NOT NULL,
    zona character varying(45) NOT NULL
);

CREATE TABLE public."ResidePiso" (
    dni integer NOT NULL,
    numero integer,
    calle character varying(45),
    planta integer,
    portal character(1),
    zona character varying(45),
    nombre character varying(45)
);

CREATE TABLE public."ResideVivienda" (
    dni integer NOT NULL,
    numero integer,
    calle character varying(45),
    zona character varying(45)
);

CREATE TABLE public."Residente" (
)
INHERITS (public."Persona");

CREATE TABLE public."ViviendaUnifamiliar" (
    m2_construidos integer
)
INHERITS (public."Construccion");

CREATE TABLE public."Zona" (
    nombre character varying(45) NOT NULL,
    limites point[],
    extension double precision
);

COPY public."Bloque" (numero, calle, cp, m2_solar, fecha_construccion, nombre, m2_totales, num_plantas, zona) FROM stdin;
\.

COPY public."Construccion" (numero, calle, cp, m2_solar, fecha_construccion, zona) FROM stdin;
\.

COPY public."Persona" (dni, fecha_nac, nombre, apellidos) FROM stdin;
\.

COPY public."Piso" (numero, calle, cp, m2_solar, fecha_construccion, nombre, m2_totales, num_plantas, planta, m2_vivienda, m2_comun, portal, zona) FROM stdin;
\.

COPY public."Propietario" (dni, fecha_nac, nombre, apellidos) FROM stdin;
\.

COPY public."PropietarioPiso" (dni, numero, zona, calle, nombre, planta, portal) FROM stdin;
\.

COPY public."PropietarioVivienda" (dni, numero, calle, zona) FROM stdin;
\.

COPY public."ResidePiso" (dni, numero, calle, planta, portal, zona, nombre) FROM stdin;
\.

COPY public."ResideVivienda" (dni, numero, calle, zona) FROM stdin;
\.

COPY public."Residente" (dni, fecha_nac, nombre, apellidos) FROM stdin;
\.

COPY public."ViviendaUnifamiliar" (numero, calle, cp, m2_solar, fecha_construccion, m2_construidos, zona) FROM stdin;
\.

COPY public."Zona" (nombre, limites, extension) FROM stdin;
\.

ALTER TABLE ONLY public."Bloque"
    ADD CONSTRAINT "Bloque_pkey" PRIMARY KEY (numero, calle, zona, nombre);

ALTER TABLE ONLY public."Construccion"
    ADD CONSTRAINT "Construccion_pkey" PRIMARY KEY (numero, calle, zona);

ALTER TABLE ONLY public."Persona"
    ADD CONSTRAINT "Persona_pkey" PRIMARY KEY (dni);

ALTER TABLE ONLY public."Piso"
    ADD CONSTRAINT "Piso_pkey" PRIMARY KEY (numero, calle, nombre, zona, planta, portal);

ALTER TABLE ONLY public."PropietarioPiso"
    ADD CONSTRAINT "PropietarioPiso_pkey" PRIMARY KEY (dni, numero, zona, calle, nombre, planta, portal);

ALTER TABLE ONLY public."PropietarioVivienda"
    ADD CONSTRAINT "PropietarioVivienda_pkey" PRIMARY KEY (dni, numero, calle, zona);

ALTER TABLE ONLY public."Propietario"
    ADD CONSTRAINT "Propietario_pkey" PRIMARY KEY (dni);

ALTER TABLE ONLY public."ResidePiso"
    ADD CONSTRAINT "ResidePiso_pkey" PRIMARY KEY (dni);

ALTER TABLE ONLY public."ResideVivienda"
    ADD CONSTRAINT "ResideVivienda_pkey" PRIMARY KEY (dni);

ALTER TABLE ONLY public."Residente"
    ADD CONSTRAINT "Residente_pkey" PRIMARY KEY (dni);

ALTER TABLE ONLY public."ViviendaUnifamiliar"
    ADD CONSTRAINT "ViviendaUnifamiliar_pkey" PRIMARY KEY (numero, calle, zona);

ALTER TABLE ONLY public."Zona"
    ADD CONSTRAINT zona_pkey PRIMARY KEY (nombre);

ALTER TABLE ONLY public."Bloque"
    ADD CONSTRAINT "Bloque_Construccion" FOREIGN KEY (numero, calle, zona) REFERENCES public."Construccion"(numero, calle, zona);

ALTER TABLE ONLY public."Residente"
    ADD CONSTRAINT dni_persona FOREIGN KEY (dni) REFERENCES public."Persona"(dni);

ALTER TABLE ONLY public."Propietario"
    ADD CONSTRAINT dni_persona FOREIGN KEY (dni) REFERENCES public."Persona"(dni);

ALTER TABLE ONLY public."PropietarioPiso"
    ADD CONSTRAINT dni_propietario FOREIGN KEY (dni) REFERENCES public."Propietario"(dni);

ALTER TABLE ONLY public."PropietarioVivienda"
    ADD CONSTRAINT dni_propietario FOREIGN KEY (dni) REFERENCES public."Propietario"(dni);

ALTER TABLE ONLY public."ResideVivienda"
    ADD CONSTRAINT dni_residente FOREIGN KEY (dni) REFERENCES public."Residente"(dni);

ALTER TABLE ONLY public."ResidePiso"
    ADD CONSTRAINT dni_residente FOREIGN KEY (dni) REFERENCES public."Residente"(dni);

ALTER TABLE ONLY public."Piso"
    ADD CONSTRAINT piso_bloque FOREIGN KEY (zona, numero, nombre, calle) REFERENCES public."Bloque"(zona, numero, nombre, calle);

ALTER TABLE ONLY public."PropietarioPiso"
    ADD CONSTRAINT propietario_piso FOREIGN KEY (numero, zona, calle, nombre, planta, portal) REFERENCES public."Piso"(numero, zona, calle, nombre, planta, portal);

ALTER TABLE ONLY public."PropietarioVivienda"
    ADD CONSTRAINT propietario_vivienda FOREIGN KEY (numero, calle, zona) REFERENCES public."ViviendaUnifamiliar"(numero, calle, zona);

ALTER TABLE ONLY public."ResidePiso"
    ADD CONSTRAINT residente_piso FOREIGN KEY (numero, calle, planta, portal, zona, nombre) REFERENCES public."Piso"(numero, calle, planta, portal, zona, nombre);

ALTER TABLE ONLY public."ResideVivienda"
    ADD CONSTRAINT residente_vivienda FOREIGN KEY (numero, calle, zona) REFERENCES public."ViviendaUnifamiliar"(numero, calle, zona);

ALTER TABLE ONLY public."ViviendaUnifamiliar"
    ADD CONSTRAINT vivienda_construccion FOREIGN KEY (numero, calle, zona) REFERENCES public."Construccion"(numero, calle, zona);

ALTER TABLE ONLY public."Construccion"
    ADD CONSTRAINT zona_construccion FOREIGN KEY (zona) REFERENCES public."Zona"(nombre);
