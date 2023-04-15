-- 1. Retournez la marque, le modèle et l’emplacement d’origine des véhicules
SELECT marque, modele, Emplacement 
FROM Vehicule
WHERE Emplacement IS NOT NULL;

-- 2. Retournez la marque, le modèle et l’emplacement d’origine des véhicules y compris les marques et modèles qui n’ont pas de localisation
SELECT marque, modele, Emplacement 
FROM Vehicule;

-- 3. Retournez les emplacements sans véhicules
SELECT Emplacement.*
FROM Emplacement
    LEFT OUTER JOIN Vehicule 
    ON Emplacement.nom = Vehicule.Emplacement
WHERE Vehicule.Emplacement IS NULL;

-- 4. Retournez tous les véhicules dont le domicile est situé dans la ville de Montréal 
SELECT Vehicule.*
FROM Vehicule
    LEFT OUTER JOIN Emplacement 
    ON Emplacement.nom = Vehicule.Emplacement
WHERE adresse LIKE '%Montréal%';

-- 5. Retournez les emplacements et le nombre de voitures hybrides à chaque emplacement
SELECT Emplacement.*, 
    COUNT(noImmatriculation) as nbVehiculesHybrides
FROM Emplacement 
    LEFT OUTER JOIN (
        Vehicule NATURAL JOIN Hybride
    ) ON Emplacement.nom = Vehicule.Emplacement 
GROUP BY Emplacement.nom;

-- 6. Retournez les plaques d’immatriculation des véhicules qui ont été utilisés (pas seulement réservés)
SELECT noImmatriculation
FROM utilisation NATURAL JOIN reservation;

-- 7. Retournez toutes les informations des membres (personnes physiques) vivant dans une ville avec un emplacement qui a des voitures hybrides
SELECT Membre.*
FROM Membre NATURAL JOIN MembrePhysique
WHERE SPLIT_PART(adressePostale, ',', 2) IN (
    SELECT SPLIT_PART(adresse, ',', 2) AS ville
    FROM Emplacement 
        LEFT OUTER JOIN (
            Vehicule NATURAL JOIN Hybride
        ) ON Emplacement.nom = Vehicule.Emplacement 
    GROUP BY SPLIT_PART(adresse, ',', 2)
)

-- 8. Retournez toutes les informations des véhicules à l’emplacement Montréal qui sont libres le 23/01/2023 à 10 h
SELECT Vehicule.*
FROM Emplacement INNER JOIN (Reservation INNER JOIN Vehicule ON Reservation.noImmatriculation = Vehicule.noImmatriculation) ON Emplacement.nom = Vehicule.Emplacement 
WHERE (Reservation.dateDebut > '2023-01-25 10:00:00' OR Reservation.dateFin < '2023-01-25 10:00:00') AND adresse LIKE '%Montréal%'

-- 9. Retournez les plaques d’immatriculation et le nombre de réservations de chaque véhicule (y compris ceux sans réservation, c’est-à-dire que le nombre de réservations est 0)
SELECT Vehicule.noImmatriculation, COUNT(Vehicule.noImmatriculation) AS nbrReservations
FROM Reservation 
NATURAL JOIN Vehicule 
GROUP BY Vehicule.noImmatriculation;

-- 10. Quel est le véhicule avec la consommation de carburant la plus élevée ?
SELECT * 
FROM Coovoiturage_schema.Vehicule 
ORDER BY consommationEssence DESC LIMIT 1;

-- 11. Retournez la consommation de carburant maximale, moyenne et minimale par catégorie de véhicule
SELECT 
    c.categorie,
    MAX(v.consommationEssence) AS consommation_max,
    AVG(v.consommationEssence) AS consommation_moyenne,
    MIN(v.consommationEssence) AS consommation_min
FROM Coovoiturage_schema.Vehicule v
JOIN (
    SELECT noImmatriculation, 'Hybride' AS categorie FROM Coovoiturage_schema.Hybride
    UNION ALL
    SELECT noImmatriculation, 'Reguliere' AS categorie FROM Coovoiturage_schema.Reguliere
    UNION ALL
    SELECT noImmatriculation, 'MiniCamionnette' AS categorie FROM Coovoiturage_schema.MiniCamionnette
) c ON v.noImmatriculation = c.noImmatriculation
GROUP BY c.categorie;

-- 12. Retournez tous les membres qui ont réservé un véhicule à un endroit autre que leur emplacement d’origine même si le type de véhicule existe à leur emplacement d’origine
SELECT DISTINCT Vehicule.noImmatriculation
FROM (Membre NATURAL JOIN Reservation) 
	JOIN Vehicule ON Vehicule.noImmatriculation = Reservation.noImmatriculation
WHERE Membre.emplacementFavori != Vehicule.Emplacement;
