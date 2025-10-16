-- Creació de la Base de Dades
CREATE DATABASE IF NOT EXISTS `gestio_sanitaria_hce`;
USE `gestio_sanitaria_hce`;

-- -----------------------------------------------------
-- Taula: INFERMER (Login/Registre) 
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `INFERMER` (
  `ID_INFERMER` INT NOT NULL AUTO_INCREMENT,
  `USUARI` VARCHAR(50) NOT NULL UNIQUE,
  `PASSWORD_HASH` CHAR(64) NOT NULL,
  `NOM` VARCHAR(100) NOT NULL,
  `COGNOMS` VARCHAR(100) NOT NULL,
  `IMATGE_PERFIL` VARCHAR(255),
  `DATA_ALTA` DATE,
  PRIMARY KEY (`ID_INFERMER`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Taula: PACIENT
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PACIENT` (
  `ID_PACIENT` INT NOT NULL AUTO_INCREMENT,
  `N_HISTORIA` VARCHAR(20) NOT NULL UNIQUE,
  `NOM` VARCHAR(100) NOT NULL,
  `COGNOMS` VARCHAR(100) NOT NULL,
  `DATA_NAIXEMENT` DATE,
  `ALERGIES` TEXT,
  PRIMARY KEY (`ID_PACIENT`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Taula: INGRES (Episodi) [cite: 7]
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `INGRES` (
  `ID_INGRES` INT NOT NULL AUTO_INCREMENT,
  `ID_PACIENT` INT NOT NULL,
  `DATA_INGRES` DATETIME NOT NULL,
  `UNITAT` VARCHAR(50), -- p. ex., Medicina Interna
  `HABITACIO` VARCHAR(10),
  `CAMA` VARCHAR(10),
  `DATA_ALTA` DATETIME NULL,
  PRIMARY KEY (`ID_INGRES`),
  FOREIGN KEY (`ID_PACIENT`) REFERENCES `PACIENT` (`ID_PACIENT`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Taula: CONSTANTS_VITALS (Per a la gràfica )
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CONSTANTS_VITALS` (
  `ID_CONSTANT` INT NOT NULL AUTO_INCREMENT,
  `ID_INGRES` INT NOT NULL,
  `ID_INFERMER` INT NOT NULL,
  `DATA_HORA` DATETIME NOT NULL,
  `TEMP_C` DECIMAL(4,1),
  `PULSACIONS` INT,
  `TENSIO_SISTOLICA` INT,
  `TENSIO_DIASTOLICA` INT,
  `OBSERVACIONS` TEXT,
  PRIMARY KEY (`ID_CONSTANT`),
  FOREIGN KEY (`ID_INGRES`) REFERENCES `INGRES` (`ID_INGRES`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (`ID_INFERMER`) REFERENCES `INFERMER` (`ID_INFERMER`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  UNIQUE INDEX `UK_CONSTANTES_HORA` (`ID_INGRES`, `DATA_HORA`) -- Evita duplicats
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Taula: OBSERVACIONS_GENERALS (Dades diàries)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OBSERVACIONS_GENERALS` (
  `ID_OBS` INT NOT NULL AUTO_INCREMENT,
  `ID_INGRES` INT NOT NULL,
  `ID_INFERMER` INT NOT NULL,
  `DATA_DIA` DATE NOT NULL,
  `PES_KG` DECIMAL(5,2),
  `TALLA_M` DECIMAL(3,2),
  `DIETA` VARCHAR(50), -- p. ex., Blanda [cite: 39, 40]
  `OXIGEN` VARCHAR(20), -- p. ex., Normal [cite: 15]
  `INDEX_NORTON` INT, -- [cite: 16]
  `NIVELL_DEPENDENCIA` VARCHAR(20), -- [cite: 17]
  `ESPECTORACIO` TEXT, -- [cite: 48]
  `DEPOSICIONS` INT, -- Freqüència [cite: 49]
  PRIMARY KEY (`ID_OBS`),
  FOREIGN KEY (`ID_INGRES`) REFERENCES `INGRES` (`ID_INGRES`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (`ID_INFERMER`) REFERENCES `INFERMER` (`ID_INFERMER`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  UNIQUE INDEX `UK_OBSERVACIONES_DIA` (`ID_INGRES`, `DATA_DIA`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Taula: BALANC_ITEMS (Detall Entrades/Sortides )
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BALANC_ITEMS` (
  `ID_BALANC_ITEM` INT NOT NULL AUTO_INCREMENT,
  `ID_INGRES` INT NOT NULL,
  `ID_INFERMER` INT NOT NULL,
  `DATA_HORA` DATETIME NOT NULL,
  `TIPUS` ENUM('ENTRADA', 'SORTIDA') NOT NULL,
  `ITEM_DETALL` VARCHAR(100), -- p. ex., Sèrum Salí 0.9% [cite: 22], Diüresi [cite: 46]
  `VOLUM_ML` INT NOT NULL,
  PRIMARY KEY (`ID_BALANC_ITEM`),
  FOREIGN KEY (`ID_INGRES`) REFERENCES `INGRES` (`ID_INGRES`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (`ID_INFERMER`) REFERENCES `INFERMER` (`ID_INFERMER`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Taula: BALANC_DIARI (Resum diari, per a Balanç i Acumulat [cite: 72, 81])
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BALANC_DIARI` (
  `ID_BALANC_DIARI` INT NOT NULL AUTO_INCREMENT,
  `ID_INGRES` INT NOT NULL,
  `DATA_DIA` DATE NOT NULL,
  `TOTAL_ENTRADES` INT, -- Calculat amb trigger o procés
  `TOTAL_SORTIDES` INT, -- Calculat
  `PERDUES_INSENSIBLES` INT, -- Dades fixes del dia [cite: 60]
  `BALANC_NET` INT, -- Calculat: Entrades - Sortides
  `BALANC_ACUMULAT` INT, -- Calculat
  PRIMARY KEY (`ID_BALANC_DIARI`),
  FOREIGN KEY (`ID_INGRES`) REFERENCES `INGRES` (`ID_INGRES`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  UNIQUE INDEX `UK_BALANCEDAY` (`ID_INGRES`, `DATA_DIA`)
) ENGINE = InnoDB;
