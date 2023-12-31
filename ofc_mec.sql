SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema oficina_mec
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema oficina_mec
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `oficina_mec` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ;
USE `oficina_mec` ;

-- -----------------------------------------------------
-- Table `oficina_mec`.`Serviço`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina_mec`.`Serviço` (
  `idServiço` INT NOT NULL AUTO_INCREMENT,
  `Tipo do Serviço` ENUM('Manutenção', 'Revisão') NOT NULL DEFAULT 'Revisão',
  `Nome_Serviço` VARCHAR(45) NOT NULL,
  `Duração` INT NOT NULL,
  `Descrição` VARCHAR(255) NOT NULL,
  `Mão_de_Obra` FLOAT(9,2) NOT NULL,
  PRIMARY KEY (`idServiço`),
  UNIQUE INDEX `idServiço_UNIQUE` (`idServiço` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina_mec`.`Peça`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina_mec`.`Peça` (
  `idPeça` INT NOT NULL AUTO_INCREMENT,
  `Nome_peça` VARCHAR(45) NOT NULL,
  `Descrição` VARCHAR(45) NOT NULL,
  `Quantidade_Disponível` INT NOT NULL,
  `Valor_Unitário` FLOAT(9,2) NOT NULL,
  PRIMARY KEY (`idPeça`),
  UNIQUE INDEX `idEstoque_UNIQUE` (`idPeça` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina_mec`.`Equipe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina_mec`.`Equipe` (
  `idEquipe` INT NOT NULL AUTO_INCREMENT,
  `Num_Func` INT NOT NULL COMMENT 'Numero de Funcionários.',
  `Equipe` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEquipe`),
  UNIQUE INDEX `idEquipes_UNIQUE` (`idEquipe` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina_mec`.`Cliente_PJ`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina_mec`.`Cliente_PJ` (
  `idCliente_PJ` INT NOT NULL AUTO_INCREMENT,
  `Razão_Social` VARCHAR(45) NOT NULL,
  `Nome_Fantasia` VARCHAR(45) NOT NULL,
  `CNPJ` CHAR(15) NOT NULL,
  `Responsavel` VARCHAR(45) NOT NULL,
  `Data Cadastro` DATE NOT NULL,
  `Telefone` VARCHAR(11) NOT NULL,
  `E-mail` VARCHAR(45) NULL,
  `Endereço` VARCHAR(255) NOT NULL,
  `Cidade` VARCHAR(45) NOT NULL,
  `Estado` CHAR(2) NOT NULL,
  PRIMARY KEY (`idCliente_PJ`),
  UNIQUE INDEX `idCliente PJ_UNIQUE` (`idCliente_PJ` ASC) VISIBLE,
  UNIQUE INDEX `CNPJ_UNIQUE` (`CNPJ` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina_mec`.`Cliente_PF`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina_mec`.`Cliente_PF` (
  `idCliente_PF` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `CPF` CHAR(11) NOT NULL,
  `Data_Nasc` DATE NOT NULL,
  `Data Cadastro` DATE NOT NULL,
  `Telefone` VARCHAR(11) NOT NULL,
  `E-mail` VARCHAR(45) NULL,
  `Endereço` VARCHAR(255) NOT NULL,
  `Cidade` VARCHAR(45) NOT NULL,
  `Estado` CHAR(2) NOT NULL,
  PRIMARY KEY (`idCliente_PF`),
  UNIQUE INDEX `idCliente PF_UNIQUE` (`idCliente_PF` ASC) VISIBLE,
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina_mec`.`Veiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina_mec`.`Veiculo` (
  `idVeiculo` INT NOT NULL AUTO_INCREMENT,
  `Tipo de Veiculo` VARCHAR(45) NOT NULL,
  `Placa` VARCHAR(45) NOT NULL,
  `Marca` VARCHAR(45) NOT NULL,
  `Modelo` VARCHAR(45) NOT NULL,
  `Ano` INT NOT NULL,
  `KM` VARCHAR(7) NOT NULL,
  `fk_idCliente_PJ` INT NULL,
  `fk_idCliente_PF` INT NULL,
  PRIMARY KEY (`idVeiculo`),
  UNIQUE INDEX `idVeiculo_UNIQUE` (`idVeiculo` ASC) VISIBLE,
  UNIQUE INDEX `Placa_UNIQUE` (`Placa` ASC) VISIBLE,
  INDEX `fk_Veiculo_Cliente_ PJ1_idx` (`fk_idCliente_PJ` ASC) VISIBLE,
  INDEX `fk_Veiculo_Cliente_PF1_idx` (`fk_idCliente_PF` ASC) VISIBLE,
  CONSTRAINT `fk_Veiculo_Cliente_ PJ1`
    FOREIGN KEY (`fk_idCliente_PJ`)
    REFERENCES `oficina_mec`.`Cliente_PJ` (`idCliente_PJ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Veiculo_Cliente_PF1`
    FOREIGN KEY (`fk_idCliente_PF`)
    REFERENCES `oficina_mec`.`Cliente_PF` (`idCliente_PF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina_mec`.`Orçamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina_mec`.`Orçamento` (
  `idOrçamento` INT NOT NULL AUTO_INCREMENT,
  `Numero_Orçamento` VARCHAR(45) NOT NULL,
  `Aprovado` ENUM('SIM', 'NÃO') NOT NULL DEFAULT 'NÃO' COMMENT 'Aprovado pelo Cliente',
  `Valor` FLOAT(9,2) NOT NULL COMMENT 'Valor total do orçamento peça + mão de obra',
  `Data` DATE NOT NULL COMMENT 'Data do Orçamento.',
  `Validade` VARCHAR(45) NOT NULL,
  `fk_idVeiculo` INT NOT NULL,
  `Cod_Funcionário` INT NOT NULL COMMENT 'Código do funcionário que emitiu o orçamento',
  PRIMARY KEY (`idOrçamento`, `fk_idVeiculo`),
  UNIQUE INDEX `idOrçamento_UNIQUE` (`idOrçamento` ASC) VISIBLE,
  UNIQUE INDEX `Numero do Orçamento_UNIQUE` (`Numero_Orçamento` ASC) VISIBLE,
  INDEX `fk_Orçamento_Veiculo1_idx` (`fk_idVeiculo` ASC) VISIBLE,
  CONSTRAINT `fk_Orçamento_Veiculo1`
    FOREIGN KEY (`fk_idVeiculo`)
    REFERENCES `oficina_mec`.`Veiculo` (`idVeiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina_mec`.`OS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina_mec`.`OS` (
  `idOrdem` INT NOT NULL AUTO_INCREMENT,
  `Numero` INT NOT NULL,
  `Data_Emissão` DATE NOT NULL,
  `Desconto` FLOAT(9,2) NOT NULL DEFAULT 5.0 COMMENT 'Desconto padrão 5%, à vista 10%.',
  `Data_Conclusão` DATE NOT NULL,
  `Obs` VARCHAR(255) NULL,
  `fk_idOrçamento` INT NOT NULL,
  `Forma_Pagamento` ENUM('Crédito', 'Débito', 'Dinheiro') NOT NULL DEFAULT 'Débito',
  PRIMARY KEY (`idOrdem`, `fk_idOrçamento`),
  INDEX `fk_Ordem de Serviço_Orçamento1_idx` (`fk_idOrçamento` ASC) VISIBLE,
  UNIQUE INDEX `idOrdem_UNIQUE` (`idOrdem` ASC) VISIBLE,
  CONSTRAINT `fk_Ordem de Serviço_Orçamento1`
    FOREIGN KEY (`fk_idOrçamento`)
    REFERENCES `oficina_mec`.`Orçamento` (`idOrçamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina_mec`.`Funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina_mec`.`Funcionario` (
  `idFunc` INT NOT NULL AUTO_INCREMENT,
  `fk_idEquipe` INT NOT NULL,
  `Código` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `CPF` CHAR(11) NOT NULL,
  `data_nasc` DATE NOT NULL COMMENT 'data do nascimento.',
  `Endereço` VARCHAR(45) NOT NULL,
  `Cargo` VARCHAR(45) NOT NULL,
  `Especialidade` VARCHAR(45) NOT NULL,
  `Contratação` DATE NOT NULL COMMENT 'data da contratação',
  `Telefone` INT NOT NULL,
  `E-mail` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idFunc`, `fk_idEquipe`),
  INDEX `fk_Funcionarios_Equipes1_idx` (`fk_idEquipe` ASC) VISIBLE,
  UNIQUE INDEX `idFunc_UNIQUE` (`idFunc` ASC) VISIBLE,
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC) VISIBLE,
  CONSTRAINT `fk_Funcionarios_Equipes1`
    FOREIGN KEY (`fk_idEquipe`)
    REFERENCES `oficina_mec`.`Equipe` (`idEquipe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina_mec`.`Equipe_Orçamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina_mec`.`Equipe_Orçamento` (
  `fk_idEquipe` INT NOT NULL,
  `fk_idOrçamento` INT NOT NULL,
  PRIMARY KEY (`fk_idEquipe`, `fk_idOrçamento`),
  INDEX `fk_Equipe_has_Orçamento_Orçamento1_idx` (`fk_idOrçamento` ASC) VISIBLE,
  INDEX `fk_Equipe_has_Orçamento_Equipe1_idx` (`fk_idEquipe` ASC) VISIBLE,
  CONSTRAINT `fk_Equipe_has_Orçamento_Equipe1`
    FOREIGN KEY (`fk_idEquipe`)
    REFERENCES `oficina_mec`.`Equipe` (`idEquipe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Equipe_has_Orçamento_Orçamento1`
    FOREIGN KEY (`fk_idOrçamento`)
    REFERENCES `oficina_mec`.`Orçamento` (`idOrçamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina_mec`.`Serviço_Peça`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina_mec`.`Serviço_Peça` (
  `fk_idOrçamento` INT NOT NULL,
  `fk_idServiço` INT NOT NULL,
  `fk_idPeça` INT NOT NULL,
  `Qtd_Peça` INT NOT NULL,
  `Qtd_Serviço` INT NOT NULL,
  PRIMARY KEY (`fk_idOrçamento`, `fk_idServiço`, `fk_idPeça`),
  INDEX `fk_Serviço_has_Peça_Peça1_idx` (`fk_idPeça` ASC) VISIBLE,
  INDEX `fk_Serviço_has_Peça_Serviço1_idx` (`fk_idServiço` ASC) VISIBLE,
  INDEX `fk_Serviço_Peça_Orçamento1_idx` (`fk_idOrçamento` ASC) VISIBLE,
  CONSTRAINT `fk_Serviço_has_Peça_Serviço1`
    FOREIGN KEY (`fk_idServiço`)
    REFERENCES `oficina_mec`.`Serviço` (`idServiço`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Serviço_has_Peça_Peça1`
    FOREIGN KEY (`fk_idPeça`)
    REFERENCES `oficina_mec`.`Peça` (`idPeça`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Serviço_Peça_Orçamento1`
    FOREIGN KEY (`fk_idOrçamento`)
    REFERENCES `oficina_mec`.`Orçamento` (`idOrçamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
 310 changes: 310 additions & 0 deletions310  
