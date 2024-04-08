-- MySQL Script generated by MySQL Workbench
-- Sat Apr  6 18:50:24 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema projetofinal
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema projetofinal
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `projetofinal` DEFAULT CHARACTER SET utf8 ;
USE `projetofinal` ;

-- -----------------------------------------------------
-- Table `projetofinal`.`Perfil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projetofinal`.`Perfil` (
  `idPerfil` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPerfil`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projetofinal`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projetofinal`.`Usuario` (
  `idUsuario` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `cpf` VARCHAR(14) NOT NULL,
  `nascimento` DATE NOT NULL,
  `idPerfil` INT NOT NULL,
  PRIMARY KEY (`idUsuario`),
  INDEX `fk_Usuario_Perfil1_idx` (`idPerfil` ASC) VISIBLE,
  CONSTRAINT `fk_Usuario_Perfil1`
    FOREIGN KEY (`idPerfil`)
    REFERENCES `projetofinal`.`Perfil` (`idPerfil`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projetofinal`.`Endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projetofinal`.`Endereco` (
  `idEndereco` INT NOT NULL AUTO_INCREMENT,
  `numero` VARCHAR(45) NOT NULL,
  `rua` VARCHAR(45) NOT NULL,
  `domicilio` VARCHAR(45) NOT NULL,
  `bairro` VARCHAR(45) NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `complemento` VARCHAR(45) NOT NULL,
  `idUsuario` INT NOT NULL,
  PRIMARY KEY (`idEndereco`),
  INDEX `fk_Endereco_Usuario1_idx` (`idUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_Endereco_Usuario1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `projetofinal`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projetofinal`.`Pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projetofinal`.`Pagamento` (
  `idPagamento` INT NOT NULL AUTO_INCREMENT,
  `forma_pgto` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPagamento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projetofinal`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projetofinal`.`Pedido` (
  `idPedido` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `tel` VARCHAR(14) NOT NULL,
  `pagamento` VARCHAR(10) NOT NULL,
  `status` INT NOT NULL,
  `idPagamento` INT NOT NULL,
  `idUsuario` INT NOT NULL,
  `idEndereco` INT NOT NULL,
  PRIMARY KEY (`idPedido`),
  INDEX `fk_Pedido_Pagamento1_idx` (`idPagamento` ASC) VISIBLE,
  INDEX `fk_Pedido_Usuario1_idx` (`idUsuario` ASC) VISIBLE,
  INDEX `fk_Pedido_Endereco1_idx` (`idEndereco` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Pagamento1`
    FOREIGN KEY (`idPagamento`)
    REFERENCES `projetofinal`.`Pagamento` (`idPagamento`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Pedido_Usuario1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `projetofinal`.`Usuario` (`idUsuario`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Pedido_Endereco1`
    FOREIGN KEY (`idEndereco`)
    REFERENCES `projetofinal`.`Endereco` (`idEndereco`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projetofinal`.`Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projetofinal`.`Produto` (
  `idProduto` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `preco` DOUBLE NOT NULL,
  `desc` VARCHAR(45) NOT NULL,
  `qtd_estoque` INT NOT NULL,
  PRIMARY KEY (`idProduto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projetofinal`.`Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projetofinal`.`Menu` (
  `idMenu` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `link` VARCHAR(100) NOT NULL,
  `icone` VARCHAR(45) NULL,
  `exibir` INT NOT NULL,
  PRIMARY KEY (`idMenu`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projetofinal`.`Menu_Perfil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projetofinal`.`Menu_Perfil` (
  `idMenu` INT NOT NULL,
  `idPerfil` INT NOT NULL,
  PRIMARY KEY (`idMenu`, `idPerfil`),
  INDEX `fk_Menu_has_Perfil_Perfil1_idx` (`idPerfil` ASC) VISIBLE,
  INDEX `fk_Menu_has_Perfil_Menu1_idx` (`idMenu` ASC) VISIBLE,
  CONSTRAINT `fk_Menu_has_Perfil_Menu1`
    FOREIGN KEY (`idMenu`)
    REFERENCES `projetofinal`.`Menu` (`idMenu`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Menu_has_Perfil_Perfil1`
    FOREIGN KEY (`idPerfil`)
    REFERENCES `projetofinal`.`Perfil` (`idPerfil`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projetofinal`.`Funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projetofinal`.`Funcionario` (
  `idFuncionario` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `matr` VARCHAR(10) NOT NULL,
  `idPerfil` INT NOT NULL,
  PRIMARY KEY (`idFuncionario`),
  INDEX `fk_Funcionario_Perfil1_idx` (`idPerfil` ASC) VISIBLE,
  CONSTRAINT `fk_Funcionario_Perfil1`
    FOREIGN KEY (`idPerfil`)
    REFERENCES `projetofinal`.`Perfil` (`idPerfil`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projetofinal`.`Pedido_Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projetofinal`.`Pedido_Produto` (
  `idPedido` INT NOT NULL,
  `idProduto` INT NOT NULL,
  PRIMARY KEY (`idPedido`, `idProduto`),
  INDEX `fk_Pedido_has_Produto_Produto1_idx` (`idProduto` ASC) VISIBLE,
  INDEX `fk_Pedido_has_Produto_Pedido1_idx` (`idPedido` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_has_Produto_Pedido1`
    FOREIGN KEY (`idPedido`)
    REFERENCES `projetofinal`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_has_Produto_Produto1`
    FOREIGN KEY (`idProduto`)
    REFERENCES `projetofinal`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
