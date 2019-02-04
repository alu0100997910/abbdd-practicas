START TRANSACTION;
INSERT INTO Musico (dni, Nombre, Nacionalidad, Fecha_nacimiento) VALUES ('45454545p', 'James Hetfield', 'USA', '3/08/1963');
INSERT INTO Musico (dni, Nombre, Nacionalidad, Fecha_nacimiento) VALUES ('98989898k', 'Freddie Mercury', 'Reino Unido', '5/09/1946');
COMMIT;


START TRANSACTION;
INSERT INTO Grupo (Nombre) VALUES ('AC/DC');
INSERT INTO Grupo (Nombre) VALUES ('Metallica');
INSERT INTO Grupo (Nombre) VALUES ('Queen');
COMMIT;


START TRANSACTION;
INSERT INTO Instrumento (Nombre) VALUES ('Guitarra');
INSERT INTO Instrumento (Nombre) VALUES ('Bateria');
INSERT INTO Instrumento (Nombre) VALUES ('Voz');
INSERT INTO Instrumento (Nombre) VALUES ('Bajo');

COMMIT;


START TRANSACTION;
INSERT INTO Canciones (Nombre, Duracion, Publicacion, Genero) VALUES ('Bohemian Rhapsody', 5.55, '01/07/1975', 'Art Rock');
INSERT INTO Canciones (Nombre, Duracion, Publicacion, Genero) VALUES ('One', 7.24, '01/03/1988', 'Heavy Metal');
COMMIT;


START TRANSACTION;
INSERT INTO Discografica (Codigo, Nombre) VALUES (55555555, 'Sony Music');
INSERT INTO Discografica (Codigo, Nombre) VALUES (77777777, 'EMI');
COMMIT;


START TRANSACTION;
INSERT INTO Productora (Codigo, Nombre) VALUES (11111111, 'Timbaland');
INSERT INTO Productora (Codigo, Nombre) VALUES (33333333, 'Max Martin');
COMMIT;


START TRANSACTION;
INSERT INTO Album (Nombre, Publicacion, Tipo, Genero, Cantidad_canciones, Formato) VALUES ('Load', '4/06/1996', 'Albumes', 'Heavy Metal', 5, NULL);
INSERT INTO Album (Nombre, Publicacion, Tipo, Genero, Cantidad_canciones, Formato) VALUES ('Killer Queen', '11/10/1974', 'Sencillo', 'Pop Rock', 1, NULL);
COMMIT;

sTART TRANSACTION;
INSERT INTO pertenece_cancion_album (cancion, album) VALUES ('One', 'Load');
INSERT INTO pertenece_cancion_album (cancion, album) VALUES ('Bohemian Rhapsody', 'Killer Queen');
COMMIT;


START TRANSACTION;
INSERT INTO Pertenece_Mus_Gru (dni_m, Nombre_g, Comienzo, Fin) VALUES ('45454545p', 'Queen', '01/08/1980', NULL);
INSERT INTO Pertenece_Mus_Gru (dni_m, Nombre_g, Comienzo, Fin) VALUES ('98989898k', 'Metallica', '01/05/1960', NULL);
COMMIT;


START TRANSACTION;
INSERT INTO Tocan_Musico_Instrumento (dni_m, Nombre_i) VALUES ('45454545p', 'Bateria');
INSERT INTO Tocan_Musico_Instrumento (dni_m, Nombre_i) VALUES ('45454545p', 'Voz');
INSERT INTO Tocan_Musico_Instrumento (dni_m, Nombre_i) VALUES ('98989898k', 'Guitarra');
INSERT INTO Tocan_Musico_Instrumento (dni_m, Nombre_i) VALUES ('98989898k', 'Bajo');
COMMIT;


START TRANSACTION;
INSERT INTO Asignan_Mus_Gru_Ins (dni_m, Nombre_i, Nombre_g) VALUES ('98989898k', 'Guitarra', 'Queen');
INSERT INTO Asignan_Mus_Gru_Ins (dni_m, Nombre_i, Nombre_g) VALUES ('98989898k', 'Bajo', 'Queen');
COMMIT;

START TRANSACTION;
INSERT INTO Compone_Mus_Can (dni_m, Nombre_c) VALUES ('45454545p', 'One');
INSERT INTO Compone_Mus_Can (dni_m, Nombre_c) VALUES ('98989898k', 'Bohemian Rhapsody');
COMMIT;


START TRANSACTION;
INSERT INTO Distribuido_Alb_Dis (Nombre_a, Codigo_d) VALUES ('Load', 55555555);
INSERT INTO Distribuido_Alb_Dis (Nombre_a, Codigo_d) VALUES ('Load', 77777777);
COMMIT;


START TRANSACTION;
INSERT INTO Publicar_Alb_Pro (Nombre_a, Codigo_p) VALUES ('Killer Queen', 11111111);
INSERT INTO Publicar_Alb_Pro (Nombre_a, Codigo_p) VALUES ('Killer Queen', 33333333);
COMMIT;


START TRANSACTION;
INSERT INTO Interpreta_Gru_Alb (Nombre_g, Nombre_a) VALUES ('Metallica', 'Load');
INSERT INTO Interpreta_Gru_Alb (Nombre_g, Nombre_a) VALUES ('Queen', 'Killer Queen');
COMMIT;

