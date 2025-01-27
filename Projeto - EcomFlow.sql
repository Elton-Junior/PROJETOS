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
-- Table `mydb`.`Pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pagamento` (
  `idPagamento` INT NOT NULL,
  `idCliente` INT NOT NULL,
  `Forma_Pagamento` ENUM('Cartão de Credito', 'Cartão de debito', 'Boleto', 'Transferência', 'PIX', 'Outro') NOT NULL,
  `Status_Pagamento` ENUM('Pendente', 'Confirmado', 'Cancelado') NOT NULL,
  `Valor_pago` DECIMAL(10,2) NOT NULL,
  `Data_Pagamento` DATETIME NOT NULL,
  PRIMARY KEY (`idPagamento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Entrega`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Entrega` (
  `idEntrega` INT NOT NULL,
  `idCliente` INT NOT NULL,
  `Status_Entrega` ENUM('Aguardando Envio', 'Enviado', 'Em Trãnsito', 'Entregue', 'Cancelado') NOT NULL,
  `Codigo_Rastreio` VARCHAR(50) NOT NULL,
  `Data_envio` DATETIME NOT NULL,
  `Data_Entrega` DATETIME NOT NULL,
  `Endereço_Entrega` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idEntrega`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `idCliente` INT NOT NULL,
  `Tipo_cliente` ENUM('PJ', 'PF') NOT NULL,
  `cnpj` VARCHAR(14) NOT NULL,
  `cpf` VARCHAR(11) NOT NULL,
  `Razão_social` VARCHAR(255) NOT NULL,
  `Nome_Fantasia` VARCHAR(255) NOT NULL,
  `Nome_Completo` VARCHAR(255) NOT NULL,
  `Data_Nascimento` DATE NOT NULL,
  `Endereço` VARCHAR(255) NOT NULL,
  `Telefone` VARCHAR(15) NOT NULL,
  `Email` VARCHAR(100) NOT NULL,
  `Pagamento_idPagamento` INT NOT NULL,
  `Entrega_idEntrega` INT NOT NULL,
  PRIMARY KEY (`idCliente`, `Pagamento_idPagamento`, `Entrega_idEntrega`),
  INDEX `fk_Cliente_Pagamento_idx` (`Pagamento_idPagamento` ASC) VISIBLE,
  INDEX `fk_Cliente_Entrega1_idx` (`Entrega_idEntrega` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_Pagamento`
    FOREIGN KEY (`Pagamento_idPagamento`)
    REFERENCES `mydb`.`Pagamento` (`idPagamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_Entrega1`
    FOREIGN KEY (`Entrega_idEntrega`)
    REFERENCES `mydb`.`Entrega` (`idEntrega`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '			';


-- -----------------------------------------------------
-- Table `mydb`.`Pagamento_para_Entrega`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pagamento_para_Entrega` (
  `Pagamento_idPagamento` INT NOT NULL,
  `Entrega_idEntrega` INT NOT NULL,
  PRIMARY KEY (`Pagamento_idPagamento`, `Entrega_idEntrega`),
  INDEX `fk_Pagamento_has_Entrega_Entrega1_idx` (`Entrega_idEntrega` ASC) VISIBLE,
  INDEX `fk_Pagamento_has_Entrega_Pagamento1_idx` (`Pagamento_idPagamento` ASC) VISIBLE,
  CONSTRAINT `fk_Pagamento_has_Entrega_Pagamento1`
    FOREIGN KEY (`Pagamento_idPagamento`)
    REFERENCES `mydb`.`Pagamento` (`idPagamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pagamento_has_Entrega_Entrega1`
    FOREIGN KEY (`Entrega_idEntrega`)
    REFERENCES `mydb`.`Entrega` (`idEntrega`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
