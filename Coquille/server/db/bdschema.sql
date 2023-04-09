DROP SCHEMA IF EXISTS Coovoiturage_schema CASCADE;
CREATE SCHEMA Coovoiturage_schema;
SET search_path TO Coovoiturage_schema;

CREATE TABLE IF NOT EXISTS Coovoiturage_schema.Emplacement(
    nom VARCHAR(50) NOT NULL,
    adresse VARCHAR(50) NOT NULL,
    carte VARCHAR(50) NOT NULL,
    nbEmplacement INT NOT NULL,
    PRIMARY KEY(nom)
)

CREATE TABLE IF NOT EXISTS Coovoiturage_schema.Vehicule(
    noImmatriculation VARCHAR(50) NOT NULL,
    odometre INT NOT NULL,
    dateMiseEnService DATE NOT NULL,
    consommationEssence DECIMAL(5,2) NOT NULL,
    tarifHoraire DECIMAL(5,2) NOT NULL,
    tarifKilometrage DECIMAL(5,2) NOT NULL,
    Emplacement VARCHAR(50) NOT NULL,
    PRIMARY KEY(noImmatriculation),
    FOREIGN KEY(Emplacement) REFERENCES Coovoiturage_schema.Emplacement(nom)
)

CREATE TABLE IF NOT EXISTS Coovoiturage_schema.Hybride(
    noImmatriculation VARCHAR(50) NOT NULL,
    kilowattsRecharge INT NOT NULL,
    PRIMARY KEY(noImmatriculation),
    FOREIGN KEY(noImmatriculation) REFERENCES Coovoiturage_schema.Vehicule(noImmatriculation)
)

CREATE TABLE IF NOT EXISTS Coovoiturage_schema.Reguliere(
    noImmatriculation VARCHAR(50) NOT NULL,
    PRIMARY KEY(noImmatriculation),
    FOREIGN KEY(noImmatriculation) REFERENCES Coovoiturage_schema.Vehicule(noImmatriculation)
)

CREATE TABLE IF NOT EXISTS Coovoiturage_schema.MiniCamionnette(
    noImmatriculation VARCHAR(50) NOT NULL,
    PRIMARY KEY(noImmatriculation),
    FOREIGN KEY(noImmatriculation) REFERENCES Coovoiturage_schema.Vehicule(noImmatriculation)
)

CREATE TABLE IF NOT EXISTS Coovoiturage_schema.AssuranceAutomobile(
    noAssurance VARCHAR(50) NOT NULL,
    dateDebut DATE NOT NULL,
    dateFin DATE NOT NULL,
    assureur VARCHAR(255) NOT NULL,
    noImmatriculation VARCHAR(50) NOT NULL,
    PRIMARY KEY(noAssurance),
    FOREIGN KEY(noImmatriculation) REFERENCES Coovoiturage_schema.Vehicule(noImmatriculation)
)

CREATE TABLE IF NOT EXISTS Coovoiturage_schema.Membre(
    noMembre INT NOT NULL,
    noPermisDeConduire VARCHAR(50) NOT NULL,
    adressePostale VARCHAR(255) NOT NULL,
    adresseCourriel VARCHAR(255) NOT NULL,
    noCompteBancaire INT NOT NULL,
    nomBanque VARCHAR(255) NOT NULL,
    motDePasse VARCHAR(255) NOT NULL,
    emplacementFavori VARCHAR(50) NOT NULL,
    PRIMARY KEY(noMembre),
    FOREIGN KEY(emplacementFavori) REFERENCES Coovoiturage_schema.Emplacement(nom)
)

CREATE TABLE IF NOT EXISTS Coovoiturage_schema.MembreCooperative(
    noMembre INT NOT NULL,
    montantParts DECIMAL(10,2) NOT NULL,
    PRIMARY KEY(noMembre),
    FOREIGN KEY(noMembre) REFERENCES Coovoiturage_schema.Membre(noMembre)
)

CREATE TABLE IF NOT EXISTS Coovoiturage_schema.MembreAutopartage(
    noMembre INT NOT NULL,
    cotisationAnnuelle DECIMAL(10,2) NOT NULL,
    PRIMARY KEY(noMembre),
    FOREIGN KEY(noMembre) REFERENCES Coovoiturage_schema.Membre(noMembre)
)

CREATE TABLE IF NOT EXISTS Coovoiturage_schema.MembrePhysique(
    noMembre INT NOT NULL,
    cotisationAnnuelle DECIMAL(10,2) NOT NULL,
    age INT NOT NULL,
    dateDernierAccident DATE NOT NULL,
    PRIMARY KEY(noMembre),
    FOREIGN KEY(noMembre) REFERENCES Coovoiturage_schema.Membre(noMembre)
)

CREATE TABLE IF NOT EXISTS Coovoiturage_schema.MembreMorale(
    noMembre INT NOT NULL,
    cotisationAnnuelle DECIMAL(10,2) NOT NULL,
    PRIMARY KEY(noMembre),
    FOREIGN KEY(noMembre) REFERENCES Coovoiturage_schema.Membre(noMembre)
)

CREATE TABLE IF NOT EXISTS Coovoiturage_schema.Facture(
    idFacture INT NOT NULL,
    dateFacuration DATE NOT NULL,
    dateEcheance DATE NOT NULL,
    noMembre INT NOT NULL,
    montantTotal DECIMAL(10,2) NOT NULL,
    estPayee BOOLEAN NOT NULL,
    PRIMARY KEY(idFacture),
    FOREIGN KEY(noMembre) REFERENCES Coovoiturage_schema.Membre(noMembre)
)

CREATE TABLE IF NOT EXISTS Coovoiturage_schema.Reservation(
    idReservation INT NOT NULL,
    dateDebut DATE NOT NULL,
    dateFin DATE NOT NULL,
    exigences VARCHAR(255) NOT NULL,
    noMembre INT NOT NULL,
    noImmatriculation VARCHAR(50) NOT NULL,
    PRIMARY KEY(idReservation),
    FOREIGN KEY(noMembre) REFERENCES Coovoiturage_schema.Membre(noMembre),
    FOREIGN KEY(noImmatriculation) REFERENCES Coovoiturage_schema.Vehicule(noImmatriculation)
)

CREATE TABLE IF NOT EXISTS Coovoiturage_schema.Utilisation(
    idUtilisation INT NOT NULL,
    odometreDebut INT NOT NULL,
    odometreFin INT NOT NULL,
    idReservation INT NOT NULL,
    idFacture INT NOT NULL,
    PRIMARY KEY(idUtilisation),
    FOREIGN KEY(idReservation) REFERENCES Coovoiturage_schema.Reservation(idReservation),
    FOREIGN KEY(idFacture) REFERENCES Coovoiturage_schema.Facture(idFacture)
)


