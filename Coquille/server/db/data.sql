SET search_path TO Coovoiturage_schema;

INSERT INTO Coovoiturage_schema.Emplacement (nom, adresse, carte, nbEmplacement) VALUES
('Place de la Chapelle', '310 rue Pascal, Laval, QC, J3G1G6', '34.654, 87.832', 20),
('Côte-des-Perron', '4213 rue Paname, Laval, QC, K4S8F4', '6476.5465, -564.3133', 15),
('Plage Idéal', '239 rue Bayard, Montréal, QC, O8J2F3', '45.652152, -73.757149', 45),
('Parc Ophille', '1420 rue Court, Montréal, QC, L9D1D3', '45.535727, -73.761444', 20);


INSERT INTO Coovoiturage_schema.Vehicule (noImmatriculation, odometre, dateMiseEnService, consommationEssence, tarifHoraire, tarifKilometrage, marque, modele, Emplacement) VALUES 
('WS7E63', 153631, '2001-10-10', 4, 10.5, 5, 'Toyota', 'Corolla', 'Place de la Chapelle'),
('1R3N6U', 104000, '2011-11-11', 3.5, 6.5, 2, 'Hyundai', 'Dantes', 'Côte-des-Perron'),
('5H6J8L', 2346, '2001-10-11', 2.5, 20.5, 6, 'Hyundai', 'Agua', 'Plage Idéal'),
('1J4F9A', 44134, '2021-03-20', 2, 10, 5, 'Kawai', 'Ine', 'Plage Idéal'),
('4K9D3G', 76033, '2014-01-23', 6, 5.5, 2, 'Pantola', 'Maznati', NULL);

INSERT INTO Coovoiturage_schema.Hybride (noImmatriculation, kilowattsRecharge) VALUES
('1R3N6U', 15),
('5H6J8L', 12),
('1J4F9A', 20);

INSERT INTO Coovoiturage_schema.Reguliere (noImmatriculation) VALUES
('WS7E63');

INSERT INTO Coovoiturage_schema.MiniCamionnette (noImmatriculation) VALUES
('4K9D3G');

INSERT INTO Coovoiturage_schema.Membre (noMembre, nom, noPermisDeConduire, adressePostale, adresseCourriel, noCompteBancaire, nomBanque, motDePasse, emplacementFavori) VALUES
(987143,'Muller Guerre', 'JFII38721K', '93 rue Sevran, Laval, QC, H9K1Y5', 'smallenergy@gmail.com', 742824642, 65473296, 'grangou431', 'Parc Ophille'),
(452643,'Jean-Claude Todibin', 'GHJU4932JM', '667 rue Mangemeau, Laval, QC, K9S3G5', 'legrandjg@gmail.com', 674413234, 98503845, 'motdepassecomplique', 'Place de la Chapelle'),
(631571,'Lucas Kapoera', 'NU183FN328', '5532 rue Parlezom, Sorel-Tracy, QC, J3F4G6', 'magicmonster@gmail.com', 315465533, 48310481, 'mangezdupoulet', 'Plage Idéal');

INSERT INTO Coovoiturage_schema.MembreAutopartage (noMembre, cotisationAnnuelle) VALUES 
(987143, 600);

INSERT INTO Coovoiturage_schema.MembrePhysique (noMembre, cotisationAnnuelle, age, dateDernierAccident) VALUES 
(452643, 57.67, 34, '2018-11-04'),
(631571, 12, 45 , '2022-10-10');

INSERT INTO Coovoiturage_schema.Facture (idFacture, dateFacuration, dateEcheance, noMembre, montantTotal, estPayee) VALUES
(414612, '2023-03-20', '2023-03-22', 987143, 200, true);

INSERT INTO Coovoiturage_schema.Reservation (idReservation, dateDebut, dateFin, exigences,noMembre, noImmatriculation) VALUES
(235613, '2023-03-22 12:00:00', '2023-03-25 12:00:00', 'petit café', 987143, 'WS7E63'),
(764534, '2023-01-20 09:00:00', '2023-01-21 09:00:00', 'voiture propre', 631571, '1J4F9A'),
(353744, '2023-01-23 09:00:00', '2023-01-25 09:00:00', 'présentation agréable', 631571, '1J4F9A');
