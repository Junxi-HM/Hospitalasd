# 🧠 Conceptual Model (Class Diagram)

```mermaid
classDiagram
    class Infermer {
        +id_infermer: INT
        +nom: VARCHAR(100)
        +cognoms: VARCHAR(150)
        +email: VARCHAR(100)
        +contrasenya: VARCHAR(255)
        +imatge_perfil: VARCHAR(255)
        +data_registre: DATETIME
    }

    class Pacient {
        +id_pacient: INT
        +nom: VARCHAR(100)
        +cognoms: VARCHAR(150)
        +data_naixement: DATE
        +sexe: ENUM(Home, Dona, Altres)
        +adreca: VARCHAR(255)
        +telefon: VARCHAR(20)
        +data_ingres: DATETIME
    }

    class HistoriaClinica {
        +id_historia: INT
        +id_pacient: INT
        +id_infermer: INT
        +data_registre: DATETIME
        +observacions: TEXT
    }

    class ConstantsVitals {
        +id_constant: INT
        +id_historia: INT
        +temperatura: DECIMAL(4,1)
        +pressio_sistolica: INT
        +pressio_diastolica: INT
        +pulsacions: INT
        +saturacio_oxigen: INT
        +data_mesura: DATETIME
    }

    class Higiene {
        +id_higiene: INT
        +id_historia: INT
        +tipus: VARCHAR(100)
        +observacions: TEXT
        +data_registre: DATETIME
    }

    class Medicacio {
        +id_medicacio: INT
        +id_historia: INT
        +nom_medicament: VARCHAR(100)
        +dosi: VARCHAR(50)
        +via_administracio: VARCHAR(50)
        +horari: VARCHAR(50)
    }

    class Dieta {
        +id_dieta: INT
        +id_historia: INT
        +tipus_dieta: VARCHAR(100)
        +observacions: TEXT
    }

    %% RELATIONSHIPS
    Infermer "1" --> "many" HistoriaClinica : registra
    Pacient "1" --> "many" HistoriaClinica : té
    HistoriaClinica "1" --> "many" ConstantsVitals : inclou
    HistoriaClinica "1" --> "many" Higiene : inclou
    HistoriaClinica "1" --> "many" Medicacio : inclou
    HistoriaClinica "1" --> "many" Dieta : inclou
