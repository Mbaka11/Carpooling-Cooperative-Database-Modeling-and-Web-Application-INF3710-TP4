SET search_path to Coovoiturage_schema;

CREATE OR REPLACE FUNCTION placer_a_vendre()
RETURNS TRIGGER AS $mit_en_vente$
BEGIN
		-- Créer la table AVENDRE si elle n'existe pas encore
		CREATE TABLE IF NOT EXISTS AVENDRE (
				noImmatriculation VARCHAR(50) NOT NULL,
        odometre INT NOT NULL,
        maxOdometre INT NOT NULL,
        dateMiseEnService DATE NOT NULL,
        consommationEssence DECIMAL(5,2) NOT NULL,
        tarifHoraire DECIMAL(5,2) NOT NULL,
        tarifKilometrage DECIMAL(5,2) NOT NULL,
        marque VARCHAR(50) NOT NULL,
        modele VARCHAR(50) NOT NULL,
        Emplacement VARCHAR(50),
        PRIMARY KEY(noImmatriculation),
        FOREIGN KEY(Emplacement) REFERENCES Coovoiturage_schema.Emplacement(nom)
		);

		-- Insérer les informations du véhicule dans la table AVENDRE
		INSERT INTO AVENDRE (noImmatriculation, odometre, maxOdometre, dateMiseEnService, consommationEssence, tarifHoraire, tarifKilometrage, marque, modele, Emplacement)
		SELECT * FROM Vehicule WHERE noImmatriculation = NEW.noImmatriculation;

	RETURN NEW;

END;
$mit_en_vente$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER verifier_a_vendre AFTER INSERT ON Vehicule FOR EACH ROW WHEN (NEW.maxOdometre <= NEW.odometre) EXECUTE FUNCTION placer_a_vendre();