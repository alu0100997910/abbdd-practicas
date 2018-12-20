CREATE OR REPLACE FUNCTION controlar_habitantes_vivienda() RETURNS TRIGGER AS $actualizar_habitantes_vivienda$
	BEGIN
		DELETE FROM ResidePiso WHERE ResidePiso.dni = NEW.dni;
		RETURN NEW;
	END;
$actualizar_habitantes_vivienda$ LANGUAGE plpgsql;

CREATE TRIGGER actualizar_stock_compra AFTER INSERT ON ResideVivienda
FOR EACH ROW EXECUTE PROCEDURE controlar_habitantes_vivienda();