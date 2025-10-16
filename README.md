# 🧠 Conceptual Model — Programa de Gestió de Dades Sanitàries

This conceptual model describes the main **entities**, their **attributes**, and **relationships** in the healthcare data management system.

---

## 🧩 Entities and Attributes

### 👩‍⚕️ Infermer (Nurse)
- **id_infermer** (PK)
- nom
- cognoms
- email
- contrasenya
- imatge_perfil
- data_registre

### 🧍‍♂️ Pacient (Patient)
- **id_pacient** (PK)
- nom
- cognoms
- data_naixement
- sexe
- adreca
- telefon
- data_ingres

### 📘 HistoriaClinica (Clinical History)
- **id_historia** (PK)
- id_pacient (FK → Pacient)
- id_infermer (FK → Infermer)
- data_registre
- observacions

### ❤️ ConstantsVitals (Vital Signs)
- **id_constant** (PK)
- id_historia (FK → HistoriaClinica)
- temperatura
- pressio_sistolica
- pressio_diastolica
- pulsacions
- saturacio_oxigen
- data_mesura

### 🧼 Higiene (Hygiene)
- **id_higiene** (PK)
- id_historia (FK → HistoriaClinica)
- tipus
- observacions
- data_registre

### 💊 Medicacio (Medication)
- **id_medicacio** (PK)
- id_historia (FK → HistoriaClinica)
- nom_medicament
- dosi
- via_administracio
- horari

### 🍽️ Dieta (Diet)
- **id_dieta** (PK)
- id_historia (FK → HistoriaClinica)
- tipus_dieta
- observacions

---

## 🔗 Relationships

| Relationship | Type | Description |
|---------------|------|--------------|
| **Infermer – HistoriaClinica** | 1 ⟶ N | One nurse can manage many clinical records |
| **Pacient – HistoriaClinica** | 1 ⟶ N | One patient can have multiple clinical records |
| **HistoriaClinica – ConstantsVitals** | 1 ⟶ N | Each record can store many vital signs entries |
| **HistoriaClinica – Higiene** | 1 ⟶ N | Each record can include several hygiene activities |
| **HistoriaClinica – Medicacio** | 1 ⟶ N | Each record can include multiple medications |
| **HistoriaClinica – Dieta** | 1 ⟶ N | Each record can define one or more diet plans |

---

📘 *This conceptual model forms the basis for the logical (MySQL) database implementation of the healthcare data management system.*
