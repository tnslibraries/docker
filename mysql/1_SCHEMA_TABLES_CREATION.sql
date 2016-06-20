SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `recap` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `recap` ;

-- -----------------------------------------------------
-- Table `recap`.`INSTITUTION_T`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `recap`.`INSTITUTION_T` (
  `INSTITUTION_ID` INT NOT NULL AUTO_INCREMENT ,
  `INSTITUTION_CODE` VARCHAR(45) NOT NULL ,
  `INSTITUTION_NAME` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`INSTITUTION_ID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recap`.`BIBLIOGRAPHIC_T`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `recap`.`BIBLIOGRAPHIC_T` (
  `BIBLIOGRAPHIC_ID` INT NOT NULL AUTO_INCREMENT ,
  `CONTENT` BLOB NOT NULL ,
  `OWNING_INST_ID` INT NOT NULL ,
  `CREATED_DATE` DATETIME NOT NULL ,
  `LAST_UPDATED_DATE` DATETIME NULL ,
  `OWNING_INST_BIB_ID` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`BIBLIOGRAPHIC_ID`) ,
  UNIQUE INDEX `OWNING_INST_ID_BIB_ID_UNIQUE` (`OWNING_INST_ID` ASC, `OWNING_INST_BIB_ID` ASC) ,
  INDEX `BIBLIOGRAPHIC_OWNING_INST_ID_FK` (`OWNING_INST_ID` ASC) ,
  CONSTRAINT `BIBLIOGRAPHIC_OWNING_INST_ID_FK`
    FOREIGN KEY (`OWNING_INST_ID` )
    REFERENCES `recap`.`INSTITUTION_T` (`INSTITUTION_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `recap`.`HOLDINGS_T`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `recap`.`HOLDINGS_T` (
  `HOLDINGS_ID` INT NOT NULL AUTO_INCREMENT ,
  `CONTENT` BLOB NOT NULL ,
  `BIBLIOGRAPHIC_ID` INT NOT NULL ,
  `CREATED_DATE` DATETIME NOT NULL ,
  `LAST_UPDATED_DATE` DATETIME NULL ,
  `OWNING_INST_HOLDINGS_ID` VARCHAR(45) NULL ,
  PRIMARY KEY (`HOLDINGS_ID`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `recap`.`ITEM_STATUS_T`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `recap`.`ITEM_STATUS_T` (
  `ITEM_STATUS_ID` INT NOT NULL AUTO_INCREMENT ,
  `STATUS_CODE` VARCHAR(45) NOT NULL ,
  `STATUS_DESC` VARCHAR(2000) NOT NULL ,
  PRIMARY KEY (`ITEM_STATUS_ID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recap`.`COLLECTION_GROUP_T`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `recap`.`COLLECTION_GROUP_T` (
  `COLLECTION_GROUP_ID` INT NULL AUTO_INCREMENT ,
  `COLLECTION_GROUP_CODE` VARCHAR(45) NOT NULL ,
  `COLLECTIONT_GROUP_DESC` VARCHAR(45) NULL ,
  `CREATED_DATE` DATETIME NOT NULL ,
  `LAST_UPDATED_DATE` DATETIME NULL ,
  PRIMARY KEY (`COLLECTION_GROUP_ID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recap`.`ITEM_T`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `recap`.`ITEM_T` (
  `ITEM_ID` INT NOT NULL AUTO_INCREMENT ,
  `BAR_CODE` VARCHAR(45) NOT NULL ,
  `CUSTOMER_CODE` VARCHAR(45) NOT NULL ,
  `HOLDINGS_ID` INT NOT NULL ,
  `CALL_NUMBER` VARCHAR(2000) NULL ,
  `CALL_NUMBER_TYPE` VARCHAR(80) NULL ,
  `ITEM_AVAIL_STATUS_ID` INT NOT NULL ,
  `COPY_NUMBER` INT NULL ,
  `OWNING_INST_ID` INT NOT NULL ,
  `COLLECTION_GROUP_ID` INT NOT NULL ,
  `CREATED_DATE` DATETIME NOT NULL ,
  `LAST_UPDATED_DATE` DATETIME NULL ,
  `BIBLIOGRAPHIC_ID` INT NOT NULL ,
  `USE_RESTRICTIONS` VARCHAR(2000) NULL ,
  `VOLUME_PART_YEAR` VARCHAR(2000) NULL ,
  `OWNING_INST_ITEM_ID` VARCHAR(45) NOT NULL ,
  `NOTES_ID` INT NULL ,
  PRIMARY KEY (`ITEM_ID`) ,
  INDEX `HOLDINGS_ID_FK_idx` (`HOLDINGS_ID` ASC) ,
  INDEX `ITEM_AVAIL_STATUS_ID_FK_idx` (`ITEM_AVAIL_STATUS_ID` ASC) ,
  INDEX `OWNING_INST_FK_idx` (`OWNING_INST_ID` ASC) ,
  INDEX `COLLECTION_TYPE_FK_idx` (`COLLECTION_GROUP_ID` ASC) ,
  UNIQUE INDEX `OWNING_INST_ID_ITEM_ID_UNIQUE` (`OWNING_INST_ITEM_ID` ASC, `OWNING_INST_ID` ASC) ,
  CONSTRAINT `ITEM_HOLDINGS_ID_FK`
    FOREIGN KEY (`HOLDINGS_ID` )
    REFERENCES `recap`.`HOLDINGS_T` (`HOLDINGS_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ITEM_AVAIL_STATUS_ID_FK`
    FOREIGN KEY (`ITEM_AVAIL_STATUS_ID` )
    REFERENCES `recap`.`ITEM_STATUS_T` (`ITEM_STATUS_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ITEM_OWNING_INST_ID_FK`
    FOREIGN KEY (`OWNING_INST_ID` )
    REFERENCES `recap`.`INSTITUTION_T` (`INSTITUTION_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ITEM_COLLECTION_GROUP_FK`
    FOREIGN KEY (`COLLECTION_GROUP_ID` )
    REFERENCES `recap`.`COLLECTION_GROUP_T` (`COLLECTION_GROUP_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `recap`.`REQUEST_TYPE_T`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `recap`.`REQUEST_TYPE_T` (
  `REQUEST_TYPE_ID` INT NOT NULL AUTO_INCREMENT ,
  `REQUEST_TYPE_CODE` VARCHAR(45) NOT NULL ,
  `REQUEST_TYPE_DESC` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`REQUEST_TYPE_ID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recap`.`PATRON_T`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `recap`.`PATRON_T` (
  `PATRON_ID` INT NOT NULL AUTO_INCREMENT ,
  `INST_IDENTIFIER` VARCHAR(45) NULL ,
  `INST_ID` INT NOT NULL ,
  `EMAIL_ID` VARCHAR(45) NULL ,
  PRIMARY KEY (`PATRON_ID`) ,
  CONSTRAINT `PATRON_INST_ID_FK`
    FOREIGN KEY (`INST_ID` )
    REFERENCES `recap`.`INSTITUTION_T` (`INSTITUTION_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recap`.`REQUEST_ITEM_T`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `recap`.`REQUEST_ITEM_T` (
  `REQUEST_ID` INT NOT NULL AUTO_INCREMENT ,
  `ITEM_ID` INT NOT NULL ,
  `REQUEST_TYPE_ID` INT NOT NULL ,
  `REQ_EXP_DATE` DATETIME NULL ,
  `CREATD_DATE` DATETIME NOT NULL ,
  `LAST_UPDATED_DATE` DATETIME NULL ,
  `PATRON_ID` INT NOT NULL ,
  `REQUEST_POSITION` INT NOT NULL ,
  `STOP_CODE` VARCHAR(2) NOT NULL ,
  PRIMARY KEY (`REQUEST_ID`) ,
  INDEX `ITEM_ID_FK_idx` (`ITEM_ID` ASC) ,
  INDEX `REQUEST_TYPE_ID_FK_idx` (`REQUEST_TYPE_ID` ASC) ,
  UNIQUE INDEX `REQUEST_POSITION_ITEM_ID_PATRON_IDUNIQUE` (`REQUEST_POSITION` ASC, `PATRON_ID` ASC, `ITEM_ID` ASC) ,
  INDEX `PATRON_ID_FK_idx` (`PATRON_ID` ASC) ,
  CONSTRAINT `REQUEST_ITEM_ID_FK`
    FOREIGN KEY (`ITEM_ID` )
    REFERENCES `recap`.`ITEM_T` (`ITEM_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `REQUEST_TYPE_ID_FK`
    FOREIGN KEY (`REQUEST_TYPE_ID` )
    REFERENCES `recap`.`REQUEST_TYPE_T` (`REQUEST_TYPE_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `REQUEST_PATRON_ID_FK`
    FOREIGN KEY (`PATRON_ID` )
    REFERENCES `recap`.`PATRON_T` (`PATRON_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recap`.`BIBLIOGRAPHIC_HOLDINGS_T`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `recap`.`BIBLIOGRAPHIC_HOLDINGS_T` (
  `BIBLIOGRAPHIC_HOLDINGS_ID` INT NOT NULL AUTO_INCREMENT ,
  `BIBLIOGRAPHIC_ID` INT NOT NULL ,
  `HOLDINGS_ID` INT NOT NULL ,
  PRIMARY KEY (`BIBLIOGRAPHIC_HOLDINGS_ID`) ,
  INDEX `HOLDINGS_ID_idx` (`HOLDINGS_ID` ASC) ,
  INDEX `BIBLIOGRAPHIC_ID_idx` (`BIBLIOGRAPHIC_ID` ASC) ,
  CONSTRAINT `HOLDINGS_ID_FK`
    FOREIGN KEY (`HOLDINGS_ID` )
    REFERENCES `recap`.`HOLDINGS_T` (`HOLDINGS_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `BIBLIOGRAPHIC_ID_FK`
    FOREIGN KEY (`BIBLIOGRAPHIC_ID` )
    REFERENCES `recap`.`BIBLIOGRAPHIC_T` (`BIBLIOGRAPHIC_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recap`.`LOAN_T`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `recap`.`LOAN_T` (
  `LOAN_ID` INT NOT NULL AUTO_INCREMENT ,
  `ITEM_ID` INT NOT NULL ,
  `LOAN_DUE_DATE` DATETIME NOT NULL ,
  `PATRON_ID` INT NOT NULL ,
  PRIMARY KEY (`LOAN_ID`) ,
  UNIQUE INDEX `ITEM_ID_UNIQUE` (`ITEM_ID` ASC) ,
  INDEX `PATRON_ID_FK_idx` (`PATRON_ID` ASC) ,
  CONSTRAINT `LOAN_ITEM_ID_FK`
    FOREIGN KEY (`ITEM_ID` )
    REFERENCES `recap`.`ITEM_T` (`ITEM_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `LOAN_PATRON_ID_FK`
    FOREIGN KEY (`PATRON_ID` )
    REFERENCES `recap`.`PATRON_T` (`PATRON_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recap`.`AUDIT_T`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `recap`.`AUDIT_T` (
  `AUDIT_ID` INT NOT NULL AUTO_INCREMENT ,
  `TABLE_NAME` VARCHAR(45) NOT NULL ,
  `COLUMN_UPDATED` VARCHAR(45) NOT NULL ,
  `VALUE` BLOB NOT NULL ,
  `DATE_TIME_UPDATED` DATETIME NOT NULL ,
  PRIMARY KEY (`AUDIT_ID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recap`.`NOTES_T`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `recap`.`NOTES_T` (
  `NOTES_ID` INT NOT NULL AUTO_INCREMENT ,
  `NOTES` VARCHAR(2000) NULL ,
  `ITEM_ID` INT NULL ,
  `REQUEST_ID` INT NULL ,
  PRIMARY KEY (`NOTES_ID`) ,
  INDEX `ITEM_ID_FK_idx` (`ITEM_ID` ASC) ,
  INDEX `REQUEST_ID_FK_idx` (`REQUEST_ID` ASC) ,
  CONSTRAINT `NOTES_ITEM_ID_FK`
    FOREIGN KEY (`ITEM_ID` )
    REFERENCES `recap`.`ITEM_T` (`ITEM_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `NOTES_REQUEST_ID_FK`
    FOREIGN KEY (`REQUEST_ID` )
    REFERENCES `recap`.`REQUEST_ITEM_T` (`REQUEST_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recap`.`ITEM_TRACKING_INFO_T`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `recap`.`ITEM_TRACKING_INFO_T` (
  `TRACKING_INFO_ID` INT NOT NULL AUTO_INCREMENT ,
  `TRACKING_STATUS_ID` INT NOT NULL ,
  `BIN_NUMBER` VARCHAR(45) NOT NULL ,
  `ITEM_ID` INT NULL ,
  `UPDATED_DATETIME` DATETIME NOT NULL ,
  PRIMARY KEY (`TRACKING_INFO_ID`) ,
  INDEX `TRACKING_STATUS_ID_FK_idx` (`TRACKING_STATUS_ID` ASC) ,
  INDEX `ITEM_ID_FK_idx` (`ITEM_ID` ASC) ,
  CONSTRAINT `TRACKING_STATUS_ID_FK`
    FOREIGN KEY (`TRACKING_STATUS_ID` )
    REFERENCES `recap`.`ITEM_STATUS_T` (`ITEM_STATUS_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `TRACKING_INFO_ITEM_ID_FK`
    FOREIGN KEY (`ITEM_ID` )
    REFERENCES `recap`.`ITEM_T` (`ITEM_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recap`.`BIBLIOGRAPHIC_ITEM_T`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `recap`.`BIBLIOGRAPHIC_ITEM_T` (
  `BIBLIOGRAPHIC_ITEM_ID` INT NOT NULL AUTO_INCREMENT ,
  `BIBLIOGRAPHIC_ID` INT NOT NULL ,
  `ITEM_ID` INT NOT NULL ,
  PRIMARY KEY (`BIBLIOGRAPHIC_ITEM_ID`) ,
  INDEX `BIBLIOGRAPHIC_ID_idx` (`BIBLIOGRAPHIC_ID` ASC) ,
  INDEX `ITEM_ID_idx` (`ITEM_ID` ASC) ,
  CONSTRAINT `BIBLIOGRAPHIC_ITEM_BIBLIOGRAPHIC_ID_FK`
    FOREIGN KEY (`BIBLIOGRAPHIC_ID` )
    REFERENCES `recap`.`BIBLIOGRAPHIC_T` (`BIBLIOGRAPHIC_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `BIBLIOGRAPHIC_ITEM_ITEM_ID_FK`
    FOREIGN KEY (`ITEM_ID` )
    REFERENCES `recap`.`ITEM_T` (`ITEM_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
