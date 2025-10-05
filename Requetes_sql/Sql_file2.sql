-- 1. agences
INSERT INTO agence (a_nom, a_pays, a_ville) VALUES
('AgenceParis', 'France', 'Paris'),
('AgenceLyon',  'France', 'Lyon'),
('AgenceMarseille', 'France', 'Marseille');


INSERT INTO conces (c_nom, c_pays, c_type, c_ville) VALUES
('ConcesA', 'France', 'Vendeur', 'Paris'),
('ConcesB', 'France', 'Concession', 'Lyon'),
('ConcesC', 'France', 'Revendeur', 'Marseille');


INSERT INTO maison (m_marque, m_date) VALUES
('Renault', '2020-01-01'),
('Peugeot', '2019-06-15'),
('Citroen', '2018-03-20');

-- 4. adresses
INSERT INTO adresse (ad_adresse, ad_num_rue, ad_nom_rue, ad_codepostal) VALUES
('addr1', 12, 'Rue de Rivoli', 75001),
('addr2', 34, 'Rue Victor Hugo', 69002),
('addr3', 8,  'Boulevard Longchamp', 13001),
('addr4', 101,'Avenue de la Republique', 75011),
('addr5', 5,  'Rue Gambetta', 69003),
('addr6', 47, 'Cours Julien', 13001),
('addr7', 2,  'Rue de la Paix', 75002),
('addr8', 88, 'Rue du President', 13006),
('addr9', 66, 'Place Bellecour', 69002),
('addr10', 3, 'Rue Saint-Dominique', 75007);

-- 5. employes (e_id is AUTO_INCREMENT)
INSERT INTO emploiye (e_nom, e_prenom, e_mail, e_age, ad_adresse, a_nom) VALUES
('Dupont', 'Jean',   'jean.dupont@example.com', 34, 'addr1', 'AgenceParis'),
('Martin', 'Sophie', 'sophie.martin@example.com', 29, 'addr2', 'AgenceLyon'),
('Bernard','Luc',    'luc.bernard@example.com', 41, 'addr3', 'AgenceMarseille'),
('Petit',  'Claire', 'claire.petit@example.com', 30, 'addr4', 'AgenceParis'),
('Morel',  'Antoine','antoine.morel@example.com', 38, 'addr5', 'AgenceLyon'),
('Roux',   'Lea',    'lea.roux@example.com', 27, 'addr6', 'AgenceMarseille');

-- 6. clients (cl_id is AUTO_INCREMENT)
INSERT INTO clients (cl_nom, cl_prenom, cl_date, cl_age, cl_email, ad_adresse, e_id) VALUES
('Durand', 'Alice', '2023-03-12', 28, 'alice.durand@example.com', 'addr1', 1),
('Moreau', 'Paul',  '2022-11-20', 40, 'paul.moreau@example.com', 'addr2', 2),
('Leroy',  'Marie', '2024-01-15', 33, 'marie.leroy@example.com', 'addr3', 3),
('Faure',  'Nicolas','2023-05-30', 45, 'nicolas.faure@example.com', 'addr4', 1),
('Gautier','Emma',  '2022-09-08', 25, 'emma.gautier@example.com', 'addr5', 2),
('Blanc',  'Hugo',  '2024-02-10', 31, 'hugo.blanc@example.com', 'addr6', 4),
('Perrin', 'Camille','2023-07-21', 36, 'camille.perrin@example.com', 'addr7', 5),
('Robin',  'Thomas','2024-03-01', 29, 'thomas.robin@example.com', 'addr8', 6),
('Giraud', 'Laura', '2023-08-12', 27, 'laura.giraud@example.com', 'addr9', 3),
('Dupuis', 'Marc',  '2022-12-05', 50, 'marc.dupuis@example.com', 'addr10', 2);

-- 7. contrats (co_id is VARCHAR PK). cl_id assumes the insertion order above (1..10)
INSERT INTO contrat (co_id, co_type, co_date_debut, co_date_fin, co_statut_paiement, co_etat_depart, co_etat_fin, cl_id) VALUES
('C-001', 'Location', '2024-01-01', '2024-01-07', 'Paid',    'Bon', 'Bon', 1),
('C-002', 'Achat',    '2024-02-10', '2024-02-10', 'Pending', 'Bon', 'Bon', 2),
('C-003', 'Location', '2024-03-05', '2024-03-12', 'Paid',    'Bon', 'Bon', 3),
('C-004', 'Achat',    '2024-04-01', '2024-04-01', 'Paid',    'Bon', 'Bon', 4),
('C-005', 'Location', '2023-12-20', '2023-12-27', 'Paid',    'Bon', 'Bon', 5),
('C-006', 'Achat',    '2024-02-20', '2024-02-20', 'Pending', 'Bon', 'Bon', 6),
('C-007', 'Location', '2024-03-15', '2024-03-22', 'Paid',    'Bon', 'Bon', 7),
('C-008', 'Location', '2024-04-10', '2024-04-17', 'Paid',    'Bon', 'Bon', 8);

-- 8. voitures (reference contrat.co_id and conces.c_nom)
INSERT INTO voiture (v_id, v_etat, v_couleur, v_prix, v_marque, v_chevaux, v_type, v_autonomie, co_id, c_nom) VALUES
('V-100', 'Neuf',     'Rouge', 25000, 'Renault', 120, 'Citadine', 520.50, 'C-001', 'ConcesA'),
('V-101', 'Occasion', 'Bleu',  15000, 'Peugeot', 110, 'Berline',  480.00, 'C-002', 'ConcesB'),
('V-102', 'Neuf',     'Noir',  32000, 'Renault', 150, 'SUV',     600.00, 'C-003', 'ConcesA'),
('V-103', 'Occasion', 'Blanc', 12000, 'Citroen', 95,  'Citadine',420.00, 'C-004', 'ConcesC'),
('V-104', 'Neuf',     'Gris',  28000, 'Peugeot', 130, 'Berline', 530.00, 'C-005', 'ConcesB'),
('V-105', 'Occasion', 'Rouge', 9000,  'Renault', 85,  'Compact', 380.00, 'C-006', 'ConcesC'),
('V-106', 'Neuf',     'Bleu',  27000, 'Peugeot', 125, 'SUV',     550.00, 'C-007', 'ConcesA'),
('V-107', 'Occasion', 'Vert',  8000,  'Citroen', 80,  'Citadine',360.00, 'C-008', 'ConcesB');





