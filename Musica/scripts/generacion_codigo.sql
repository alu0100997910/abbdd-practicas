CREATE TABLE IF NOT EXISTS Musico (
  dni VARCHAR(9) NOT NULL,
  Nombre VARCHAR(45) NULL,
  Nacionalidad VARCHAR(45) NULL,
  Fecha_nacimiento DATE NULL,
  PRIMARY KEY (dni));


CREATE TABLE IF NOT EXISTS Grupo (
  Nombre VARCHAR(20) NOT NULL,
  PRIMARY KEY (Nombre));


CREATE TABLE IF NOT EXISTS Instrumento (
  Nombre VARCHAR(20) NOT NULL,
  PRIMARY KEY (Nombre));


CREATE TABLE IF NOT EXISTS Canciones (
  Nombre VARCHAR(20) NOT NULL,
  Duracion FLOAT NULL,
  Publicacion DATE NULL,
  Genero VARCHAR(45) NOT NULL,
  PRIMARY KEY (Nombre));


CREATE TABLE IF NOT EXISTS Discografica (
  Codigo INT NOT NULL,
  Nombre VARCHAR(20) NOT NULL,
  PRIMARY KEY (Codigo));



CREATE TABLE IF NOT EXISTS Productora (
  Codigo INT NOT NULL,
  Nombre VARCHAR(45) NOT NULL,
  PRIMARY KEY (Codigo));

CREATE DOMAIN tipo_album AS TEXT
CHECK(
VALUE = 'EP'
OR VALUE = 'Sencillo'
OR VALUE = 'Albumes'
);

CREATE DOMAIN formato_album AS TEXT
CHECK(
VALUE = 'Digital'
OR VALUE = 'Fisico');

CREATE TABLE IF NOT EXISTS Album (
  Nombre VARCHAR(30) NOT NULL,
  Publicacion DATE NULL,
  Tipo tipo_album NOT NULL,
  Genero VARCHAR(45) NOT NULL,
  Cantidad_canciones INT NOT NULL,
  Formato formato_album NULL,
  PRIMARY KEY (Nombre));

CREATE TABLE IF NOT EXISTS pertenece_cancion_album (
  cancion VARCHAR(45) NOT NULL,
  album VARCHAR(45) NOT NULL,
  PRIMARY KEY (cancion, album),
  CONSTRAINT cancion
    FOREIGN KEY (cancion)
    REFERENCES canciones (nombre)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT album
    FOREIGN KEY (album)
    REFERENCES album (nombre)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
CREATE INDEX nombre_c_idx_pert ON pertenece_cancion_album (cancion ASC);

CREATE TABLE IF NOT EXISTS Pertenece_Mus_Gru (
  dni_m VARCHAR(9) NOT NULL,
  Nombre_g VARCHAR(45) NOT NULL,
  Comienzo DATE NOT NULL,
  Fin VARCHAR(45) NULL,
  PRIMARY KEY (dni_m, Nombre_g),
  CONSTRAINT dni_m
    FOREIGN KEY (dni_m)
    REFERENCES Musico (dni)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT Nombre_g
    FOREIGN KEY (Nombre_g)
    REFERENCES Grupo (Nombre)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
CREATE INDEX nombre_g_idx on Pertenece_Mus_Gru (Nombre_g ASC);


CREATE TABLE IF NOT EXISTS Tocan_Musico_Instrumento (
  dni_m VARCHAR(9) NOT NULL,
  Nombre_i VARCHAR(45) NOT NULL,
  PRIMARY KEY (dni_m, Nombre_i),
  CONSTRAINT dni_m
    FOREIGN KEY (dni_m)
    REFERENCES Musico (dni)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT Nombre_i
    FOREIGN KEY (Nombre_i)
    REFERENCES Instrumento (Nombre)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
CREATE INDEX nombre_i_idx ON Tocan_Musico_Instrumento(Nombre_i ASC);


CREATE TABLE IF NOT EXISTS Asignan_Mus_Gru_Ins (
  dni_m VARCHAR(9) NOT NULL,
  Nombre_i VARCHAR(45) NOT NULL,
  Nombre_g VARCHAR(45) NOT NULL,
  PRIMARY KEY (dni_m, Nombre_i, Nombre_g),
  CONSTRAINT dni_m
    FOREIGN KEY (dni_m)
    REFERENCES Musico (dni)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT Nombre_i
    FOREIGN KEY (Nombre_i)
    REFERENCES Instrumento (Nombre)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT Nombre_g
    FOREIGN KEY (Nombre_g)
    REFERENCES Grupo (Nombre)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
CREATE INDEX nombre_i_idx_asig on Asignan_Mus_Gru_Ins (Nombre_i ASC);
CREATE INDEX nombre_g_idx_asig on Asignan_Mus_Gru_Ins (Nombre_g ASC);

CREATE TABLE IF NOT EXISTS Compone_Mus_Can (
  dni_m VARCHAR(9) NOT NULL,
  Nombre_c VARCHAR(45) NOT NULL,
  PRIMARY KEY (dni_m, Nombre_c),
  CONSTRAINT dni_m
    FOREIGN KEY (dni_m)
    REFERENCES Musico (dni)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT Nombre_c
    FOREIGN KEY (Nombre_c)
    REFERENCES Canciones (Nombre)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
CREATE INDEX nombre_c_idx_compone ON Compone_Mus_Can (Nombre_c ASC);

CREATE TABLE IF NOT EXISTS Distribuido_Alb_Dis (
  Nombre_a VARCHAR(30) NOT NULL,
  Codigo_d INT NOT NULL,
  PRIMARY KEY (Nombre_a, Codigo_d),
  CONSTRAINT nombre_a
    FOREIGN KEY (Nombre_a)
    REFERENCES Album (Nombre)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT codigo_d
    FOREIGN KEY (Codigo_d)
    REFERENCES Discografica (Codigo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
CREATE INDEX codigo_d_idx ON Distribuido_Alb_Dis (Codigo_d ASC);


CREATE TABLE IF NOT EXISTS Publicar_Alb_Pro (
  Nombre_a VARCHAR(30) NOT NULL,
  Codigo_p INT NOT NULL,
  PRIMARY KEY (Nombre_a, Codigo_p),
  CONSTRAINT nombre_a
    FOREIGN KEY (Nombre_a)
    REFERENCES Album (Nombre)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT codigo_p
    FOREIGN KEY (Codigo_p)
    REFERENCES Productora (Codigo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
CREATE INDEX codigo_p_idx_publicar on Publicar_Alb_Pro (Codigo_p ASC);


CREATE TABLE IF NOT EXISTS Interpreta_Gru_Alb (
  Nombre_g VARCHAR(20) NOT NULL,
  Nombre_a VARCHAR(30) NOT NULL,
  PRIMARY KEY (Nombre_g, Nombre_a),
  CONSTRAINT Nombre_g
    FOREIGN KEY (Nombre_g)
    REFERENCES Grupo (Nombre)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT Nombre_a
    FOREIGN KEY (Nombre_a)
    REFERENCES Album (Nombre)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
CREATE INDEX Nombre_a_idx ON Interpreta_Gru_Alb (Nombre_a ASC);

