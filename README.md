# 🏥 Health Data Management System (Programa de Gestió de Dades Sanitàries)

This project represents the **logical database model** for a healthcare data management system.  
It allows nurses to register patients, record vital signs, hygiene routines, medications, and diets — all linked to each patient’s clinical history.

---

## 🧩 Logical Model (MySQL)

```sql
CREATE TABLE Infermer (
    id_infermer INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    cognoms VARCHAR(150),
    email VARCHAR(100) UNIQUE NOT NULL,
    contrasenya VARCHAR(255) NOT NULL,
    imatge_perfil VARCHAR(255),
    data_registre DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Pacient (
    id_pacient INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    cognoms VARCHAR(150),
    data_naixement DATE,
    sexe ENUM('Home','Dona','Altres'),
    adreca VARCHAR(255),
    telefon VARCHAR(20),
    data_ingres DATETIME
);

CREATE TABLE HistoriaClinica (
    id_historia INT AUTO_INCREMENT PRIMARY KEY,
    id_pacient INT NOT NULL,
    id_infermer INT NOT NULL,
    data_registre DATETIME DEFAULT CURRENT_TIMESTAMP,
    observacions TEXT,
    FOREIGN KEY (id_pacient) REFERENCES Pacient(id_pacient),
    FOREIGN KEY (id_infermer) REFERENCES Infermer(id_infermer)
);

CREATE TABLE ConstantsVitals (
    id_constant INT AUTO_INCREMENT PRIMARY KEY,
    id_historia INT NOT NULL,
    temperatura DECIMAL(4,1),
    pressio_sistolica INT,
    pressio_diastolica INT,
    pulsacions INT,
    saturacio_oxigen INT,
    data_mesura DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_historia) REFERENCES HistoriaClinica(id_historia)
);

CREATE TABLE Higiene (
    id_higiene INT AUTO_INCREMENT PRIMARY KEY,
    id_historia INT NOT NULL,
    tipus VARCHAR(100),
    observacions TEXT,
    data_registre DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_historia) REFERENCES HistoriaClinica(id_historia)
);

CREATE TABLE Medicacio (
    id_medicacio INT AUTO_INCREMENT PRIMARY KEY,
    id_historia INT NOT NULL,
    nom_medicament VARCHAR(100),
    dosi VARCHAR(50),
    via_administracio VARCHAR(50),
    horari VARCHAR(50),
    FOREIGN KEY (id_historia) REFERENCES HistoriaClinica(id_historia)
);

CREATE TABLE Dieta (
    id_dieta INT AUTO_INCREMENT PRIMARY KEY,
    id_historia INT NOT NULL,
    tipus_dieta VARCHAR(100),
    observacions TEXT,
    FOREIGN KEY (id_historia) REFERENCES HistoriaClinica(id_historia)
);
