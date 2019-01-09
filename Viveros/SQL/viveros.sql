CREATE TABLE CLIENTE_PLUS (
  dni INT NOT NULL,
  bonificacion INT NOT NULL DEFAULT 0,
  nombre VARCHAR(45) NOT NULL,
  PRIMARY KEY (dni));

CREATE DOMAIN tipo_producto AS TEXT
CHECK(
VALUE = 'Plantas'
OR VALUE = 'Jardineria'
OR VALUE = 'Decoración'
);

CREATE TABLE PRODUCTOS (
  id SERIAL NOT NULL,
  nombre VARCHAR(45) NOT NULL,
  precio FLOAT NOT NULL,
  tipo tipo_producto NOT NULL,
  stock INT NOT NULL,
  PRIMARY KEY (id));

CREATE TABLE EMPLEADO (
  dni BIGINT NOT NULL,
  css BIGINT UNIQUE NOT NULL,
  nombre VARCHAR(45) NULL,
  productividad FLOAT NOT NULL DEFAULT 0,
  PRIMARY KEY (dni));

CREATE TABLE PEDIDOS (
  id SERIAL NOT NULL UNIQUE,
  dni_c BIGINT NOT NULL,
  dni_e BIGINT NOT NULL,
  total FLOAT NULL,
  PRIMARY KEY (id, dni_c, dni_e),
  CONSTRAINT dni
    FOREIGN KEY (dni_c)
    REFERENCES CLIENTE_PLUS (dni)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT dni_e
    FOREIGN KEY (dni_e)
    REFERENCES EMPLEADO (dni)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
CREATE INDEX dni_idx on PEDIDOS (dni_c ASC);
CREATE INDEX dni_e_idx on PEDIDOS (dni_e ASC);

CREATE TABLE VIVEROS (
  v_name VARCHAR(45) NOT NULL,
  PRIMARY KEY (v_name));

CREATE DOMAIN tipo_zona AS TEXT
CHECK(
VALUE = 'Exterior'
OR VALUE = 'Cajas'
OR VALUE = 'Almacen'
);

CREATE TABLE ZONAS (
  z_name tipo_zona NOT NULL UNIQUE,
  v_name VARCHAR(45) NOT NULL,
  productividad FLOAT NOT NULL DEFAULT 0,
  PRIMARY KEY (z_name, v_name),
  CONSTRAINT v_name
    FOREIGN KEY (v_name)
    REFERENCES VIVEROS (v_name)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
CREATE INDEX v_name_idx ON ZONAS (v_name ASC);



CREATE TABLE TRABAJA (
  dni_e INT NOT NULL,
  inicio DATE NOT NULL,
  fin DATE NULL,
  v_name VARCHAR(45) NOT NULL,
  z_name tipo_zona NOT NULL,
  PRIMARY KEY (dni_e, inicio, v_name),
  CONSTRAINT v_zona_t
    FOREIGN KEY (z_name)
    REFERENCES ZONAS (z_name)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT v_name_t
    FOREIGN KEY (v_name)
    REFERENCES VIVEROS (v_name)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT dni_e_t
    FOREIGN KEY (dni_e)
    REFERENCES EMPLEADO (dni)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
CREATE INDEX v_zona_idx ON TRABAJA (z_name ASC);
CREATE INDEX v_name_idx ON TRABAJA (v_name ASC);


CREATE TABLE ZONA_STOCK (
  z_name tipo_zona NOT NULL,
  v_name VARCHAR(45) NOT NULL,
  stock INT NOT NULL,
  id_pro INT NOT NULL,
  PRIMARY KEY (z_name, v_name, id_pro),
  CONSTRAINT z_name
    FOREIGN KEY (z_name , v_name)
    REFERENCES ZONAS (z_name , v_name)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT id_pro
    FOREIGN KEY (id_pro)
    REFERENCES PRODUCTOS (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
CREATE INDEX z_name_idx ON ZONA_STOCK(z_name ASC, v_name ASC);
CREATE INDEX id_pro_idx ON ZONA_STOCK(id_pro ASC);

CREATE TABLE PRODUCTO_PEDIDO (
  id_ped INT NOT NULL,
  id_pro INT NOT NULL,
  cantidad INT NOT NULL,
  PRIMARY KEY (id_ped, id_pro),
  CONSTRAINT id_pro
    FOREIGN KEY (id_pro)
    REFERENCES PRODUCTOS (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT id_ped
    FOREIGN KEY (id_ped)
    REFERENCES PEDIDOS (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
CREATE INDEX id_pro_idx_prod_ped ON PRODUCTO_PEDIDO (id_pro ASC);


START TRANSACTION;
INSERT INTO CLIENTE_PLUS (dni, bonificacion, nombre) VALUES (11111111, DEFAULT, 'pepito');
INSERT INTO CLIENTE_PLUS (dni, bonificacion, nombre) VALUES (22222222, DEFAULT, 'juanito');

COMMIT;

START TRANSACTION;
INSERT INTO PRODUCTOS (id, nombre, precio, tipo, stock) VALUES (1, 'Geranio', 24, 'Plantas', 20);
INSERT INTO PRODUCTOS (id, nombre, precio, tipo, stock) VALUES (2, 'Tijeras de poda', 15, 'Jardineria', 13);

COMMIT;

START TRANSACTION;
INSERT INTO EMPLEADO (dni, css, nombre, productividad) VALUES (33333333, 3, 'Pepito', DEFAULT);
INSERT INTO EMPLEADO (dni, css, nombre, productividad) VALUES (44444444, 4, 'Juanito', DEFAULT);

COMMIT;

START TRANSACTION;
INSERT INTO PEDIDOS (id, dni_c, dni_e, total) VALUES (1, 11111111, 33333333, 24);
INSERT INTO PEDIDOS (id, dni_c, dni_e, total) VALUES (2, 22222222, 44444444, 15);

COMMIT;

START TRANSACTION;
INSERT INTO VIVEROS (v_name) VALUES ('Adeje');
INSERT INTO VIVEROS (v_name) VALUES ('La Laguna');

COMMIT;

START TRANSACTION;
INSERT INTO ZONAS (z_name, v_name, productividad) VALUES ('Exterior', 'Adeje', DEFAULT);
INSERT INTO ZONAS (z_name, v_name, productividad) VALUES ('Almacen', 'La Laguna', DEFAULT);
INSERT INTO ZONAS (z_name, v_name, productividad) VALUES ('Cajas', 'Adeje', DEFAULT);
INSERT INTO ZONAS (z_name, v_name, productividad) VALUES ('Almacen', 'Adeje', DEFAULT);
INSERT INTO ZONAS (z_name, v_name, productividad) VALUES ('Cajas', 'La Laguna', DEFAULT);
INSERT INTO ZONAS (z_name, v_name, productividad) VALUES ('Exterior', 'La Laguna', DEFAULT);

COMMIT;

START TRANSACTION;
INSERT INTO TRABAJA (dni_e, inicio, fin, v_name, z_name) VALUES (33333333, 14/11/2018, NULL, 'Adeje', 'Exterior');
INSERT INTO TRABAJA (dni_e, inicio, fin, v_name, z_name) VALUES (44444444, 13/11/2018, NULL, 'Adeje', 'Almacen');

COMMIT;

START TRANSACTION;
INSERT INTO ZONA_STOCK (z_name, v_name, stock, id_pro) VALUES ('Almacen', 'Adeje', 2, 2);
INSERT INTO ZONA_STOCK (z_name, v_name, stock, id_pro) VALUES ('Exterior', 'Adeje', 12, 1);

COMMIT;

START TRANSACTION;
INSERT INTO PRODUCTO_PEDIDO (id_ped, id_pro, cantidad) VALUES (1, 1, 1);
INSERT INTO PRODUCTO_PEDIDO (id_ped, id_pro, cantidad) VALUES (2, 2, 1);

COMMIT;
