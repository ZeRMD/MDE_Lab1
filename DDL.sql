-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema smartBuildingsDB
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `smartBuildingsDB` ;

-- -----------------------------------------------------
-- Schema smartBuildingsDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `smartBuildingsDB` ;
USE `smartBuildingsDB` ;

-- -----------------------------------------------------
-- Table `Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cliente` (
  `NIF` INT NOT NULL,
  `Nome` VARCHAR(20) NOT NULL,
  `Numero_Telefone` INT NOT NULL,
  `Tipo` VARCHAR(45) NOT NULL,
  `Morada` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NULL,
  PRIMARY KEY (`NIF`),
  UNIQUE INDEX `NIF_UNIQUE` (`NIF` ASC),
  UNIQUE INDEX `Numero_Telefone_UNIQUE` (`Numero_Telefone` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Instalacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Instalacao` (
  `ID_Instalacao` INT NOT NULL AUTO_INCREMENT,
  `NIF_Cliente` INT NOT NULL,
  `Morada` VARCHAR(45) NOT NULL,
  `Numero_Dispositivos` INT NOT NULL DEFAULT 0,
  `Tipo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID_Instalacao`),
  INDEX `fk_Instalação_Cliente1_idx` (`NIF_Cliente` ASC),
  UNIQUE INDEX `ID_Instalacao_UNIQUE` (`ID_Instalacao` ASC),
  UNIQUE INDEX `Morada_UNIQUE` (`Morada` ASC),
  CONSTRAINT `fk_Instalação_Cliente1`
    FOREIGN KEY (`NIF_Cliente`)
    REFERENCES `Cliente` (`NIF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Servico` (
  `Tipo_Servico` VARCHAR(20) NOT NULL,
  `Numero_Max_Dispositivos` INT NULL,
  PRIMARY KEY (`Tipo_Servico`),
  UNIQUE INDEX `Tipo_Servico_UNIQUE` (`Tipo_Servico` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Mediador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Mediador` (
  `ID_Mediador` INT NOT NULL AUTO_INCREMENT,
  `Nome_Mediador` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID_Mediador`),
  UNIQUE INDEX `ID_Mediador_UNIQUE` (`ID_Mediador` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Contratos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Contratos` (
  `ID_Contrato` INT NOT NULL AUTO_INCREMENT,
  `ID_Instalacao` INT NOT NULL,
  `Tipo_Servico` VARCHAR(20) NOT NULL,
  `ID_Mediador` INT NOT NULL,
  `Data_Inicio` DATETIME NOT NULL,
  `Duracao` INT NOT NULL,
  `Custo_Mensal` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`ID_Contrato`),
  INDEX `fk_Contratos_Instalação1_idx` (`ID_Instalacao` ASC),
  INDEX `fk_Contratos_Serviço1_idx` (`Tipo_Servico` ASC),
  UNIQUE INDEX `ID_Instalacao_UNIQUE` (`ID_Instalacao` ASC),
  INDEX `fk_Contratos_Mediador1_idx` (`ID_Mediador` ASC),
  CONSTRAINT `fk_Contratos_Instalação1`
    FOREIGN KEY (`ID_Instalacao`)
    REFERENCES `Instalacao` (`ID_Instalacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Contratos_Serviço1`
    FOREIGN KEY (`Tipo_Servico`)
    REFERENCES `Servico` (`Tipo_Servico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Contratos_Mediador1`
    FOREIGN KEY (`ID_Mediador`)
    REFERENCES `Mediador` (`ID_Mediador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Dispositivos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Dispositivos` (
  `Referencia` INT NOT NULL,
  `ID_Instalacao` INT NOT NULL,
  `Tipo` VARCHAR(45) NOT NULL,
  `Modelo` VARCHAR(45) NOT NULL,
  `Data_Instalacao` DATETIME NOT NULL,
  `Estado` TINYINT NOT NULL,
  `Data_Ultima_Leitura` DATETIME NULL,
  `Valor_Leitura` DECIMAL(10,2) NULL,
  PRIMARY KEY (`Referencia`),
  INDEX `fk_Dispositivos_Instalação1_idx` (`ID_Instalacao` ASC),
  UNIQUE INDEX `Referencia_UNIQUE` (`Referencia` ASC),
  CONSTRAINT `fk_Dispositivos_Instalação1`
    FOREIGN KEY (`ID_Instalacao`)
    REFERENCES `Instalacao` (`ID_Instalacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Fatura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Fatura` (
  `Numero_Fatura` INT NOT NULL AUTO_INCREMENT,
  `ID_Contrato` INT NOT NULL,
  `Data_Emissao` DATETIME NOT NULL,
  `Custo_Fatura` DECIMAL(10,2) NOT NULL,
  `Estado_Fatura` VARCHAR(45) NOT NULL DEFAULT 'Por Pagar',
  PRIMARY KEY (`Numero_Fatura`),
  INDEX `fk_Fatura_Contratos1_idx` (`ID_Contrato` ASC),
  UNIQUE INDEX `Numero_Fatura_UNIQUE` (`Numero_Fatura` ASC),
  CONSTRAINT `fk_Fatura_Contratos1`
    FOREIGN KEY (`ID_Contrato`)
    REFERENCES `Contratos` (`ID_Contrato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Automacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Automacao` (
  `ID_Automacao` INT NOT NULL AUTO_INCREMENT,
  `Referencia_Dispositivo_Cond` INT NOT NULL,
  `Relacao` VARCHAR(45) NOT NULL,
  `Valor_Referencia` DECIMAL(10,2) NOT NULL,
  `Referencia_Dispositivo_Acao` INT NOT NULL,
  `Acao` VARCHAR(45) NOT NULL,
  `Data_Implementacao` DATETIME NOT NULL,
  INDEX `fk_Automacao_Dispositivos1_idx` (`Referencia_Dispositivo_Cond` ASC),
  INDEX `fk_Automacao_Dispositivos2_idx` (`Referencia_Dispositivo_Acao` ASC),
  PRIMARY KEY (`ID_Automacao`),
  UNIQUE INDEX `ID_Automacao_UNIQUE` (`ID_Automacao` ASC),
  CONSTRAINT `fk_Automacao_Dispositivos1`
    FOREIGN KEY (`Referencia_Dispositivo_Cond`)
    REFERENCES `Dispositivos` (`Referencia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Automacao_Dispositivos2`
    FOREIGN KEY (`Referencia_Dispositivo_Acao`)
    REFERENCES `Dispositivos` (`Referencia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Acao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Acao` (
  `Referencia` INT NOT NULL,
  `Acao` VARCHAR(45) NOT NULL,
  `Data_Acao` DATETIME NOT NULL,
  INDEX `fk_Acao_Dispositivos1_idx` (`Referencia` ASC),
  CONSTRAINT `fk_Acao_Dispositivos1`
    FOREIGN KEY (`Referencia`)
    REFERENCES `Dispositivos` (`Referencia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
