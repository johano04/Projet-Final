CREATE DATABASE IF NOT EXISTS db_s2_ETU004256;
USE db_s2_ETU004256;


CREATE TABLE membre (
    id_membre INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100),
    date_naissance DATE,
    genre ENUM('Homme', 'Femme', 'Autre'),
    email VARCHAR(100),
    ville VARCHAR(100),
    mdp VARCHAR(255),
    image_profil VARCHAR(255)
);


CREATE TABLE categorie_objet (
    id_categorie INT AUTO_INCREMENT PRIMARY KEY,
    nom_categorie VARCHAR(100)
);


CREATE TABLE objet (
    id_objet INT AUTO_INCREMENT PRIMARY KEY,
    nom_objet VARCHAR(100),
    id_categorie INT,
    id_membre INT,
    FOREIGN KEY (id_categorie) REFERENCES categorie_objet(id_categorie),
    FOREIGN KEY (id_membre) REFERENCES membre(id_membre)
);


CREATE TABLE images_objet (
    id_image INT AUTO_INCREMENT PRIMARY KEY,
    id_objet INT,
    nom_image VARCHAR(255),
    FOREIGN KEY (id_objet) REFERENCES objet(id_objet)
);

CREATE TABLE emprunt (
    id_emprunt INT AUTO_INCREMENT PRIMARY KEY,
    id_objet INT,
    id_membre INT,
    date_emprunt DATE,
    date_retour DATE,
    FOREIGN KEY (id_objet) REFERENCES objet(id_objet),
    FOREIGN KEY (id_membre) REFERENCES membre(id_membre)
);


INSERT INTO membre (nom, date_naissance, genre, email, ville, mdp, image_profil) VALUES
('Alice', '1995-05-12', 'Femme', 'alice@example.com', 'Tana', 'mdp123', 'alice.jpg'),
('Bob', '1990-07-23', 'Homme', 'bob@example.com', 'Majunga', 'mdp123', 'bob.jpg'),
('Claire', '1988-09-15', 'Femme', 'claire@example.com', 'Fianarantsoa', 'mdp123', 'claire.jpg'),
('David', '2000-12-01', 'Homme', 'david@example.com', 'Toamasina', 'mdp123', 'david.jpg');

INSERT INTO categorie_objet (nom_categorie) VALUES
('Esthetique'), ('Bricolage'), ('Mecanique'), ('Cuisine');



INSERT INTO objet (nom_objet, id_categorie, id_membre) VALUES
('Seche-cheveux', 1, 1), ('Maquillage', 1, 1), ('Tournevis', 2, 1), ('Perceuse', 2, 1),
('Clé anglaise', 3, 1), ('Pompe à vélo', 3, 1), ('Mixeur', 4, 1), ('Casserole', 4, 1),
('Pinceau maquillage', 1, 1), ('Four electrique', 4, 1);


INSERT INTO objet (nom_objet, id_categorie, id_membre) VALUES
('Brosse a cheveux', 1, 2), ('Lime à ongle', 1, 2), ('Marteau', 2, 2), ('Clé à molette', 2, 2),
('Cric', 3, 2), ('Pneu velo', 3, 2), ('Friteuse', 4, 2), ('Cuillère', 4, 2),
('Poêle', 4, 2), ('Perceuse sans fil', 2, 2);

INSERT INTO objet (nom_objet, id_categorie, id_membre) VALUES
('Rouge à lèvres', 1, 3), ('Fard à paupière', 1, 3), ('Scie', 2, 3), ('Cloueuse', 2, 3),
('Pompe manuelle', 3, 3), ('Jauge de pression', 3, 3), ('Mixeur plongeant', 4, 3), ('Spatule', 4, 3),
('Tupperware', 4, 3), ('Coffret maquillage', 1, 3);


INSERT INTO objet (nom_objet, id_categorie, id_membre) VALUES
('Peigne', 1, 4), ('Fer a lisser', 1, 4), ('Visseuse', 2, 4), ('Tournevis étoile', 2, 4),
('Pneu moto', 3, 4), ('Bidon huile moteur', 3, 4), ('Blender', 4, 4), ('Marmite', 4, 4),
('Planche à découper', 4, 4), ('Batteur', 4, 4);

INSERT INTO images_objet (id_objet, nom_image)
SELECT id_objet, CONCAT('objet_', id_objet, '.jpg') FROM objet;


INSERT INTO emprunt (id_objet, id_membre, date_emprunt, date_retour) VALUES
(1, 2, '2025-07-01', '2025-07-05'),
(5, 3, '2025-07-02', '2025-07-07'),
(10, 4, '2025-07-03', '2025-07-06'),
(12, 1, '2025-07-01', '2025-07-08'),
(18, 2, '2025-07-04', '2025-07-09'),
(22, 3, '2025-07-01', '2025-07-06'),
(30, 1, '2025-07-05', '2025-07-10'),
(35, 4, '2025-07-01', '2025-07-03'),
(37, 2, '2025-07-02', '2025-07-04'),
(40, 3, '2025-07-03', '2025-07-05');
