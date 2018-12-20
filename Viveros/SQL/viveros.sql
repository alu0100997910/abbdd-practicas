-- MySQL Script generated by MySQL Workbench
-- Wed Nov 14 23:03:21 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`CLIENTE_PLUS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CLIENTE_PLUS` (
  `dni` INT NOT NULL,
  `bonificacion` INT NOT NULL DEFAULT 0,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`dni`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PRODUCTOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PRODUCTOS` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `precio` FLOAT NOT NULL,
  `tipo` SET('Plantas', 'Jardineria', 'Decoración') NOT NULL,
  `stock` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`EMPLEADO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`EMPLEADO` (
  `dni` INT NOT NULL,
  `css` INT UNSIGNED NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `productividad` FLOAT NOT NULL DEFAULT 0,
  PRIMARY KEY (`dni`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PEDIDOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PEDIDOS` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `dni_c` INT NOT NULL,
  `dni_e` INT NOT NULL,
  `total` FLOAT NULL,
  PRIMARY KEY (`id`, `dni_c`, `dni_e`),
  INDEX `dni_idx` (`dni_c` ASC) VISIBLE,
  INDEX `dni_e_idx` (`dni_e` ASC) VISIBLE,
  CONSTRAINT `dni`
    FOREIGN KEY (`dni_c`)
    REFERENCES `mydb`.`CLIENTE_PLUS` (`dni`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `dni_e`
    FOREIGN KEY (`dni_e`)
    REFERENCES `mydb`.`EMPLEADO` (`dni`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`VIVEROS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`VIVEROS` (
  `v_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`v_name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ZONAS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ZONAS` (
  `z_name` SET('Exterior','Cajas','Almacen') NOT NULL,
  `v_name` VARCHAR(45) NOT NULL,
  `productividad` FLOAT NOT NULL DEFAULT 0,
  PRIMARY KEY (`z_name`, `v_name`),
  INDEX `v_name_idx` (`v_name` ASC) VISIBLE,
  CONSTRAINT `v_name`
    FOREIGN KEY (`v_name`)
    REFERENCES `mydb`.`VIVEROS` (`v_name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TRABAJA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TRABAJA` (
  `dni_e` INT NOT NULL,
  `inicio` DATE NOT NULL,
  `fin` DATE NULL,
  `v_name` VARCHAR(45) NOT NULL,
  `z_name` SET('Exterior','Cajas','Almacen') NULL,
  PRIMARY KEY (`dni_e`, `inicio`, `v_name`),
  INDEX `v_zona_idx` (`z_name` ASC) VISIBLE,
  INDEX `v_name_idx` (`v_name` ASC) VISIBLE,
  CONSTRAINT `v_zona`
    FOREIGN KEY (`z_name`)
    REFERENCES `mydb`.`ZONAS` (`z_name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `v_name`
    FOREIGN KEY (`v_name`)
    REFERENCES `mydb`.`VIVEROS` (`v_name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `dni_e`
    FOREIGN KEY (`dni_e`)
    REFERENCES `mydb`.`EMPLEADO` (`dni`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ZONA_STOCK`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ZONA_STOCK` (
  `z_name` SET('Exterior','Cajas','Almacen') NOT NULL,
  `v_name` VARCHAR(45) NOT NULL,
  `stock` INT NOT NULL,
  `id_pro` INT NOT NULL,
  PRIMARY KEY (`z_name`, `v_name`, `id_pro`),
  INDEX `z_name_idx` (`z_name` ASC, `v_name` ASC) VISIBLE,
  INDEX `id_pro_idx` (`id_pro` ASC) VISIBLE,
  CONSTRAINT `z_name`
    FOREIGN KEY (`z_name` , `v_name`)
    REFERENCES `mydb`.`ZONAS` (`z_name` , `v_name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `id_pro`
    FOREIGN KEY (`id_pro`)
    REFERENCES `mydb`.`PRODUCTOS` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PRODUCTO_PEDIDO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PRODUCTO_PEDIDO` (
  `id_ped` INT NOT NULL,
  `id_pro` INT NOT NULL,
  `cantidad` INT NOT NULL,
  PRIMARY KEY (`id_ped`, `id_pro`),
  INDEX `id_pro_idx` (`id_pro` ASC) VISIBLE,
  CONSTRAINT `id_pro`
    FOREIGN KEY (`id_pro`)
    REFERENCES `mydb`.`PRODUCTOS` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `id_ped`
    FOREIGN KEY (`id_ped`)
    REFERENCES `mydb`.`PEDIDOS` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `mydb`.`CLIENTE_PLUS`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`CLIENTE_PLUS` (`dni`, `bonificacion`, `nombre`) VALUES (11111111, DEFAULT, 'pepito');
INSERT INTO `mydb`.`CLIENTE_PLUS` (`dni`, `bonificacion`, `nombre`) VALUES (22222222, DEFAULT, 'juanito');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`PRODUCTOS`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`PRODUCTOS` (`id`, `nombre`, `precio`, `tipo`, `stock`) VALUES (1, 'Geranio', 24, 'Plantas', 20);
INSERT INTO `mydb`.`PRODUCTOS` (`id`, `nombre`, `precio`, `tipo`, `stock`) VALUES (2, 'Tijeras de poda', 15, 'Jardineria', 13);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`EMPLEADO`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`EMPLEADO` (`dni`, `css`, `nombre`, `productividad`) VALUES (33333333, 3, 'Pepito', DEFAULT);
INSERT INTO `mydb`.`EMPLEADO` (`dni`, `css`, `nombre`, `productividad`) VALUES (44444444, 4, 'Juanito', DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`PEDIDOS`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`PEDIDOS` (`id`, `dni_c`, `dni_e`, `total`) VALUES (1, 11111111, 33333333, 24);
INSERT INTO `mydb`.`PEDIDOS` (`id`, `dni_c`, `dni_e`, `total`) VALUES (2, 22222222, 44444444, 15);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`VIVEROS`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`VIVEROS` (`v_name`) VALUES ('Adeje');
INSERT INTO `mydb`.`VIVEROS` (`v_name`) VALUES ('La Laguna');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`ZONAS`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`ZONAS` (`z_name`, `v_name`, `productividad`) VALUES ('Exterior', 'Adeje', DEFAULT);
INSERT INTO `mydb`.`ZONAS` (`z_name`, `v_name`, `productividad`) VALUES ('Almacen', 'La Laguna', DEFAULT);
INSERT INTO `mydb`.`ZONAS` (`z_name`, `v_name`, `productividad`) VALUES ('Cajas', 'Adeje', DEFAULT);
INSERT INTO `mydb`.`ZONAS` (`z_name`, `v_name`, `productividad`) VALUES ('Almacen', 'Adeje', DEFAULT);
INSERT INTO `mydb`.`ZONAS` (`z_name`, `v_name`, `productividad`) VALUES ('Cajas', 'La Laguna', DEFAULT);
INSERT INTO `mydb`.`ZONAS` (`z_name`, `v_name`, `productividad`) VALUES ('Exterior', 'La Laguna', DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`TRABAJA`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`TRABAJA` (`dni_e`, `inicio`, `fin`, `v_name`, `z_name`) VALUES (33333333, '14/11/2018', NULL, 'Adeje', 'Exterior');
INSERT INTO `mydb`.`TRABAJA` (`dni_e`, `inicio`, `fin`, `v_name`, `z_name`) VALUES (44444444, '13/11/2018', NULL, 'Adeje', 'Almacen');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`ZONA_STOCK`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`ZONA_STOCK` (`z_name`, `v_name`, `stock`, `id_pro`) VALUES ('Almacen', 'Adeje', 2, 2);
INSERT INTO `mydb`.`ZONA_STOCK` (`z_name`, `v_name`, `stock`, `id_pro`) VALUES ('Exterior', 'Adeje', 12, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`PRODUCTO_PEDIDO`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`PRODUCTO_PEDIDO` (`id_ped`, `id_pro`, `cantidad`) VALUES (1, 1, 1);
INSERT INTO `mydb`.`PRODUCTO_PEDIDO` (`id_ped`, `id_pro`, `cantidad`) VALUES (2, 2, 1);

COMMIT;
