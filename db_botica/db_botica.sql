SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `botica` DEFAULT CHARACTER SET utf8 ;
USE `botica` ;

-- -----------------------------------------------------
-- Table `botica`.`paises`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `botica`.`paises` (
  `id_pais` VARCHAR(3) NOT NULL,
  `nombre` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_pais`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `botica`.`departamentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `botica`.`departamentos` (
  `id_departamento` INT(11) NOT NULL,
  `nombre` VARCHAR(100) NOT NULL,
  `id_pais` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`id_departamento`),
  INDEX `fk_departamentos_paises_idx` (`id_pais` ASC),
  CONSTRAINT `fk_departamentos_paises`
    FOREIGN KEY (`id_pais`)
    REFERENCES `botica`.`paises` (`id_pais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `botica`.`ciudades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `botica`.`ciudades` (
  `id_ciudad` INT(11) NOT NULL,
  `nombre` VARCHAR(100) NOT NULL,
  `iddepartamento` INT(11) NOT NULL,
  PRIMARY KEY (`id_ciudad`, `iddepartamento`),
  INDEX `fk_ciudades_departamentos1_idx` (`iddepartamento` ASC),
  CONSTRAINT `fk_ciudades_departamentos1`
    FOREIGN KEY (`iddepartamento`)
    REFERENCES `botica`.`departamentos` (`id_departamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `botica`.`imagenes_pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `botica`.`imagenes_pedidos` (
  `id_imagen_pedido` INT(11) NOT NULL AUTO_INCREMENT,
  `url` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_imagen_pedido`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `botica`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `botica`.`roles` (
  `id_rol` INT NOT NULL,
  `descripcion` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_rol`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `botica`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `botica`.`usuarios` (
  `id_usuario` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NULL,
  `email` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `clave` VARCHAR(45) NOT NULL,
  `id_ciudad` INT(11) NOT NULL,
  `id_departamento` INT(11) NOT NULL,
  `nit` VARCHAR(45) NULL,
  `camaracomercio` VARCHAR(45) NULL,
  `invima` VARCHAR(45) NULL,
  `id_rol` INT NOT NULL,
  PRIMARY KEY (`id_usuario`),
  INDEX `fk_usuarios_ciudades1_idx` (`id_ciudad` ASC, `id_departamento` ASC),
  INDEX `fk_usuarios_roles1_idx` (`id_rol` ASC),
  CONSTRAINT `fk_usuarios_ciudades1`
    FOREIGN KEY (`id_ciudad` , `id_departamento`)
    REFERENCES `botica`.`ciudades` (`id_ciudad` , `iddepartamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_roles1`
    FOREIGN KEY (`id_rol`)
    REFERENCES `botica`.`roles` (`id_rol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `botica`.`sedes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `botica`.`sedes` (
  `id_sede` INT NOT NULL AUTO_INCREMENT,
  `nombre_sede` VARCHAR(60) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  `id_drogueria` INT(11) NOT NULL,
  PRIMARY KEY (`id_sede`),
  INDEX `fk_sedes_usuarios1_idx` (`id_drogueria` ASC),
  CONSTRAINT `fk_sedes_usuarios1`
    FOREIGN KEY (`id_drogueria`)
    REFERENCES `botica`.`usuarios` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `botica`.`zona_envios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `botica`.`zona_envios` (
  `id_zona_envio` INT NOT NULL,
  `descripcion_zona` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_zona_envio`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `botica`.`pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `botica`.`pedidos` (
  `id_pedido` INT(11) NOT NULL AUTO_INCREMENT,
  `idusuario` INT(11) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(200) NULL DEFAULT NULL,
  `id_sede` INT NOT NULL,
  `id_zona_envio` INT NOT NULL,
  `ciudad` VARCHAR(45) NOT NULL,
  `fecha` DATE NOT NULL,
  PRIMARY KEY (`id_pedido`),
  INDEX `fk_pedidos_usuarios1_idx` (`idusuario` ASC),
  INDEX `fk_pedidos_sedes1_idx` (`id_sede` ASC),
  INDEX `fk_pedidos_zona_envios1_idx` (`id_zona_envio` ASC),
  CONSTRAINT `fk_pedidos_usuarios1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `botica`.`usuarios` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedidos_sedes1`
    FOREIGN KEY (`id_sede`)
    REFERENCES `botica`.`sedes` (`id_sede`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedidos_zona_envios1`
    FOREIGN KEY (`id_zona_envio`)
    REFERENCES `botica`.`zona_envios` (`id_zona_envio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `botica`.`detalle_Pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `botica`.`detalle_Pedidos` (
  `id_imagen_pedido` INT(11) NOT NULL,
  `id_pedido` INT(11) NOT NULL,
  INDEX `fk_imagenespedidos_has_pedidos_pedidos1_idx` (`id_pedido` ASC),
  INDEX `fk_imagenespedidos_has_pedidos_imagenespedidos1_idx` (`id_imagen_pedido` ASC),
  CONSTRAINT `fk_imagenespedidos_has_pedidos_imagenespedidos1`
    FOREIGN KEY (`id_imagen_pedido`)
    REFERENCES `botica`.`imagenes_pedidos` (`id_imagen_pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_imagenespedidos_has_pedidos_pedidos1`
    FOREIGN KEY (`id_pedido`)
    REFERENCES `botica`.`pedidos` (`id_pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `botica`.`calificaciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `botica`.`calificaciones` (
  `id_usuario` INT(11) NOT NULL,
  `calificacion` SMALLINT(1) NOT NULL,
  `id_sede` INT NOT NULL,
  `observacion` VARCHAR(255) NULL,
  PRIMARY KEY (`id_usuario`, `id_sede`),
  INDEX `fk_usuarios_has_usuarios_usuarios1_idx` (`id_usuario` ASC),
  INDEX `fk_calificaciones_sedes1_idx` (`id_sede` ASC),
  CONSTRAINT `fk_usuarios_has_usuarios_usuarios1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `botica`.`usuarios` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_calificaciones_sedes1`
    FOREIGN KEY (`id_sede`)
    REFERENCES `botica`.`sedes` (`id_sede`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `botica`.`respuesta_pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `botica`.`respuesta_pedido` (
  `id_respuesta_pedido` INT NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `tiempo_entrega` TIME(1) NOT NULL,
  `aceptado` TINYINT(1) NOT NULL,
  `id_pedido` INT(11) NOT NULL,
  `id_sede` INT NOT NULL,
  PRIMARY KEY (`id_respuesta_pedido`),
  INDEX `fk_respuesta_pedido_pedidos1_idx` (`id_pedido` ASC),
  INDEX `fk_respuesta_pedido_sedes1_idx` (`id_sede` ASC),
  CONSTRAINT `fk_respuesta_pedido_pedidos1`
    FOREIGN KEY (`id_pedido`)
    REFERENCES `botica`.`pedidos` (`id_pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_respuesta_pedido_sedes1`
    FOREIGN KEY (`id_sede`)
    REFERENCES `botica`.`sedes` (`id_sede`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `botica`.`facturas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `botica`.`facturas` (
  `id_factura` INT NOT NULL AUTO_INCREMENT,
  `codigo` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(200) NOT NULL,
  `total` INT NOT NULL,
  `id_vendedor` INT NOT NULL,
  `id_pedido` INT(11) NOT NULL,
  PRIMARY KEY (`id_factura`),
  INDEX `fk_facturas_sedes1_idx` (`id_vendedor` ASC),
  INDEX `fk_facturas_pedidos1_idx` (`id_pedido` ASC),
  CONSTRAINT `fk_facturas_sedes1`
    FOREIGN KEY (`id_vendedor`)
    REFERENCES `botica`.`sedes` (`id_sede`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_facturas_pedidos1`
    FOREIGN KEY (`id_pedido`)
    REFERENCES `botica`.`pedidos` (`id_pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `botica` ;

-- -----------------------------------------------------
-- Placeholder table for view `botica`.`login`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `botica`.`login` (`email` INT, `clave` INT, `id_rol` INT);

-- -----------------------------------------------------
-- View `botica`.`login`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `botica`.`login`;
USE `botica`;
CREATE  OR REPLACE VIEW `login` AS
select usuarios.email, usuarios.clave, roles.id_rol from usuarios
join roles
where usuarios.id_rol=roles.id_rol;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `botica`.`paises`
-- -----------------------------------------------------
START TRANSACTION;
USE `botica`;
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('ABW', 'ARUBA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('AFG', 'AFGHANISTAN');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('AGO', 'ANGOLA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('AIA', 'ANGUILLA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('ALB', 'ALBANIA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('AND', 'ANDORRA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('ANT', 'NETHERLANDS ANTILLES');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('ARE', 'UNITED ARAB EMIRATES');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('ARG', 'ARGENTINA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('ARM', 'ARMENIA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('ASM', 'AMERICAN SAMOA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('ATA', 'ANTARCTICA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('ATF', 'FRENCH SOUTHERN TERRITORIES');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('ATG', 'ANTIGUA AND BARBUDA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('AUS', 'AUSTRALIA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('AUT', 'AUSTRIA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('AZE', 'AZERBAIJAN');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('BDI', 'BURUNDI');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('BEL', 'BELGIUM');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('BEN', 'BENIN');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('BFA', 'BURKINA FASO');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('BGD', 'BANGLADESH');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('BGR', 'BULGARIA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('BHR', 'BAHRAIN');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('BHS', 'BAHAMAS');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('BIH', 'BOSNIA AND HERZEGOVINA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('BLR', 'BELARUS');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('BLZ', 'BELIZE');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('BMU', 'BERMUDA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('BOL', 'BOLIVIA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('BRA', 'BRAZIL');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('BRB', 'BARBADOS');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('BRN', 'BRUNEI');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('BTN', 'BHUTAN');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('BVT', 'BOUVET ISLAND');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('BWA', 'BOTSWANA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('CAF', 'CENTRAL AFRICAN REPUBLIC');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('CAN', 'CANADA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('CCK', 'COCOS (KEELING) ISLANDS');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('CHE', 'SWITZERLAND');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('CHL', 'CHILE');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('CHN', 'CHINA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('CIV', 'CÔTE DIVOIRE');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('CMR', 'CAMEROON');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('COD', 'CONGO');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('COG', 'CONGO');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('COK', 'COOK ISLANDS');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('COL', 'COLOMBIA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('COM', 'COMOROS');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('CPV', 'CAPE VERDE');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('CRI', 'COSTA RICA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('CUB', 'CUBA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('CXR', 'CHRISTMAS ISLAND');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('CYM', 'CAYMAN ISLANDS');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('CYP', 'CYPRUS');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('CZE', 'CZECH REPUBLIC');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('DEU', 'GERMANY');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('DJI', 'DJIBOUTI');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('DMA', 'DOMINICA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('DNK', 'DENMARK');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('DOM', 'DOMINICAN REPUBLIC');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('DZA', 'ALGERIA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('ECU', 'ECUADOR');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('EGY', 'EGYPT');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('ERI', 'ERITREA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('ESH', 'WESTERN SAHARA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('ESP', 'SPAIN');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('EST', 'ESTONIA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('ETH', 'ETHIOPIA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('FIN', 'FINLAND');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('FJI', 'FIJI ISLANDS');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('FLK', 'FALKLAND ISLANDS');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('FRA', 'FRANCE');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('FRO', 'FAROE ISLANDS');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('FSM', 'MICRONESIA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('GAB', 'GABON');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('GBR', 'UNITED KINGDOM');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('GEO', 'GEORGIA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('GHA', 'GHANA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('GIB', 'GIBRALTAR');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('GIN', 'GUINEA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('GLP', 'GUADELOUPE');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('GMB', 'GAMBIA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('GNB', 'GUINEA-BISSAU');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('GNQ', 'EQUATORIAL GUINEA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('GRC', 'GREECE');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('GRD', 'GRENADA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('GRL', 'GREENLAND');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('GTM', 'GUATEMALA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('GUF', 'FRENCH GUIANA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('GUM', 'GUAM');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('GUY', 'GUYANA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('HKG', 'HONG KONG');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('HMD', 'HEARD ISLAND AND MCDONALD ISLANDS');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('HND', 'HONDURAS');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('HRV', 'CROATIA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('HTI', 'HAITI');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('HUN', 'HUNGARY');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('IDN', 'INDONESIA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('IND', 'INDIA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('IOT', 'BRITISH INDIAN OCEAN TERRITORY');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('IRL', 'IRELAND');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('IRN', 'IRAN');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('IRQ', 'IRAQ');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('ISL', 'ICELAND');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('ISR', 'ISRAEL');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('ITA', 'ITALY');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('JAM', 'JAMAICA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('JOR', 'JORDAN');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('JPN', 'JAPAN');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('KAZ', 'KAZAKSTAN');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('KEN', 'KENYA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('KGZ', 'KYRGYZSTAN');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('KHM', 'CAMBODIA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('KIR', 'KIRIBATI');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('KNA', 'SAINT KITTS AND NEVIS');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('KOR', 'SOUTH KOREA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('KWT', 'KUWAIT');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('LAO', 'LAOS');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('LBN', 'LEBANON');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('LBR', 'LIBERIA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('LBY', 'LIBYAN ARAB JAMAHIRIYA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('LCA', 'SAINT LUCIA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('LIE', 'LIECHTENSTEIN');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('LKA', 'SRI LANKA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('LSO', 'LESOTHO');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('LTU', 'LITHUANIA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('LUX', 'LUXEMBOURG');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('LVA', 'LATVIA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('MAC', 'MACAO');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('MAR', 'MOROCCO');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('MCO', 'MONACO');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('MDA', 'MOLDOVA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('MDG', 'MADAGASCAR');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('MDV', 'MALDIVES');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('MEX', 'MEXICO');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('MHL', 'MARSHALL ISLANDS');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('MKD', 'MACEDONIA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('MLI', 'MALI');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('MLT', 'MALTA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('MMR', 'MYANMAR');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('MNG', 'MONGOLIA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('MNP', 'NORTHERN MARIANA ISLANDS');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('MOZ', 'MOZAMBIQUE');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('MRT', 'MAURITANIA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('MSR', 'MONTSERRAT');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('MTQ', 'MARTINIQUE');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('MUS', 'MAURITIUS');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('MWI', 'MALAWI');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('MYS', 'MALAYSIA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('MYT', 'MAYOTTE');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('NAM', 'NAMIBIA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('NCL', 'NEW CALEDONIA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('NER', 'NIGER');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('NFK', 'NORFOLK ISLAND');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('NGA', 'NIGERIA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('NIC', 'NICARAGUA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('NIU', 'NIUE');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('NLD', 'NETHERLANDS');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('NOR', 'NORWAY');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('NPL', 'NEPAL');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('NRU', 'NAURU');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('NZL', 'NEW ZEALAND');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('OMN', 'OMAN');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('PAK', 'PAKISTAN');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('PAN', 'PANAMA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('PCN', 'PITCAIRN');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('PER', 'PERU');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('PHL', 'PHILIPPINES');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('PLW', 'PALAU');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('PNG', 'PAPUA NEW GUINEA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('POL', 'POLAND');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('PRI', 'PUERTO RICO');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('PRK', 'NORTH KOREA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('PRT', 'PORTUGAL');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('PRY', 'PARAGUAY');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('PSE', 'PALESTINE');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('PYF', 'FRENCH POLYNESIA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('QAT', 'QATAR');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('REU', 'RÉUNION');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('ROM', 'ROMANIA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('RUS', 'RUSSIAN FEDERATION');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('RWA', 'RWANDA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('SAU', 'SAUDI ARABIA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('SDN', 'SUDAN');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('SEN', 'SENEGAL');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('SGP', 'SINGAPORE');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('SGS', 'SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('SHN', 'SAINT HELENA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('SJM', 'SVALBARD AND JAN MAYEN');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('SLB', 'SOLOMON ISLANDS');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('SLE', 'SIERRA LEONE');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('SLV', 'EL SALVADOR');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('SMR', 'SAN MARINO');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('SOM', 'SOMALIA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('SPM', 'SAINT PIERRE AND MIQUELON');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('STP', 'SAO TOME AND PRINCIPE');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('SUR', 'SURINAME');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('SVK', 'SLOVAKIA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('SVN', 'SLOVENIA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('SWE', 'SWEDEN');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('SWZ', 'SWAZILAND');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('SYC', 'SEYCHELLES');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('SYR', 'SYRIA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('TCA', 'TURKS AND CAICOS ISLANDS');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('TCD', 'CHAD');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('TGO', 'TOGO');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('THA', 'THAILAND');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('TJK', 'TAJIKISTAN');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('TKL', 'TOKELAU');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('TKM', 'TURKMENISTAN');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('TMP', 'EAST TIMOR');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('TON', 'TONGA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('TTO', 'TRINIDAD AND TOBAGO');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('TUN', 'TUNISIA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('TUR', 'TURKEY');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('TUV', 'TUVALU');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('TWN', 'TAIWAN');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('TZA', 'TANZANIA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('UGA', 'UGANDA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('UKR', 'UKRAINE');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('UMI', 'UNITED STATES MINOR OUTLYING ISLANDS');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('URY', 'URUGUAY');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('USA', 'UNITED STATES');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('UZB', 'UZBEKISTAN');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('VAT', 'HOLY SEE (VATICAN CITY STATE)');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('VCT', 'SAINT VINCENT AND THE GRENADINES');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('VEN', 'VENEZUELA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('VGB', 'VIRGIN ISLANDS');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('VIR', 'VIRGIN ISLANDS');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('VNM', 'VIETNAM');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('VUT', 'VANUATU');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('WLF', 'WALLIS AND FUTUNA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('WSM', 'SAMOA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('YEM', 'YEMEN');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('YUG', 'YUGOSLAVIA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('ZAF', 'SOUTH AFRICA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('ZMB', 'ZAMBIA');
INSERT INTO `botica`.`paises` (`id_pais`, `nombre`) VALUES ('ZWE', 'ZIMBABWE');

COMMIT;


-- -----------------------------------------------------
-- Data for table `botica`.`departamentos`
-- -----------------------------------------------------
START TRANSACTION;
USE `botica`;
INSERT INTO `botica`.`departamentos` (`id_departamento`, `nombre`, `id_pais`) VALUES (5, 'ANTIOQUIA', 'COL');
INSERT INTO `botica`.`departamentos` (`id_departamento`, `nombre`, `id_pais`) VALUES (8, 'ATLANTICO', 'COL');
INSERT INTO `botica`.`departamentos` (`id_departamento`, `nombre`, `id_pais`) VALUES (11, 'BOGOTA', 'COL');
INSERT INTO `botica`.`departamentos` (`id_departamento`, `nombre`, `id_pais`) VALUES (13, 'BOLIVAR', 'COL');
INSERT INTO `botica`.`departamentos` (`id_departamento`, `nombre`, `id_pais`) VALUES (15, 'BOYACA', 'COL');
INSERT INTO `botica`.`departamentos` (`id_departamento`, `nombre`, `id_pais`) VALUES (17, 'CALDAS', 'COL');
INSERT INTO `botica`.`departamentos` (`id_departamento`, `nombre`, `id_pais`) VALUES (18, 'CAQUETA', 'COL');
INSERT INTO `botica`.`departamentos` (`id_departamento`, `nombre`, `id_pais`) VALUES (19, 'CAUCA', 'COL');
INSERT INTO `botica`.`departamentos` (`id_departamento`, `nombre`, `id_pais`) VALUES (20, 'CESAR', 'COL');
INSERT INTO `botica`.`departamentos` (`id_departamento`, `nombre`, `id_pais`) VALUES (23, 'CORDOBA', 'COL');
INSERT INTO `botica`.`departamentos` (`id_departamento`, `nombre`, `id_pais`) VALUES (25, 'CUNDINAMARCA', 'COL');
INSERT INTO `botica`.`departamentos` (`id_departamento`, `nombre`, `id_pais`) VALUES (27, 'CHOCO', 'COL');
INSERT INTO `botica`.`departamentos` (`id_departamento`, `nombre`, `id_pais`) VALUES (41, 'HUILA', 'COL');
INSERT INTO `botica`.`departamentos` (`id_departamento`, `nombre`, `id_pais`) VALUES (44, 'LA GUAJIRA', 'COL');
INSERT INTO `botica`.`departamentos` (`id_departamento`, `nombre`, `id_pais`) VALUES (47, 'MAGDALENA', 'COL');
INSERT INTO `botica`.`departamentos` (`id_departamento`, `nombre`, `id_pais`) VALUES (50, 'META', 'COL');
INSERT INTO `botica`.`departamentos` (`id_departamento`, `nombre`, `id_pais`) VALUES (52, 'NARIÑO', 'COL');
INSERT INTO `botica`.`departamentos` (`id_departamento`, `nombre`, `id_pais`) VALUES (54, 'N. DE SANTANDER', 'COL');
INSERT INTO `botica`.`departamentos` (`id_departamento`, `nombre`, `id_pais`) VALUES (63, 'QUINDIO', 'COL');
INSERT INTO `botica`.`departamentos` (`id_departamento`, `nombre`, `id_pais`) VALUES (66, 'RISARALDA', 'COL');
INSERT INTO `botica`.`departamentos` (`id_departamento`, `nombre`, `id_pais`) VALUES (68, 'SANTANDER', 'COL');
INSERT INTO `botica`.`departamentos` (`id_departamento`, `nombre`, `id_pais`) VALUES (70, 'SUCRE', 'COL');
INSERT INTO `botica`.`departamentos` (`id_departamento`, `nombre`, `id_pais`) VALUES (73, 'TOLIMA', 'COL');
INSERT INTO `botica`.`departamentos` (`id_departamento`, `nombre`, `id_pais`) VALUES (76, 'VALLE DEL CAUCA', 'COL');
INSERT INTO `botica`.`departamentos` (`id_departamento`, `nombre`, `id_pais`) VALUES (81, 'ARAUCA', 'COL');
INSERT INTO `botica`.`departamentos` (`id_departamento`, `nombre`, `id_pais`) VALUES (85, 'CASANARE', 'COL');
INSERT INTO `botica`.`departamentos` (`id_departamento`, `nombre`, `id_pais`) VALUES (86, 'PUTUMAYO', 'COL');
INSERT INTO `botica`.`departamentos` (`id_departamento`, `nombre`, `id_pais`) VALUES (88, 'SAN ANDRES', 'COL');
INSERT INTO `botica`.`departamentos` (`id_departamento`, `nombre`, `id_pais`) VALUES (91, 'AMAZONAS', 'COL');
INSERT INTO `botica`.`departamentos` (`id_departamento`, `nombre`, `id_pais`) VALUES (94, 'GUAINIA', 'COL');
INSERT INTO `botica`.`departamentos` (`id_departamento`, `nombre`, `id_pais`) VALUES (95, 'GUAVIARE', 'COL');
INSERT INTO `botica`.`departamentos` (`id_departamento`, `nombre`, `id_pais`) VALUES (97, 'VAUPES', 'COL');
INSERT INTO `botica`.`departamentos` (`id_departamento`, `nombre`, `id_pais`) VALUES (99, 'VICHADA', 'COL');

COMMIT;


-- -----------------------------------------------------
-- Data for table `botica`.`ciudades`
-- -----------------------------------------------------
START TRANSACTION;
USE `botica`;
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (1, 'MEDELLÍN', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (1, 'BARRANQUILLA', 8);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (1, 'BOGOTÁ, D.C.', 11);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (1, 'CARTAGENA', 13);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (1, 'TUNJA', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (1, 'MANIZALES', 17);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (1, 'FLORENCIA', 18);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (1, 'POPAYÁN', 19);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (1, 'VALLEDUPAR', 20);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (1, 'MONTERÍA', 23);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (1, 'AGUA DE DIOS', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (1, 'QUIBDÓ', 27);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (1, 'NEIVA', 41);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (1, 'RIOHACHA', 44);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (1, 'SANTA MARTA', 47);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (1, 'VILLAVICENCIO', 50);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (1, 'PASTO', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (1, 'CÚCUTA', 54);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (1, 'ARMENIA', 63);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (1, 'PEREIRA', 66);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (1, 'BUCARAMANGA', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (1, 'SINCELEJO', 70);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (1, 'IBAGUÉ', 73);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (1, 'CALI', 76);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (1, 'ARAUCA', 81);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (1, 'YOPAL', 85);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (1, 'MOCOA', 86);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (1, 'SAN ANDRÉS', 88);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (1, 'LETICIA', 91);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (1, 'INÍRIDA', 94);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (1, 'SAN JOSÉ DEL GUAVIARE', 95);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (1, 'MITÚ', 97);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (1, 'PUERTO CARREÑO', 99);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (2, 'ABEJORRAL', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (3, 'ABREGO', 54);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (4, 'ABRIAQUÍ', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (6, 'ACHÍ', 13);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (6, 'ACANDÍ', 27);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (6, 'ACEVEDO', 41);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (6, 'ACACÍAS', 50);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (10, 'AGUAZUL', 85);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (11, 'AGUACHICA', 20);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (13, 'AGUADAS', 17);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (13, 'AGUSTÍN CODAZZI', 20);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (13, 'AGRADO', 41);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (13, 'AGUADA', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (15, 'CHAMEZA', 85);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (15, 'CALAMAR', 95);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (16, 'AIPE', 41);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (19, 'ALBÁN', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (19, 'ALBÁN', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (20, 'ALGECIRAS', 41);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (20, 'ALBANIA', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (20, 'ALCALÁ', 76);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (21, 'ALEJANDRÍA', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (22, 'ALMEIDA', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (22, 'ALMAGUER', 19);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (22, 'ALDANA', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (24, 'ALPUJARRA', 73);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (25, 'ALTO BAUDÓ', 27);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (25, 'EL RETORNO', 95);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (26, 'ALTAMIRA', 41);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (26, 'ALVARADO', 73);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (29, 'ALBANIA', 18);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (30, 'AMAGÁ', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (30, 'ALTOS DEL ROSARIO', 13);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (30, 'ALGARROBO', 47);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (30, 'AMBALEMA', 73);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (31, 'AMALFI', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (32, 'ASTREA', 20);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (34, 'ANDES', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (35, 'ANAPOIMA', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (35, 'ALBANIA', 44);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (36, 'ANGELÓPOLIS', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (36, 'ANCUYÁ', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (36, 'ANDALUCÍA', 76);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (38, 'ANGOSTURA', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (40, 'ANORÍ', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (40, 'ANOLAIMA', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (41, 'ANSERMANUEVO', 76);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (42, 'SANTAFÉ DE ANTIOQUIA', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (42, 'ARENAL', 13);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (42, 'ANSERMA', 17);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (43, 'ANZOÁTEGUI', 73);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (44, 'ANZA', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (45, 'APARTADÓ', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (45, 'BECERRIL', 20);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (45, 'APÍA', 66);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (47, 'AQUITANIA', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (50, 'ARANZAZU', 17);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (50, 'ARGELIA', 19);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (50, 'ATRATO', 27);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (51, 'ARBOLETES', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (51, 'ARCABUCO', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (51, 'ARBOLEDA', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (51, 'ARBOLEDAS', 54);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (51, 'ARATOCA', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (52, 'ARJONA', 13);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (53, 'ARBELÁEZ', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (53, 'ARACATACA', 47);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (54, 'ARGELIA', 76);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (55, 'ARGELIA', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (55, 'ARMERO', 73);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (58, 'ARIGUANÍ', 47);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (59, 'ARMENIA', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (60, 'BOSCONIA', 20);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (62, 'ARROYOHONDO', 13);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (65, 'ARAUQUITA', 81);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (67, 'ATACO', 73);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (68, 'AYAPEL', 23);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (73, 'BAGADÓ', 27);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (74, 'BARRANCO DE LOBA', 13);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (75, 'BALBOA', 19);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (75, 'BAHÍA SOLANO', 27);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (75, 'BALBOA', 66);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (77, 'BAJO BAUDÓ', 27);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (77, 'BARBOSA', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (78, 'BARANOA', 8);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (78, 'BARAYA', 41);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (78, 'BARRANCAS', 44);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (79, 'BARBOSA', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (79, 'BUENAVISTA', 23);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (79, 'BARBACOAS', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (79, 'BARICHARA', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (81, 'BARRANCABERMEJA', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (83, 'BELÉN', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (86, 'BELMIRA', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (86, 'BELTRÁN', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (87, 'BELÉN', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (88, 'BELLO', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (88, 'BELALCÁZAR', 17);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (88, 'BELÉN DE UMBRÍA', 66);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (90, 'BERBEO', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (90, 'CANALETE', 23);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (90, 'DIBULLA', 44);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (91, 'BETANIA', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (92, 'BETÉITIVA', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (92, 'BETULIA', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (93, 'BETULIA', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (94, 'BELÉN DE LOS ANDAQUÍES', 18);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (95, 'BITUIMA', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (97, 'BOAVITA', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (98, 'DISTRACCIÓN', 44);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (99, 'BOJACÁ', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (99, 'BOJAYA', 27);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (99, 'BOCHALEMA', 54);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (100, 'BOLÍVAR', 19);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (100, 'BOLÍVAR', 76);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (101, 'CIUDAD BOLÍVAR', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (101, 'BOLÍVAR', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (104, 'BOYACÁ', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (106, 'BRICEÑO', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (107, 'BRICEÑO', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (109, 'BUENAVISTA', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (109, 'BUCARASICA', 54);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (109, 'BUENAVENTURA', 76);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (110, 'BUENOS AIRES', 19);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (110, 'EL MOLINO', 44);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (110, 'BARRANCA DE UPÍA', 50);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (110, 'BUESACO', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (110, 'BUENAVISTA', 70);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (111, 'BUENAVISTA', 63);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (111, 'GUADALAJARA DE BUGA', 76);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (113, 'BURITICÁ', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (113, 'BUGALAGRANDE', 76);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (114, 'BUSBANZÁ', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (120, 'CÁCERES', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (120, 'CABRERA', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (121, 'CABRERA', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (122, 'CAICEDONIA', 76);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (123, 'CACHIPAY', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (124, 'CABUYARO', 50);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (124, 'CAIMITO', 70);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (124, 'CAJAMARCA', 73);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (125, 'CAICEDO', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (125, 'CÁCOTA', 54);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (125, 'HATO COROZAL', 85);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (126, 'CAJICÁ', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (126, 'CALIMA', 76);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (128, 'CACHIRÁ', 54);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (129, 'CALDAS', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (130, 'CAJIBÍO', 19);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (130, 'CALARCA', 63);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (130, 'CANDELARIA', 76);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (131, 'CALDAS', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (132, 'CAMPOALEGRE', 41);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (132, 'CALIFORNIA', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (134, 'CAMPAMENTO', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (135, 'CAMPOHERMOSO', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (135, 'EL CANTÓN DEL SAN PABLO', 27);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (136, 'LA SALINA', 85);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (137, 'CAMPO DE LA CRUZ', 8);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (137, 'CALDONO', 19);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (138, 'CAÑASGORDAS', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (139, 'MANÍ', 85);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (140, 'CALAMAR', 13);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (141, 'CANDELARIA', 8);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (142, 'CARACOLÍ', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (142, 'CALOTO', 19);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (145, 'CARAMANTA', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (147, 'CAREPA', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (147, 'CAPITANEJO', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (147, 'CARTAGO', 76);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (148, 'EL CARMEN DE VIBORAL', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (148, 'CAPARRAPÍ', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (148, 'CARMEN DE APICALÁ', 73);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (150, 'CAROLINA', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (150, 'CARTAGENA DEL CHAIRÁ', 18);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (150, 'CARMEN DEL DARIÉN', 27);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (150, 'CASTILLA LA NUEVA', 50);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (151, 'CAQUEZA', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (152, 'CARCASÍ', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (152, 'CASABIANCA', 73);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (154, 'CAUCASIA', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (154, 'CARMEN DE CARUPA', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (160, 'CANTAGALLO', 13);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (160, 'CÉRTEGUI', 27);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (160, 'CEPITÁ', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (161, 'CERRO SAN ANTONIO', 47);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (161, 'CARURU', 97);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (162, 'CERINZA', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (162, 'CERETÉ', 23);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (162, 'CERRITO', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (162, 'MONTERREY', 85);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (167, 'CHARALÁ', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (168, 'CHIMÁ', 23);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (168, 'CHAGUANÍ', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (168, 'CHAPARRAL', 73);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (169, 'CHARTA', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (170, 'CHIVOLO', 47);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (170, 'DOSQUEBRADAS', 66);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (172, 'CHIGORODÓ', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (172, 'CHINAVITA', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (172, 'CHINÁCOTA', 54);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (174, 'CHINCHINÁ', 17);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (174, 'CHITAGÁ', 54);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (175, 'CHIMICHAGUA', 20);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (175, 'CHÍA', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (176, 'CHIQUINQUIRÁ', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (176, 'CHIMA', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (178, 'CHIRIGUANÁ', 20);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (178, 'CHIPAQUE', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (179, 'CHIPATÁ', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (180, 'CHISCAS', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (181, 'CHOACHÍ', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (182, 'CHINÚ', 23);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (183, 'CHITA', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (183, 'CHOCONTÁ', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (185, 'CHITARAQUE', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (187, 'CHIVATÁ', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (188, 'CICUCO', 13);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (189, 'CIÉNEGA', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (189, 'CIÉNAGA DE ORO', 23);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (189, 'CIÉNAGA', 47);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (190, 'CISNEROS', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (190, 'CIRCASIA', 63);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (190, 'CIMITARRA', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (197, 'COCORNÁ', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (200, 'COGUA', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (200, 'COELLO', 73);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (200, 'MIRAFLORES', 95);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (203, 'COLÓN', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (204, 'CÓMBITA', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (204, 'COLOSO', 70);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (205, 'CURILLO', 18);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (205, 'CONDOTO', 27);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (205, 'CONCORDIA', 47);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (206, 'CONCEPCIÓN', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (206, 'COLOMBIA', 41);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (206, 'CONVENCIÓN', 54);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (207, 'CONSACA', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (207, 'CONCEPCIÓN', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (209, 'CONCORDIA', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (209, 'CONFINES', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (210, 'CONTADERO', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (211, 'CONTRATACIÓN', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (212, 'COPACABANA', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (212, 'CÓRDOBA', 13);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (212, 'COPER', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (212, 'CORINTO', 19);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (212, 'CÓRDOBA', 63);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (214, 'COTA', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (215, 'CORRALES', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (215, 'CÓRDOBA', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (215, 'COROZAL', 70);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (217, 'COROMORO', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (217, 'COYAIMA', 73);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (218, 'COVARACHÍA', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (219, 'COLÓN', 86);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (220, 'CRAVO NORTE', 81);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (221, 'COVEÑAS', 70);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (222, 'CLEMENCIA', 13);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (223, 'CUBARÁ', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (223, 'CUBARRAL', 50);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (223, 'CUCUTILLA', 54);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (224, 'CUCAITA', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (224, 'CUCUNUBÁ', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (224, 'CUASPUD', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (225, 'NUNCHÍA', 85);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (226, 'CUÍTIVA', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (226, 'CUMARAL', 50);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (226, 'CUNDAY', 73);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (227, 'CUMBAL', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (228, 'CURUMANÍ', 20);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (229, 'CURITÍ', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (230, 'CHALÁN', 70);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (230, 'OROCUÉ', 85);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (232, 'CHÍQUIZA', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (233, 'CUMBITARA', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (233, 'EL ROBLE', 70);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (233, 'DAGUA', 76);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (234, 'DABEIBA', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (235, 'EL CARMEN DE CHUCURÍ', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (235, 'GALERAS', 70);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (236, 'CHIVOR', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (236, 'DOLORES', 73);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (237, 'DONMATÍAS', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (238, 'DUITAMA', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (238, 'EL COPEY', 20);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (239, 'DURANIA', 54);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (240, 'EBÉJICO', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (240, 'CHACHAGÜÍ', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (243, 'EL ÁGUILA', 76);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (244, 'EL CARMEN DE BOLÍVAR', 13);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (244, 'EL COCUY', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (244, 'ELÍAS', 41);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (245, 'EL COLEGIO', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (245, 'EL CARMEN DE ATRATO', 27);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (245, 'EL BANCO', 47);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (245, 'EL CALVARIO', 50);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (245, 'EL CARMEN', 54);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (245, 'EL GUACAMAYO', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (246, 'EL CAIRO', 76);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (247, 'EL DONCELLO', 18);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (248, 'EL GUAMO', 13);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (248, 'EL ESPINO', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (248, 'EL CERRITO', 76);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (250, 'EL BAGRE', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (250, 'EL PASO', 20);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (250, 'EL LITORAL DEL SAN JUAN', 27);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (250, 'EL CHARCO', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (250, 'EL TARRA', 54);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (250, 'EL PEÑÓN', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (250, 'EL DOVIO', 76);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (250, 'PAZ DE ARIPORO', 85);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (251, 'EL CASTILLO', 50);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (254, 'EL PEÑOL', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (255, 'EL PLAYÓN', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (256, 'EL PAUJIL', 18);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (256, 'EL TAMBO', 19);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (256, 'EL ROSARIO', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (258, 'EL PEÑÓN', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (258, 'EL PIÑON', 47);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (258, 'EL TABLÓN DE GÓMEZ', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (260, 'EL ROSAL', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (260, 'EL TAMBO', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (261, 'EL ZULIA', 54);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (263, 'PORE', 85);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (263, 'EL ENCANTO', 91);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (264, 'ENTRERRIOS', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (264, 'ENCINO', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (265, 'GUARANDA', 70);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (266, 'ENVIGADO', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (266, 'ENCISO', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (268, 'EL PEÑÓN', 13);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (268, 'EL RETÉN', 47);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (268, 'ESPINAL', 73);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (269, 'FACATATIVÁ', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (270, 'EL DORADO', 50);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (270, 'FALAN', 73);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (271, 'FLORIÁN', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (272, 'FIRAVITOBA', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (272, 'FILADELFIA', 17);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (272, 'FILANDIA', 63);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (275, 'FLANDES', 73);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (275, 'FLORIDA', 76);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (276, 'FLORESTA', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (276, 'FLORIDABLANCA', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (279, 'FOMEQUE', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (279, 'FONSECA', 44);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (279, 'RECETOR', 85);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (281, 'FOSCA', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (282, 'FREDONIA', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (283, 'FRESNO', 73);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (284, 'FRONTINO', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (286, 'FUNZA', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (287, 'FUENTE DE ORO', 50);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (287, 'FUNES', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (288, 'FÚQUENE', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (288, 'FUNDACIÓN', 47);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (290, 'FLORENCIA', 19);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (290, 'FUSAGASUGÁ', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (293, 'GACHANTIVÁ', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (293, 'GACHALA', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (295, 'GAMARRA', 20);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (295, 'GACHANCIPÁ', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (296, 'GALAPA', 8);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (296, 'GAMEZA', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (296, 'GALÁN', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (297, 'GACHETÁ', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (298, 'GARZÓN', 41);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (298, 'GAMBITA', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (299, 'GARAGOA', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (299, 'GAMA', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (300, 'HATILLO DE LOBA', 13);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (300, 'GUACHENÉ', 19);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (300, 'COTORRA', 23);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (300, 'FORTUL', 81);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (300, 'SABANALARGA', 85);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (302, 'GÉNOVA', 63);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (306, 'GIRALDO', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (306, 'GIGANTE', 41);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (306, 'GINEBRA', 76);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (307, 'GIRARDOT', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (307, 'GIRÓN', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (308, 'GIRARDOTA', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (310, 'GÓMEZ PLATA', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (310, 'GONZÁLEZ', 20);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (312, 'GRANADA', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (313, 'GRANADA', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (313, 'GRANADA', 50);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (313, 'GRAMALOTE', 54);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (315, 'GUADALUPE', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (315, 'SÁCAMA', 85);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (317, 'GUACAMAYAS', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (317, 'GUACHETÁ', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (317, 'GUACHUCAL', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (318, 'GUARNE', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (318, 'GUAPI', 19);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (318, 'GUAMAL', 47);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (318, 'GUAMAL', 50);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (318, 'GUÁTICA', 66);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (318, 'GUACA', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (318, 'GUACARÍ', 76);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (319, 'GUADALUPE', 41);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (319, 'GUAMO', 73);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (320, 'GUADUAS', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (320, 'GUAITARILLA', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (320, 'GUADALUPE', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (320, 'ORITO', 86);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (321, 'GUATAPE', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (322, 'GUATEQUE', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (322, 'GUASCA', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (322, 'GUAPOTÁ', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (323, 'GUALMATÁN', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (324, 'GUATAQUÍ', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (324, 'GUAVATÁ', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (325, 'GUAYATÁ', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (325, 'MAPIRIPÁN', 50);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (325, 'SAN LUIS DE PALENQUE', 85);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (326, 'GUATAVITA', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (327, 'GÜEPSA', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (328, 'GUAYABAL DE SIQUIMA', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (330, 'MESETAS', 50);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (332, 'GÜICÁN', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (335, 'GUAYABETAL', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (339, 'GUTIÉRREZ', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (343, 'BARRANCO MINAS', 94);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (344, 'HACARÍ', 54);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (344, 'HATO', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (347, 'HELICONIA', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (347, 'HERRÁN', 54);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (347, 'HERVEO', 73);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (349, 'HOBO', 41);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (349, 'HONDA', 73);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (350, 'LA APARTADA', 23);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (350, 'LA MACARENA', 50);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (352, 'ILES', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (352, 'ICONONZO', 73);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (353, 'HISPANIA', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (354, 'IMUÉS', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (355, 'INZÁ', 19);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (356, 'IPIALES', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (357, 'IQUIRA', 41);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (359, 'ISNOS', 41);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (360, 'ITAGUI', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (361, 'ITUANGO', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (361, 'ISTMINA', 27);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (362, 'IZA', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (364, 'JARDÍN', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (364, 'JAMBALÓ', 19);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (364, 'JAMUNDÍ', 76);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (367, 'JENESANO', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (368, 'JERICÓ', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (368, 'JERICÓ', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (368, 'JERUSALÉN', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (368, 'JESÚS MARÍA', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (370, 'URIBE', 50);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (370, 'JORDÁN', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (372, 'JUAN DE ACOSTA', 8);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (372, 'JUNÍN', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (372, 'JURADÓ', 27);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (376, 'LA CEJA', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (377, 'LABRANZAGRANDE', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (377, 'LA CALERA', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (377, 'LABATECA', 54);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (377, 'LA BELLEZA', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (377, 'LA CUMBRE', 76);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (378, 'LA ARGENTINA', 41);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (378, 'HATONUEVO', 44);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (378, 'LA CRUZ', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (380, 'LA ESTRELLA', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (380, 'LA CAPILLA', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (380, 'LA DORADA', 17);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (381, 'LA FLORIDA', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (383, 'LA GLORIA', 20);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (383, 'LA CELIA', 66);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (385, 'LA LLANADA', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (385, 'LA ESPERANZA', 54);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (385, 'LANDÁZURI', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (386, 'LA MESA', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (388, 'LA MERCED', 17);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (390, 'LA PINTADA', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (390, 'LA TOLA', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (392, 'LA SIERRA', 19);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (394, 'LA PALMA', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (396, 'LA PLATA', 41);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (397, 'LA VEGA', 19);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (397, 'LA PAZ', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (398, 'LA PEÑA', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (398, 'LA PLAYA', 54);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (399, 'LA UNIÓN', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (400, 'LA UNIÓN', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (400, 'LA JAGUA DE IBIRICO', 20);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (400, 'LEJANÍAS', 50);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (400, 'LA VIRGINIA', 66);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (400, 'LA UNIÓN', 70);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (400, 'LA UNIÓN', 76);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (400, 'TÁMARA', 85);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (401, 'LA VICTORIA', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (401, 'LA TEBAIDA', 63);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (402, 'LA VEGA', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (403, 'LA UVITA', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (403, 'LA VICTORIA', 76);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (405, 'LEIVA', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (405, 'LOS PATIOS', 54);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (405, 'LA CHORRERA', 91);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (406, 'LEBRIJA', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (407, 'VILLA DE LEYVA', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (407, 'LENGUAZAQUE', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (407, 'LA PEDRERA', 91);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (408, 'LÉRIDA', 73);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (410, 'LA MONTAÑITA', 18);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (410, 'TAURAMENA', 85);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (411, 'LIBORINA', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (411, 'LINARES', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (411, 'LÍBANO', 73);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (413, 'LLORÓ', 27);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (417, 'LORICA', 23);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (418, 'LÓPEZ', 19);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (418, 'LOS ANDES', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (418, 'LOURDES', 54);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (418, 'LOS SANTOS', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (418, 'LOS PALMITOS', 70);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (419, 'LOS CÓRDOBAS', 23);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (420, 'LA JAGUA DEL PILAR', 44);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (421, 'LURUACO', 8);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (425, 'MACEO', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (425, 'MACANAL', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (425, 'MEDIO ATRATO', 27);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (425, 'MACARAVITA', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (426, 'MACHETA', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (427, 'MAGÜI', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (429, 'MAJAGUAL', 70);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (430, 'MAGANGUÉ', 13);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (430, 'MADRID', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (430, 'MEDIO BAUDÓ', 27);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (430, 'MAICAO', 44);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (430, 'TRINIDAD', 85);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (430, 'LA VICTORIA', 91);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (432, 'MÁLAGA', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (433, 'MALAMBO', 8);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (433, 'MAHATES', 13);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (433, 'MANZANARES', 17);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (435, 'MALLAMA', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (436, 'MANATÍ', 8);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (436, 'MANTA', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (438, 'MEDINA', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (440, 'MARINILLA', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (440, 'MARGARITA', 13);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (440, 'MARSELLA', 66);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (440, 'VILLANUEVA', 85);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (442, 'MARÍA LA BAJA', 13);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (442, 'MARIPÍ', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (442, 'MARMATO', 17);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (443, 'MANAURE', 20);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (443, 'SAN SEBASTIÁN DE MARIQUITA', 73);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (444, 'MARQUETALIA', 17);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (444, 'MATANZA', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (446, 'MARULANDA', 17);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (449, 'MELGAR', 73);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (450, 'MERCADERES', 19);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (450, 'MEDIO SAN JUAN', 27);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (450, 'PUERTO CONCORDIA', 50);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (455, 'MIRAFLORES', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (455, 'MIRANDA', 19);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (456, 'MISTRATÓ', 66);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (458, 'MONTECRISTO', 13);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (460, 'MILÁN', 18);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (460, 'NUEVA GRANADA', 47);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (460, 'MIRITI - PARANÁ', 91);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (461, 'MURILLO', 73);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (464, 'MONGUA', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (464, 'MOMIL', 23);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (464, 'MOGOTES', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (466, 'MONGUÍ', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (466, 'MONTELÍBANO', 23);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (467, 'MONTEBELLO', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (468, 'MOMPÓS', 13);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (468, 'MOLAGAVITA', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (469, 'MONIQUIRÁ', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (470, 'MONTENEGRO', 63);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (473, 'MORALES', 13);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (473, 'MORALES', 19);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (473, 'MOSQUERA', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (473, 'MOSQUERA', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (473, 'MORROA', 70);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (475, 'MURINDÓ', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (476, 'MOTAVITA', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (479, 'MORELIA', 18);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (480, 'MUTATÁ', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (480, 'MUZO', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (480, 'NARIÑO', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (480, 'MUTISCUA', 54);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (483, 'NARIÑO', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (483, 'NARIÑO', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (483, 'NÁTAGA', 41);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (483, 'NATAGAIMA', 73);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (486, 'NEIRA', 17);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (486, 'NEMOCÓN', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (488, 'NILO', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (489, 'NIMAIMA', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (490, 'NECOCLÍ', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (490, 'NOROSÍ', 13);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (490, 'OLAYA HERRERA', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (491, 'NOBSA', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (491, 'NOCAIMA', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (491, 'NÓVITA', 27);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (494, 'NUEVO COLÓN', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (495, 'NECHÍ', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (495, 'NORCASIA', 17);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (495, 'NUQUÍ', 27);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (497, 'OBANDO', 76);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (498, 'OCAÑA', 54);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (498, 'OCAMONTE', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (500, 'OICATÁ', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (500, 'MOÑITOS', 23);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (500, 'OIBA', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (501, 'OLAYA', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (502, 'ONZAGA', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (503, 'OPORAPA', 41);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (504, 'ORTEGA', 73);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (506, 'VENECIA', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (506, 'OSPINA', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (507, 'OTANCHE', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (508, 'OVEJAS', 70);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (511, 'PACHAVITA', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (511, 'PACOA', 97);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (513, 'PÁCORA', 17);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (513, 'PADILLA', 19);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (513, 'PACHO', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (514, 'PÁEZ', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (516, 'PAIPA', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (517, 'PAEZ', 19);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (517, 'PAILITAS', 20);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (518, 'PAJARITO', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (518, 'PAIME', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (518, 'PAICOL', 41);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (518, 'PAMPLONA', 54);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (520, 'PALMAR DE VARELA', 8);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (520, 'FRANCISCO PIZARRO', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (520, 'PAMPLONITA', 54);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (520, 'PALOCABILDO', 73);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (520, 'PALMIRA', 76);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (522, 'PANQUEBA', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (522, 'PALMAR', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (523, 'PALMITO', 70);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (524, 'PALESTINA', 17);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (524, 'PANDI', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (524, 'PALERMO', 41);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (524, 'PALMAS DEL SOCORRO', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (524, 'LA PRIMAVERA', 99);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (530, 'PARATEBUENO', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (530, 'PALESTINA', 41);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (530, 'PUERTO ALEGRÍA', 91);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (531, 'PAUNA', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (532, 'PATÍA', 19);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (533, 'PAYA', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (533, 'PIAMONTE', 19);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (533, 'PÁRAMO', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (535, 'PASCA', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (536, 'PUERTO ARICA', 91);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (537, 'PAZ DE RÍO', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (540, 'POLICARPA', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (540, 'PUERTO NARIÑO', 91);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (541, 'PEÑOL', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (541, 'PENSILVANIA', 17);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (541, 'PEDRAZA', 47);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (542, 'PESCA', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (543, 'PEQUE', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (545, 'PIJIÑO DEL CARMEN', 47);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (547, 'PIEDECUESTA', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (547, 'PIEDRAS', 73);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (548, 'PIENDAMÓ', 19);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (548, 'PITAL', 41);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (548, 'PIJAO', 63);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (549, 'PIOJÓ', 8);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (549, 'PINILLOS', 13);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (549, 'PINCHOTE', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (550, 'PISBA', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (550, 'PELAYA', 20);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (551, 'PITALITO', 41);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (551, 'PIVIJAY', 47);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (553, 'PUERTO SANTANDER', 54);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (555, 'PLANETA RICA', 23);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (555, 'PLATO', 47);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (555, 'PLANADAS', 73);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (558, 'POLONUEVO', 8);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (560, 'PONEDERA', 8);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (560, 'MANAURE', 44);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (560, 'POTOSÍ', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (563, 'PRADO', 73);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (563, 'PRADERA', 76);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (564, 'PROVIDENCIA', 88);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (565, 'PROVIDENCIA', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (568, 'PUERTO GAITÁN', 50);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (568, 'PUERTO ASÍS', 86);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (569, 'PUERTO CAICEDO', 86);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (570, 'PUEBLO BELLO', 20);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (570, 'PUEBLO NUEVO', 23);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (570, 'PUEBLOVIEJO', 47);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (571, 'PUERTO GUZMÁN', 86);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (572, 'PUERTO BOYACÁ', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (572, 'PUERTO SALGAR', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (572, 'PUEBLO RICO', 66);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (572, 'PUENTE NACIONAL', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (573, 'PUERTO COLOMBIA', 8);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (573, 'PUERTO TEJADA', 19);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (573, 'PUERTO LÓPEZ', 50);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (573, 'PUERRES', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (573, 'PUERTO PARRA', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (573, 'PUERTO LEGUÍZAMO', 86);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (574, 'PUERTO ESCONDIDO', 23);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (575, 'PUERTO WILCHES', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (576, 'PUEBLORRICO', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (577, 'PUERTO LLERAS', 50);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (579, 'PUERTO BERRÍO', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (580, 'REGIDOR', 13);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (580, 'QUÍPAMA', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (580, 'PUERTO LIBERTADOR', 23);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (580, 'PULÍ', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (580, 'RÍO IRÓ', 27);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (585, 'PUERTO NARE', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (585, 'PURACÉ', 19);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (585, 'PUPIALES', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (585, 'PURIFICACIÓN', 73);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (586, 'PURÍSIMA', 23);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (590, 'PUERTO RICO', 50);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (591, 'PUERTO TRIUNFO', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (591, 'PUERTO RONDÓN', 81);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (592, 'PUERTO RICO', 18);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (592, 'QUEBRADANEGRA', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (594, 'QUETAME', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (594, 'QUIMBAYA', 63);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (594, 'QUINCHÍA', 66);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (596, 'QUIPILE', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (599, 'RAMIRIQUÍ', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (599, 'APULO', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (599, 'RAGONVALIA', 54);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (600, 'RÍO VIEJO', 13);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (600, 'RÁQUIRA', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (600, 'RÍO QUITO', 27);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (604, 'REMEDIOS', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (605, 'REMOLINO', 47);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (606, 'REPELÓN', 8);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (606, 'RESTREPO', 50);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (606, 'RESTREPO', 76);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (607, 'RETIRO', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (610, 'SAN JOSÉ DEL FRAGUA', 18);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (612, 'RICAURTE', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (612, 'RICAURTE', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (614, 'RIOSUCIO', 17);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (614, 'RÍO DE ORO', 20);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (615, 'RIONEGRO', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (615, 'RIOSUCIO', 27);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (615, 'RIVERA', 41);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (615, 'RIONEGRO', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (616, 'RISARALDA', 17);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (616, 'RIOBLANCO', 73);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (616, 'RIOFRÍO', 76);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (620, 'SAN CRISTÓBAL', 13);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (621, 'RONDÓN', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (621, 'LA PAZ', 20);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (621, 'ROBERTO PAYÁN', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (622, 'ROSAS', 19);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (622, 'RONCESVALLES', 73);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (622, 'ROLDANILLO', 76);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (624, 'ROVIRA', 73);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (624, 'SANTA ROSALÍA', 99);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (628, 'SABANALARGA', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (631, 'SABANETA', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (632, 'SABOYÁ', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (634, 'SABANAGRANDE', 8);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (638, 'SABANALARGA', 8);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (638, 'SÁCHICA', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (642, 'SALGAR', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (645, 'SAN ANTONIO DEL TEQUENDAMA', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (646, 'SAMACÁ', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (647, 'SAN ANDRÉS DE CUERQUÍA', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (647, 'SAN ESTANISLAO', 13);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (649, 'SAN CARLOS', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (649, 'SAN BERNARDO', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (650, 'SAN FERNANDO', 13);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (650, 'SAN JUAN DEL CESAR', 44);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (652, 'SAN FRANCISCO', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (653, 'SALAMINA', 17);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (653, 'SAN CAYETANO', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (654, 'SAN JACINTO', 13);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (655, 'SAN JACINTO DEL CAUCA', 13);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (655, 'SABANA DE TORRES', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (656, 'SAN JERÓNIMO', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (657, 'SAN JUAN NEPOMUCENO', 13);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (658, 'SAN JOSÉ DE LA MONTAÑA', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (658, 'SAN FRANCISCO', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (659, 'SAN JUAN DE URABÁ', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (660, 'SAN LUIS', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (660, 'SAN EDUARDO', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (660, 'SAHAGÚN', 23);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (660, 'SAN JOSÉ DEL PALMAR', 27);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (660, 'SALADOBLANCO', 41);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (660, 'SABANAS DE SAN ANGEL', 47);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (660, 'SALAZAR', 54);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (662, 'SAMANÁ', 17);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (662, 'SAN JUAN DE RÍO SECO', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (663, 'MAPIRIPANA', 94);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (664, 'SAN PEDRO DE LOS MILAGROS', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (664, 'SAN JOSÉ DE PARE', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (665, 'SAN PEDRO DE URABA', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (665, 'SAN JOSÉ', 17);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (666, 'TARAIRA', 97);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (667, 'SAN RAFAEL', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (667, 'SAN MARTÍN DE LOBA', 13);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (667, 'SAN LUIS DE GACENO', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (668, 'SAN AGUSTÍN', 41);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (669, 'SAN ANDRÉS', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (669, 'PUERTO SANTANDER', 91);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (670, 'SAN ROQUE', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (670, 'SAN PABLO', 13);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (670, 'SAN ANDRÉS SOTAVENTO', 23);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (670, 'SAN CALIXTO', 54);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (670, 'SAMPUÉS', 70);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (670, 'SAN PEDRO', 76);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (671, 'SALDAÑA', 73);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (672, 'SAN ANTERO', 23);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (673, 'SANTA CATALINA', 13);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (673, 'SAN MATEO', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (673, 'SAN CAYETANO', 54);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (673, 'SAN BENITO', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (674, 'SAN VICENTE', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (675, 'SANTA LUCÍA', 8);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (675, 'SAN BERNARDO DEL VIENTO', 23);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (675, 'SALAMINA', 47);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (675, 'SAN ANTONIO', 73);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (676, 'SAN MIGUEL DE SEMA', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (676, 'SANTA MARÍA', 41);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (678, 'SAN CARLOS', 23);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (678, 'SAMANIEGO', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (678, 'SAN BENITO ABAD', 70);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (678, 'SAN LUIS', 73);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (679, 'SANTA BÁRBARA', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (679, 'SAN GIL', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (680, 'SAN CARLOS DE GUAROA', 50);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (680, 'SANTIAGO', 54);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (681, 'SAN PABLO DE BORBUR', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (682, 'SAN JOSÉ DE URÉ', 23);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (682, 'SANTA ROSA DE CABAL', 66);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (682, 'SAN JOAQUÍN', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (683, 'SANTA ROSA', 13);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (683, 'SAN JUAN DE ARAMA', 50);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (683, 'SANDONÁ', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (684, 'SAN JOSÉ DE MIRANDA', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (685, 'SANTO TOMÁS', 8);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (685, 'SAN BERNARDO', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (686, 'SANTA ROSA DE OSOS', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (686, 'SANTANA', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (686, 'SAN PELAYO', 23);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (686, 'SAN JUANITO', 50);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (686, 'SAN MIGUEL', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (686, 'SANTA ISABEL', 73);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (687, 'SAN LORENZO', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (687, 'SANTUARIO', 66);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (688, 'SANTA ROSA DEL SUR', 13);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (689, 'SAN MARTÍN', 50);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (689, 'SAN VICENTE DE CHUCURÍ', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (690, 'SANTO DOMINGO', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (690, 'SANTA MARÍA', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (690, 'SALENTO', 63);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (692, 'SAN SEBASTIÁN DE BUENAVISTA', 47);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (693, 'SANTA ROSA DE VITERBO', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (693, 'SAN SEBASTIÁN', 19);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (693, 'SAN PABLO', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (694, 'SAN PEDRO DE CARTAGO', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (696, 'SANTA SOFÍA', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (696, 'SANTA BÁRBARA', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (697, 'EL SANTUARIO', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (698, 'SANTANDER DE QUILICHAO', 19);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (699, 'SANTACRUZ', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (701, 'SANTA ROSA', 19);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (702, 'SAN JUAN DE BETULIA', 70);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (703, 'SAN ZENÓN', 47);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (705, 'SANTA BÁRBARA', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (707, 'SANTA ANA', 47);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (708, 'SAN MARCOS', 70);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (710, 'SAN ALBERTO', 20);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (711, 'VISTAHERMOSA', 50);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (713, 'SAN ONOFRE', 70);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (717, 'SAN PEDRO', 70);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (718, 'SASAIMA', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (720, 'SATIVANORTE', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (720, 'SANTA BÁRBARA DE PINTO', 47);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (720, 'SAPUYES', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (720, 'SARDINATA', 54);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (720, 'SANTA HELENA DEL OPÓN', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (723, 'SATIVASUR', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (736, 'SEGOVIA', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (736, 'SESQUILÉ', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (736, 'SEVILLA', 76);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (736, 'SARAVENA', 81);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (740, 'SIACHOQUE', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (740, 'SIBATÉ', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (742, 'SAN LUIS DE SINCÉ', 70);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (743, 'SILVIA', 19);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (743, 'SILVANIA', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (743, 'SILOS', 54);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (744, 'SIMITÍ', 13);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (745, 'SIMIJACA', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (745, 'SIPÍ', 27);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (745, 'SITIONUEVO', 47);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (745, 'SIMACOTA', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (749, 'SIBUNDOY', 86);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (750, 'SAN DIEGO', 20);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (753, 'SOATÁ', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (753, 'SAN VICENTE DEL CAGUÁN', 18);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (754, 'SOACHA', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (755, 'SOCOTÁ', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (755, 'SOCORRO', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (755, 'SAN FRANCISCO', 86);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (756, 'SONSON', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (756, 'SOLANO', 18);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (757, 'SOCHA', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (757, 'SAN MIGUEL', 86);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (758, 'SOLEDAD', 8);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (758, 'SOPÓ', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (759, 'SOGAMOSO', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (760, 'SOPLAVIENTO', 13);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (760, 'SOTARA', 19);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (760, 'SANTIAGO', 86);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (761, 'SOPETRÁN', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (761, 'SOMONDOCO', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (762, 'SORA', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (763, 'SOTAQUIRÁ', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (764, 'SORACÁ', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (769, 'SUBACHOQUE', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (770, 'SUAN', 8);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (770, 'SAN MARTÍN', 20);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (770, 'SUAZA', 41);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (770, 'SUAITA', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (770, 'SUÁREZ', 73);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (771, 'SUCRE', 70);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (772, 'SUESCA', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (773, 'SUCRE', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (773, 'CUMARIBO', 99);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (774, 'SUSACÓN', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (776, 'SUTAMARCHÁN', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (777, 'SUPÍA', 17);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (777, 'SUPATÁ', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (777, 'PAPUNAUA', 97);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (778, 'SUTATENZA', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (779, 'SUSA', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (780, 'TALAIGUA NUEVO', 13);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (780, 'SUÁREZ', 19);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (780, 'SURATÁ', 68);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (781, 'SUTATAUSA', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (785, 'SOLITA', 18);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (785, 'SUCRE', 19);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (785, 'TABIO', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (786, 'TAMINANGO', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (787, 'TAMALAMEQUE', 20);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (787, 'TADÓ', 27);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (788, 'TANGUA', 52);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (789, 'TÁMESIS', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (790, 'TARAZÁ', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (790, 'TASCO', 15);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (791, 'TARQUI', 41);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (792, 'TARSO', 5);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (793, 'TAUSA', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (794, 'TAME', 81);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (797, 'TENA', 25);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (797, 'TESALIA', 41);
INSERT INTO `botica`.`ciudades` (`id_ciudad`, `nombre`, `iddepartamento`) VALUES (798, 'TENZA', 15);

COMMIT;


-- -----------------------------------------------------
-- Data for table `botica`.`roles`
-- -----------------------------------------------------
START TRANSACTION;
USE `botica`;
INSERT INTO `botica`.`roles` (`id_rol`, `descripcion`) VALUES (1, 'usuario');
INSERT INTO `botica`.`roles` (`id_rol`, `descripcion`) VALUES (2, 'drogueria');

COMMIT;


-- -----------------------------------------------------
-- Data for table `botica`.`zona_envios`
-- -----------------------------------------------------
START TRANSACTION;
USE `botica`;
INSERT INTO `botica`.`zona_envios` (`id_zona_envio`, `descripcion_zona`) VALUES (1, 'norte');
INSERT INTO `botica`.`zona_envios` (`id_zona_envio`, `descripcion_zona`) VALUES (2, 'sur ');
INSERT INTO `botica`.`zona_envios` (`id_zona_envio`, `descripcion_zona`) VALUES (3, 'occidente');
INSERT INTO `botica`.`zona_envios` (`id_zona_envio`, `descripcion_zona`) VALUES (4, 'oriente');
INSERT INTO `botica`.`zona_envios` (`id_zona_envio`, `descripcion_zona`) VALUES (5, 'centro');
INSERT INTO `botica`.`zona_envios` (`id_zona_envio`, `descripcion_zona`) VALUES (6, 'no aplica');

COMMIT;
