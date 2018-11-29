
CREATE TABLE IF NOT EXISTS FAMILIA (
  nombre VARCHAR(40) NOT NULL,
  incompatibilidades VARCHAR(45) NULL,
  PRIMARY KEY (nombre));

CREATE TABLE IF NOT EXISTS ENFERMEDAD (
  nombre VARCHAR(45) NOT NULL,
  nombre_fam VARCHAR(45) NOT NULL,
  PRIMARY KEY (nombre),
  CONSTRAINT nombre_fam
    FOREIGN KEY (nombre_fam)
    REFERENCES FAMILIA (nombre)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
CREATE INDEX nombre_fam_idx on ENFERMEDAD (nombre_fam ASC);


CREATE DOMAIN tipo_tipo_venta AS TEXT
CHECK(
VALUE = 'receta'
OR VALUE = 'libre'
);

CREATE DOMAIN tipo_medicamento AS TEXT
CHECK(
VALUE = 'pomada'
OR VALUE = 'inyectable'
OR VALUE = 'jarabe'
OR VALUE = 'comprimido'
);

CREATE TABLE IF NOT EXISTS MEDICAMENTO (
  codigo_med INT NOT NULL,
  precio FLOAT NULL,
  unidades_stock VARCHAR(45) NULL,
  unidades_vendidas VARCHAR(45) NULL,
  tipo_venta tipo_tipo_venta NULL,
  tipo tipo_medicamento NULL,
  nombre_fam VARCHAR(45) NOT NULL,
  PRIMARY KEY (codigo_med),
  CONSTRAINT nombre_fam
    FOREIGN KEY (nombre_fam)
    REFERENCES FAMILIA(nombre)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
  CREATE INDEX nombre_fam_idx_m on MEDICAMENTO (nombre_fam ASC);

CREATE TABLE IF NOT EXISTS CLIENTE_CREDITO (
  DNI VARCHAR(9) NOT NULL,
  nombre VARCHAR(45) NULL,
  fecha_pago DATE NULL,
  datos_bancarios VARCHAR(45) NULL,
  PRIMARY KEY (DNI));

CREATE TABLE IF NOT EXISTS VENTAS (
  fecha_compra DATE NOT NULL,
  cantidades INT NULL,
  DNI_cliente VARCHAR(45) NOT NULL,
  cod_med INT NOT NULL,
  PRIMARY KEY (fecha_compra),
  CONSTRAINT DNI_cliente
    FOREIGN KEY (DNI_cliente)
    REFERENCES CLIENTE_CREDITO (DNI)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT cod_med
    FOREIGN KEY (cod_med)
    REFERENCES MEDICAMENTO (codigo_med)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
CREATE INDEX DNI_cliente_idx ON VENTAS (DNI_cliente ASC);
CREATE INDEX cod_med_idx ON VENTAS (cod_med ASC);

CREATE TABLE IF NOT EXISTS LABORATORIO (
  codigo_lab INT NOT NULL,
  telefono INT NULL,
  fax INT NULL,
  nombre VARCHAR(45) NULL,
  direccion VARCHAR(45) NULL,
  PRIMARY KEY (codigo_lab));

CREATE TABLE IF NOT EXISTS COMPRA_MED_LAB (
  cod_med INT NOT NULL,
  cod_lab INT NOT NULL,
  persona_contacto VARCHAR(45) NULL,
  cantidades INT NULL,
  PRIMARY KEY (cod_med, cod_lab),
  CONSTRAINT cod_med
    FOREIGN KEY (cod_med)
    REFERENCES MEDICAMENTO (codigo_med)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT cod_lab
    FOREIGN KEY (cod_lab)
    REFERENCES LABORATORIO (codigo_lab)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
CREATE INDEX cod_lab_idx on COMPRA_MED_LAB (cod_lab ASC);

CREATE TABLE IF NOT EXISTS FABRICA_MED_LAB (
  cod_med INT NOT NULL,
  cod_lab INT NOT NULL,
  PRIMARY KEY (cod_med, cod_lab),
  CONSTRAINT cod_med0
    FOREIGN KEY (cod_med)
    REFERENCES MEDICAMENTO (codigo_med)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT cod_lab0
    FOREIGN KEY (cod_lab)
    REFERENCES LABORATORIO (codigo_lab)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
CREATE INDEX cod_fab_idx on FABRICA_MED_LAB (cod_lab ASC);

START TRANSACTION;
INSERT INTO FAMILIA (nombre, incompatibilidades) VALUES ('antiestaminico', 'alcohol');
INSERT INTO FAMILIA (nombre, incompatibilidades) VALUES ('laxante', 'alcohol');
INSERT INTO FAMILIA (nombre, incompatibilidades) VALUES ('antibiotico', 'alcohol');
INSERT INTO FAMILIA (nombre, incompatibilidades) VALUES ('antidiarreico', 'alcohol');
COMMIT;

START TRANSACTION;
INSERT INTO ENFERMEDAD (nombre, nombre_fam) VALUES ('alergia', 'antiestaminico');
INSERT INTO ENFERMEDAD (nombre, nombre_fam) VALUES ('varicela', 'antipireticos');
COMMIT;

START TRANSACTION;
INSERT INTO MEDICAMENTO (codigo_med, precio, unidades_stock, unidades_vendidas, tipo_venta, tipo, nombre_fam) VALUES (0000, 10, '50', '10', 'receta', 'pomada', 'antibiotico');
INSERT INTO MEDICAMENTO (codigo_med, precio, unidades_stock, unidades_vendidas, tipo_venta, tipo, nombre_fam) VALUES (0001, 15, '40', '5', 'libre', 'jarabe', 'antidiarreico');
COMMIT;

START TRANSACTION;
INSERT INTO CLIENTE_CREDITO (DNI, nombre, fecha_pago, datos_bancarios) VALUES ('45454545p', 'Juan Salazar', '15/11/2018', '66548284554');
INSERT INTO CLIENTE_CREDITO (DNI, nombre, fecha_pago, datos_bancarios) VALUES ('21212121k', 'Pedro Castro', '28/11/2018', '98764188712');
COMMIT;

START TRANSACTION;
INSERT INTO VENTAS (fecha_compra, cantidades, DNI_cliente, cod_med) VALUES ('15/11/2018', 5, '45454545p', 0000);
INSERT INTO VENTAS (fecha_compra, cantidades, DNI_cliente, cod_med) VALUES ('18/11/2018', 2, '21212121k', 0001);
COMMIT;

START TRANSACTION;
INSERT INTO LABORATORIO (codigo_lab, telefono, fax, nombre, direccion) VALUES (2222, 922963852, 2222222, 'Adeje Farmacias', 'av trinidad, 5');
INSERT INTO LABORATORIO (codigo_lab, telefono, fax, nombre, direccion) VALUES (2223, 922741359, 1111111, 'Maestre Farmacias', 'av calvo sotelo, 2');
COMMIT;

START TRANSACTION;
INSERT INTO COMPRA_MED_LAB (cod_med, cod_lab, persona_contacto, cantidades) VALUES (0000, 2222, 'Alejandro', 80);
INSERT INTO COMPRA_MED_LAB (cod_med, cod_lab, persona_contacto, cantidades) VALUES (0001, 2222, 'Jesus', 30);
COMMIT;

START TRANSACTION;
INSERT INTO FABRICA_MED_LAB (cod_med, cod_lab) VALUES (0000, 2222);
INSERT INTO FABRICA_MED_LAB (cod_med, cod_lab) VALUES (0000, 2223);
COMMIT;

