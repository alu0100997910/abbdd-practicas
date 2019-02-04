CREATE OR REPLACE FUNCTION comprobar_single() RETURNS TRIGGER AS $comprobar_formato_single$
	BEGIN
		IF NEW.tipo = 'Sencillo' THEN
			IF NEW.formato != 'Digital' THEN
				RAISE EXCEPTION '% es sencillo y solo puede tener formato digital', NEW.Nombre;
			END IF;
		END IF;
		RETURN NEW;
	END;
$comprobar_formato_single$ LANGUAGE plpgsql;

CREATE TRIGGER comprobar_single_album AFTER INSERT ON Album
FOR EACH ROW EXECUTE PROCEDURE comprobar_single();

CREATE OR REPLACE FUNCTION comprobar_cantidad_canciones() RETURNS TRIGGER AS $comprobar_cantidad_canciones_album$
	BEGIN
		IF NEW.cantidad_canciones < 1 THEN 
			RAISE EXCEPTION 'Un álbum no puede tener menos de una canción.';
		ELSIF NEW.tipo = 'Sencillo' THEN
			IF NEW.cantidad_canciones > 3 THEN
				RAISE EXCEPTION '% es un sencillo, no puede tener más de 3 canciones', NEW.Nombre;
			END IF;
		ELSIF NEW.tipo = 'EP' THEN
			IF NEW.cantidad_canciones > 5 THEN
				RAISE EXCEPTION '% es un EP, no puede tener más de 5 canciones', NEW.Nombre;
			END IF;
		ELSIF NEW.tipo = 'Albumes' THEN
			IF NEW.cantidad_canciones < 6 THEN
				RAISE EXCEPTION '% es un álbum (LP), no puede tener menos de 6 canciones', NEW.Nombre;
			END IF;
		END IF;
		RETURN NEW;
	END;
$comprobar_cantidad_canciones_album$ LANGUAGE plpgsql;

CREATE TRIGGER comprobar_cantidad AFTER INSERT ON Album
FOR EACH ROW EXECUTE PROCEDURE comprobar_cantidad_canciones();


CREATE OR REPLACE FUNCTION comprobar_instrumentos() RETURNS TRIGGER AS $comprobar_instrumentos_musicos$
	DECLARE
		instrumento VARCHAR(45);
		inst CURSOR FOR SELECT nombre_i FROM Tocan_Musico_Instrumento where dni_m = NEW.dni_m;
	BEGIN
	OPEN inst;
	LOOP
		FETCH inst INTO instrumento;
		EXIT WHEN NOT FOUND;

		IF instrumento = NEW.Nombre_i THEN
			CLOSE inst;
			RETURN NEW;
		END IF;
	END LOOP;
		CLOSE inst;
		RAISE EXCEPTION 'El músico % no toca el instrumento',NEW.dni_m;
	END;
$comprobar_instrumentos_musicos$ LANGUAGE plpgsql;

CREATE TRIGGER comprobar_instrumentos AFTER INSERT ON Asignan_Mus_Gru_Ins
FOR EACH ROW EXECUTE PROCEDURE comprobar_instrumentos();


CREATE OR REPLACE FUNCTION comprobar_genero() RETURNS TRIGGER AS $comprobar_genero_disco$
	DECLARE
		genero_cancion VARCHAR(45);
		genc CURSOR FOR SELECT genero from canciones where nombre = NEW.cancion;
		genero_album VARCHAR(45);
		gena CURSOR FOR SELECT genero from Album where nombre = NEW.album;
	BEGIN
		OPEN genc;
		OPEN gena;
		LOOP
			FETCH genc INTO genero_cancion;
			EXIT WHEN NOT FOUND;

			FETCH gena INTO genero_album;
			EXIT WHEN NOT FOUND;

			IF genero_cancion = genero_album THEN
				CLOSE genc;
				CLOSE gena;
				RETURN NEW;
			END IF;
		END LOOP;
		CLOSE genc;
		CLOSE gena;
		RAISE EXCEPTION 'El género de la canción % no es el mismo que el del álbum %', NEW.cancion, NEW.album;
		
	END;
$comprobar_genero_disco$ LANGUAGE plpgsql;

CREATE TRIGGER comprobar_genero AFTER INSERT ON pertenece_cancion_album
FOR EACH ROW EXECUTE PROCEDURE comprobar_genero();