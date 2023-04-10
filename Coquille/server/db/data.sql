SET search_path TO Coovoiturage_schema;

INSERT INTO Coovoiturage_schema.Emplacement VALUES ('Montreal', '1234 rue de la Paix', 'Montreal', 10);
INSERT INTO Coovoiturage_schema.Emplacement VALUES ('Miami', '1234 rue de la Paix', 'Miami', 10);
INSERT INTO Coovoiturage_schema.Emplacement VALUES ('Quebec', '1234 rue de la Paix', 'Quebec', 10);
INSERT INTO Coovoiturage_schema.Emplacement VALUES ('London', '1234 rue de la Paix', 'London', 10);
INSERT INTO Coovoiturage_schema.Emplacement VALUES ('Rio de Janeiro', '1234 rue do Brasil', 'Rio de Janeiro', 10);

INSERT INTO Coovoiturage_schema.Membre VALUES (1, 'John Doe', 'P1', '1234 rue de la Paix', 'JohnDoe@yopmail.com', 1, 'Banque Nationale', 'mdp1', 'Montreal');
INSERT INTO Coovoiturage_schema.Membre VALUES (2, 'Jane Doe', 'P2', '1234 rue de la Paix', 'JaneDoe@yopmail.com', 2, 'Banque Nationale', 'mdp2', 'Miami');
INSERT INTO Coovoiturage_schema.Membre VALUES (3, 'John Smith', 'P3', '1234 rue de la Paix', 'JohnSmite@yopmail.com', 3, 'Banque Nationale', 'mdp3', 'Quebec');
INSERT INTO Coovoiturage_schema.Membre VALUES (4, 'Gabriel Martinelli', 'P4', '1234 rue de la Paix', 'GabMar@yahoo.com', 4, 'London Bank', 'mdp4', 'London');
INSERT INTO Coovoiturage_schema.Membre VALUES (5, 'Neymar', 'P5', '1234 rue do Brasil', 'Neymar@gmail.com', 5, 'Brazil Bank', 'mdp5', 'Rio de Janeiro');

