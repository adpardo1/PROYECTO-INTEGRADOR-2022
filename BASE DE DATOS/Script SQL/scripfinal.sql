-- Proyecto Integrador 
-- V1.10

-- Creacion del nuevo esquema 'proyecto'

CREATE SCHEMA IF NOT EXISTS `proyecto` DEFAULT CHARACTER SET utf8 ;
USE `proyecto` ;

-- Eliminacion de las tablas 
/*
DROP TABLE establecimiento;
DROP TABLE servicios;
DROP TABLE categoria;
DROP TABLE idioma;
DROP TABLE provincia;
DROP TABLE parroquia;
DROP TABLE canton;
DROP TABLE esta_provin;
*/

-- Creacion de las tablas 
-- Crear tabla servicios 
CREATE TABLE IF NOT EXISTS `proyecto`.`servicios` (
  `idServicios` INT NOT NULL,
  `actividad` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idServicios`),
  UNIQUE INDEX `idServicios_UNIQUE` (`idServicios` ASC))
ENGINE = InnoDB;

-- Crear tabla establecimiento 
CREATE TABLE IF NOT EXISTS `proyecto`.`establecimiento` (
  `idestablecimiento` INT NOT NULL,
  `nombre_esta` VARCHAR(45) NOT NULL,
  `clasificacion` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `refen_direccion` VARCHAR(45) NULL,
  `telefono` INT NOT NULL,
  `telefono_secun` INT NULL,
  `email` VARCHAR(45) NULL,
  `paginaWeb` VARCHAR(45) NULL,
  `horario` VARCHAR(45) NOT NULL,
  `estimacion` INT NOT NULL,
  `Servicios_idServicios` INT NOT NULL,
  PRIMARY KEY (`idestablecimiento`),
  UNIQUE INDEX `idestablecimiento_UNIQUE` (`idestablecimiento` ASC),
  INDEX `fk_establecimiento_Servicios1_idx` (`Servicios_idServicios` ASC),
  CONSTRAINT `fk_establecimiento_Servicios1`
    FOREIGN KEY (`Servicios_idServicios`)
    REFERENCES `proyecto`.`Servicios` (`idServicios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Crear tabla categoria 
CREATE TABLE IF NOT EXISTS `proyecto`.`categoria` (
  `idCategoria` INT NOT NULL,
  `categoria` VARCHAR(45) NOT NULL,
  `establecimiento_idestablecimiento` INT NOT NULL,
  PRIMARY KEY (`idCategoria`),
  UNIQUE INDEX `idCategoria_UNIQUE` (`idCategoria` ASC),
  INDEX `fk_Categoria_establecimiento1_idx` (`establecimiento_idestablecimiento` ASC),
  CONSTRAINT `fk_Categoria_establecimiento1`
    FOREIGN KEY (`establecimiento_idestablecimiento`)
    REFERENCES `proyecto`.`establecimiento` (`idestablecimiento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Crear tabla canton 
CREATE TABLE IF NOT EXISTS `proyecto`.`canton` (
  `idCanton` INT NOT NULL,
  `nombre_canton` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCanton`),
  UNIQUE INDEX `idCanton_UNIQUE` (`idCanton` ASC))
ENGINE = InnoDB;

-- Crear tabla parroquia 
CREATE TABLE IF NOT EXISTS `proyecto`.`parroquia` (
  `idParroquia` INT NOT NULL,
  `nombre_parroquia` VARCHAR(45) NOT NULL,
  `Canton_idCanton` INT NOT NULL,
  PRIMARY KEY (`idParroquia`),
  UNIQUE INDEX `idParroquia_UNIQUE` (`idParroquia` ASC),
  INDEX `fk_Parroquia_Canton1_idx` (`Canton_idCanton` ASC),
  CONSTRAINT `fk_Parroquia_Canton1`
    FOREIGN KEY (`Canton_idCanton`)
    REFERENCES `proyecto`.`Canton` (`idCanton`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Crear tabla provincia 
CREATE TABLE IF NOT EXISTS `proyecto`.`provincia` (
  `idProvincia` INTEGER NOT NULL,
  `nombre_provincia` VARCHAR(45) NOT NULL,
  `poblacion` VARCHAR(45) NOT NULL,
  `num_cantones` INT NOT NULL,
  `Parroquia_idParroquia` INT NOT NULL,
  PRIMARY KEY (`idProvincia`),
  INDEX `fk_Provincia_Parroquia1_idx` (`Parroquia_idParroquia` ASC),
  CONSTRAINT `fk_Provincia_Parroquia1`
    FOREIGN KEY (`Parroquia_idParroquia`)
    REFERENCES `proyecto`.`parroquia` (`idParroquia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Crear tabla idioma 
CREATE TABLE IF NOT EXISTS `proyecto`.`idioma` (
  `idIdioma` INT NOT NULL,
  `idioma` VARCHAR(45) NOT NULL,
  `Provincia_idProvincia` INT NOT NULL,
  PRIMARY KEY (`idIdioma`),
  UNIQUE INDEX `idIdioma_UNIQUE` (`idIdioma` ASC),
  INDEX `fk_Idioma_Provincia1_idx` (`Provincia_idProvincia` ASC),
  CONSTRAINT `fk_Idioma_Provincia1`
    FOREIGN KEY (`Provincia_idProvincia`)
    REFERENCES `proyecto`.`Provincia` (`idProvincia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Crear tabla esta_provin 
CREATE TABLE IF NOT EXISTS `proyecto`.`esta_provin` (
  `idesta_provin` INT NOT NULL,
  `establecimiento_idestablecimiento` INT NOT NULL,
  `Provincia_idProvincia` INT NOT NULL,
  PRIMARY KEY (`idesta_provin`),
  UNIQUE INDEX `idesta_provin_UNIQUE` (`idesta_provin` ASC),
  INDEX `fk_esta_provin_establecimiento1_idx` (`establecimiento_idestablecimiento` ASC),
  INDEX `fk_esta_provin_Provincia1_idx` (`Provincia_idProvincia` ASC),
  CONSTRAINT `fk_esta_provin_establecimiento1`
    FOREIGN KEY (`establecimiento_idestablecimiento`)
    REFERENCES `proyecto`.`establecimiento` (`idestablecimiento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_esta_provin_Provincia1`
    FOREIGN KEY (`Provincia_idProvincia`)
    REFERENCES `proyecto`.`Provincia` (`idProvincia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET FOREIGN_KEY_CHECKS=0;
-- Ingresar datos  
-- Datos establecimiento
LOAD DATA INFILE 'D:\datos2\\establecimiento.csv'
		INTO TABLE establecimiento FIELDS TERMINATED BY '|'
		ENCLOSED BY '"'
		LINES TERMINATED BY '\n'
		IGNORE 1 LINES;
        
-- Datos servicios
LOAD DATA INFILE 'D:\datos2\\servicios.csv'
		INTO TABLE servicios FIELDS TERMINATED BY '|'
		ENCLOSED BY '"'
		LINES TERMINATED BY '\n'
		IGNORE 1 LINES;
        
-- Datos categoria
LOAD DATA INFILE 'D:\datos2\\categoria.csv'
		INTO TABLE categoria FIELDS TERMINATED BY '|'
		ENCLOSED BY '"'
		LINES TERMINATED BY '\n'
		IGNORE 1 LINES;
        
-- Datos idioma
LOAD DATA INFILE 'D:\datos2\\idioma.csv'
		INTO TABLE idioma FIELDS TERMINATED BY '|'
		ENCLOSED BY '"'
		LINES TERMINATED BY '\n'
		IGNORE 1 LINES;
        
-- Datos provincia
LOAD DATA INFILE 'D:\datos2\\provincia.csv'
		INTO TABLE provincia FIELDS TERMINATED BY '|'
		ENCLOSED BY '"'
		LINES TERMINATED BY '\n'
		IGNORE 1 LINES;

-- Datos parroquia
  LOAD DATA INFILE 'D:\datos2\\parroquia.csv'
		INTO TABLE parroquia FIELDS TERMINATED BY '|'
		ENCLOSED BY '"'
		LINES TERMINATED BY '\n'
		IGNORE 1 LINES;

-- Datos canton
 LOAD DATA INFILE 'D:\datos2\\canton.csv'
		INTO TABLE canton FIELDS TERMINATED BY '|'
		ENCLOSED BY '"'
		LINES TERMINATED BY '\n'
		IGNORE 1 LINES;

-- Datos esta_provin
 LOAD DATA INFILE 'D:\datos2\\esta_provin.csv'
		INTO TABLE esta_provin FIELDS TERMINATED BY '|'
		ENCLOSED BY '"'
		LINES TERMINATED BY '\n'
		IGNORE 1 LINES;
        
SELECT *
FROM establecimiento;

/*        
SELECT *
FROM establecimiento;

SELECT *
FROM servicios;

SELECT *
FROM categoria;

SELECT *
FROM idioma;

SELECT *
FROM provincia;

SELECT *
FROM canton;

SELECT *
FROM esta_provin;

SELECT *
FROM parroquia; */

