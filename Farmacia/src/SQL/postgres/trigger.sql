CREATE OR REPLACE FUNCTION aumentar_stock() RETURNS TRIGGER AS $actualizar_stock_compra$
	BEGIN
		UPDATE MEDICAMENTO SET
			unidades_stock = unidades_stock + NEW.cantidades
		WHERE MEDICAMENTO.codigo_med = NEW.cod_med;
		RETURN NEW;
	END;
$actualizar_stock_compra$ LANGUAGE plpgsql;

CREATE TRIGGER actualizar_stock_compra AFTER INSERT ON COMPRA_MED_LAB
FOR EACH ROW EXECUTE PROCEDURE aumentar_stock();

CREATE OR REPLACE FUNCTION disminuir_stock() RETURNS TRIGGER AS $actualizar_stock_compra$
	BEGIN
		UPDATE PRODUCTOS SET
			stock = stock - NEW.cantidad
		WHERE PRODUCTOS.id = NEW.id_pro;
		RETURN NEW;
	END;
$actualizar_stock_compra$ LANGUAGE plpgsql;

CREATE TRIGGER actualizar_stock_compra AFTER INSERT ON PRODUCTO_PEDIDO
FOR EACH ROW EXECUTE PROCEDURE disminuir_stock();
