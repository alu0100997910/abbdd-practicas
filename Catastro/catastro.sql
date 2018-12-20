CREATE TABLE IF NOT EXISTS Zona (
  nombre VARCHAR(45) NOT NULL,
  limite POINT[] NOT NULL,
  extensión DECIMAL NULL,
  PRIMARY KEY (nombre));

CREATE TABLE IF NOT EXISTS ViviendaUnifamiliar (
  numero INT NOT NULL,
  calle VARCHAR(45) NOT NULL,
  cp INT NULL,
  m2_solar VARCHAR(45) NULL,
  fecha_construccion VARCHAR(45) NULL,
  zona VARCHAR(45) NULL,
  PRIMARY KEY (numero, calle),
  CONSTRAINT zona_vivienda
    FOREIGN KEY (zona)
    REFERENCES Zona (nombre)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
CREATE INDEX zona_vivienda_idx on ViviendaUnifamiliar (zona ASC) ;

CREATE TABLE IF NOT EXISTS Bloque (
  numero INT NOT NULL,
  calle VARCHAR(45) NOT NULL,
  nombre INT NOT NULL,
  cp INT NULL,
  m2_solar INT NULL,
  fecha_construccion DATE NULL,
  m2_totales INT NULL,
  num_plantas INT NULL,
  zona VARCHAR(45) NULL,
  PRIMARY KEY (numero, calle, nombre),
  CONSTRAINT zona_bloque
    FOREIGN KEY (zona)
    REFERENCES Zona (nombre)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
CREATE INDEX zona_bloque_idx on Bloque (zona ASC) ;

CREATE TABLE IF NOT EXISTS Piso (
  numero INT NOT NULL,
  calle VARCHAR(45) NOT NULL,
  planta INT NOT NULL,
  nombre_b INT NOT NULL,
  portal CHAR NOT NULL,
  m2_vivienda INT NULL,
  m2_comun INT NULL,
  PRIMARY KEY (numero, calle, planta, portal),
  CONSTRAINT piso_bloque
    FOREIGN KEY (numero , calle, nombre_b)
    REFERENCES Bloque (numero , calle, nombre)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE IF NOT EXISTS Persona (
  DNI INT NOT NULL,
  nombre VARCHAR(45) NULL,
  apellido VARCHAR(45) NULL,
  fecha_nac DATE NULL,
  familia VARCHAR(45) NULL,
  PRIMARY KEY (DNI));

CREATE TABLE IF NOT EXISTS Residente (
  dni INT NOT NULL,
  PRIMARY KEY (dni),
  CONSTRAINT dni_persona
    FOREIGN KEY (dni)
    REFERENCES Persona (DNI)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE IF NOT EXISTS Propietario (
  dni INT NOT NULL,
  PRIMARY KEY (dni),
  CONSTRAINT dni_persona
    FOREIGN KEY (dni)
    REFERENCES Persona (dni)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE IF NOT EXISTS ResideVivienda (
  dni INT NOT NULL,
  numero INT NULL,
  calle VARCHAR(45) NULL,
  PRIMARY KEY (dni),
  CONSTRAINT dni_residente
    FOREIGN KEY (dni)
    REFERENCES Residente (dni)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT vivienda_residente
    FOREIGN KEY (numero , calle)
    REFERENCES ViviendaUnifamiliar (numero , calle)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
CREATE INDEX vivienda_residente_idx ON ResideVivienda(numero ASC, calle ASC) ;

CREATE TABLE IF NOT EXISTS ResidePiso (
  dni INT NOT NULL,
  numero INT NULL,
  calle VARCHAR(45) NULL,
  planta INT NULL,
  portal CHAR NULL,
  PRIMARY KEY (dni),
  CONSTRAINT dni_residente
    FOREIGN KEY (dni)
    REFERENCES Residente (dni)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT residente_piso
    FOREIGN KEY (numero , calle , planta , portal)
    REFERENCES Piso (numero , calle , planta , portal)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
CREATE INDEX residente_piso_idx ON ResidePiso (numero ASC, calle ASC, planta ASC, portal ASC) ;

CREATE TABLE IF NOT EXISTS PropietarioPiso (
  dni INT NOT NULL,
  numero INT NOT NULL,
  calle VARCHAR(45) NOT NULL,
  planta INT NOT NULL,
  portal CHAR NOT NULL,
  PRIMARY KEY (dni, numero, calle, planta, portal),
  CONSTRAINT dni_propietario
    FOREIGN KEY (dni)
    REFERENCES Propietario (dni)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT propietario_piso
    FOREIGN KEY (numero , calle , planta , portal)
    REFERENCES Piso (numero , calle , planta , portal)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
CREATE INDEX propietario_piso_idx ON PropietarioPiso (numero ASC, calle ASC, planta ASC, portal ASC) ;

CREATE TABLE IF NOT EXISTS PropietarioVivienda (
  dni INT NOT NULL,
  numero INT NOT NULL,
  calle VARCHAR(45) NOT NULL,
  PRIMARY KEY (dni, calle, numero),
  CONSTRAINT dni_propietario
    FOREIGN KEY (dni)
    REFERENCES Propietario (dni)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT propietario_vivienda
    FOREIGN KEY (numero , calle)
    REFERENCES ViviendaUnifamiliar (numero , calle)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
CREATE INDEX propietario_vivienda_idx  ON PropietarioVivienda (numero ASC, calle ASC) ;

INSERT INTO zona (nombre, limite, extensión) values ('Mordor', array[POINT(1,1),POINT(2,2),POINT(3,3),POINT(4,4)], 27.5);
INSERT INTO zona (nombre, limite, extensión) values ('Ofra', array[POINT(2,1),POINT(2,2),POINT(3,3),POINT(4,4)], 27.4);
INSERT INTO ViviendaUnifamiliar (numero, calle, cp, m2_solar, fecha_construccion, zona) values (1, 'calle', 1234, 52, '12-22-2018', )