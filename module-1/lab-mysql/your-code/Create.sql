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
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET UTF8MB4 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Customers` (
  `Customer ID` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Phone` INT NOT NULL,
  `Email` VARCHAR(45) NULL,
  `Address` VARCHAR(90) NOT NULL,
  `City` VARCHAR(45) NOT NULL,
  `State/Province` VARCHAR(90) NOT NULL,
  `Country` VARCHAR(45) NOT NULL,
  `Postal` INT NOT NULL,
  `Cars_VIN` VARCHAR(45) NOT NULL,
  `Salesperson_Staff ID` INT NOT NULL,
  PRIMARY KEY (`Customer ID`, `Cars_VIN`, `Salesperson_Staff ID`),
  UNIQUE INDEX `Customer ID_UNIQUE` (`Customer ID` ASC),
  INDEX `fk_Customers_Cars_idx` (`Cars_VIN` ASC),
  CONSTRAINT `fk_Customers_Cars`
    FOREIGN KEY (`Cars_VIN`)
    REFERENCES `mydb`.`Cars` (`VIN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Invoices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Invoices` (
  `Invoice Number` INT NOT NULL,
  `Date` DATETIME(6) NOT NULL,
  `Car` INT NOT NULL,
  `Customer` INT NOT NULL,
  `Sales Person` INT NOT NULL,
  `Customers_Customer ID` INT NOT NULL,
  `Customers_Cars_VIN` VARCHAR(45) NOT NULL,
  `Customers_Salesperson_Staff ID` INT NOT NULL,
  PRIMARY KEY (`Invoice Number`, `Customers_Customer ID`, `Customers_Cars_VIN`, `Customers_Salesperson_Staff ID`),
  UNIQUE INDEX `Invoice Number_UNIQUE` (`Invoice Number` ASC),
  INDEX `fk_Invoices_Customers1_idx` (`Customers_Customer ID` ASC, `Customers_Cars_VIN` ASC, `Customers_Salesperson_Staff ID` ASC),
  CONSTRAINT `fk_Invoices_Customers1`
    FOREIGN KEY (`Customers_Customer ID` , `Customers_Cars_VIN` , `Customers_Salesperson_Staff ID`)
    REFERENCES `mydb`.`Customers` (`Customer ID` , `Cars_VIN` , `Salesperson_Staff ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cars`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cars` (
  `VIN` VARCHAR(45) NOT NULL,
  `Manufacturer` VARCHAR(45) NOT NULL,
  `Model` VARCHAR(45) NOT NULL,
  `Color` VARCHAR(45) NOT NULL,
  `Year` YEAR(4) NOT NULL,
  `Invoices_Invoice Number` INT NOT NULL,
  PRIMARY KEY (`VIN`, `Invoices_Invoice Number`),
  UNIQUE INDEX `VIN_UNIQUE` (`VIN` ASC),
  INDEX `fk_Cars_Invoices1_idx` (`Invoices_Invoice Number` ASC),
  CONSTRAINT `fk_Cars_Invoices1`
    FOREIGN KEY (`Invoices_Invoice Number`)
    REFERENCES `mydb`.`Invoices` (`Invoice Number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Salesperson`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Salesperson` (
  `Staff ID` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Store` VARCHAR(45) NOT NULL,
  `Customers_Customer ID` INT NOT NULL,
  `Customers_Cars_VIN` VARCHAR(45) NOT NULL,
  `Customers_Salesperson_Staff ID` INT NOT NULL,
  PRIMARY KEY (`Staff ID`, `Customers_Customer ID`, `Customers_Cars_VIN`, `Customers_Salesperson_Staff ID`),
  UNIQUE INDEX `Staff ID_UNIQUE` (`Staff ID` ASC),
  INDEX `fk_Salesperson_Customers1_idx` (`Customers_Customer ID` ASC, `Customers_Cars_VIN` ASC, `Customers_Salesperson_Staff ID` ASC),
  CONSTRAINT `fk_Salesperson_Customers1`
    FOREIGN KEY (`Customers_Customer ID` , `Customers_Cars_VIN` , `Customers_Salesperson_Staff ID`)
    REFERENCES `mydb`.`Customers` (`Customer ID` , `Cars_VIN` , `Salesperson_Staff ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Invoices_has_Salesperson`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Invoices_has_Salesperson` (
  `Invoices_Invoice Number` INT NOT NULL,
  `Invoices_Customers_Customer ID` INT NOT NULL,
  `Invoices_Customers_Cars_VIN` VARCHAR(45) NOT NULL,
  `Invoices_Customers_Salesperson_Staff ID` INT NOT NULL,
  `Salesperson_Staff ID` INT NOT NULL,
  PRIMARY KEY (`Invoices_Invoice Number`, `Invoices_Customers_Customer ID`, `Invoices_Customers_Cars_VIN`, `Invoices_Customers_Salesperson_Staff ID`, `Salesperson_Staff ID`),
  INDEX `fk_Invoices_has_Salesperson_Salesperson1_idx` (`Salesperson_Staff ID` ASC),
  INDEX `fk_Invoices_has_Salesperson_Invoices1_idx` (`Invoices_Invoice Number` ASC, `Invoices_Customers_Customer ID` ASC, `Invoices_Customers_Cars_VIN` ASC, `Invoices_Customers_Salesperson_Staff ID` ASC),
  CONSTRAINT `fk_Invoices_has_Salesperson_Invoices1`
    FOREIGN KEY (`Invoices_Invoice Number` , `Invoices_Customers_Customer ID` , `Invoices_Customers_Cars_VIN` , `Invoices_Customers_Salesperson_Staff ID`)
    REFERENCES `mydb`.`Invoices` (`Invoice Number` , `Customers_Customer ID` , `Customers_Cars_VIN` , `Customers_Salesperson_Staff ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Invoices_has_Salesperson_Salesperson1`
    FOREIGN KEY (`Salesperson_Staff ID`)
    REFERENCES `mydb`.`Salesperson` (`Staff ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
