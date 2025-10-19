								-- scénario 1 --
-- Contexte : La base de données est utilisée par le Responsable Commercial pour suivre les ventes dans les agences et concessions partenaires.  
-- Objectif : Analyser les performances commerciales, identifier les véhicules les plus demandés et optimiser la stratégie de vente et la gestion des stocks.


-- 1)Quels sont les 10 clients les plus récents ayant un permis de conduire ?

SELECT *
from clients
where permis='oui'
order by cl_date Desc
limit 10;


-- 2)Quelle est la répartition des ventes par type de contrat (achat, location, leasing) ?

SELECT co_type, round(count(*)/(select count(*) from contrat)*100,1) as répartion_des_ventes
from contrat
group by co_type;


-- 3) Quelle est la marque de voiture la plus vendue au cours des dernières années ?

select  m_marque, count(co_id) as nbr_contrat
from voiture join contrat using(co_id) join travaille using(c_nom) 
group by m_marque
order by nbr_contrat desc
limit 1;


-- 4) Quel le nbre de contrat par agence pour l'année 2021?


select a_nom, a_pays, co_date_debut, co_date_fin, count(co_id) as nbr_contract
from agence join utilise using(a_nom) join voiture using(c_nom) join contrat using(co_id)
group by a_nom, a_pays, co_date_debut, co_date_fin
having year(co_date_debut)=2021 or  year(co_date_fin)=2021 ;


-- 5) Quels sont les nom, prenom et email des clients âgés de 25 à 35 
	    -- ans ayant acheté ou loué un véhicule depuis 2018 ?

SELECT cl_nom, cl_prenom, cl_email, cl_age, cl_date
FROM clients
WHERE cl_age BETWEEN 25 AND 35
  AND cl_date >= '2018-01-01'
ORDER BY cl_date DESC;




-- 6)  Quelles voitures sont encore disponibles (non liées à un contrat actif) et 
		-- dans quelle gamme de prix ?


-- voitures encore disponibles (pas de contrat actif)
SELECT v.v_id, v.v_marque,  v.v_prix
FROM voiture v
LEFT JOIN contrat c using(co_id)
WHERE c.co_id IS NULL;

-- 7) Quelle est la moyenne du prix et du nombre de chevaux par type de véhicule 
		-- (SUV, berline, citadine, etc.) ?


select v_type, avg(v_prix) moyenne_prix, avg(v_cheveaux) as moyenne_chevaux
from voiture
group by v_type;


-- 8) Quels concessionnaires travaillent avec plusieurs maisons automobiles différentes ?


select*
from conces
where c_type = 'vente_multi';


-- 9) Quelle est la ville ou l’agence la plus performante en termes de nombre de contrats signés ?

select a_nom, a_ville, count(co_id) as nbr_contrat_signé
from agence join emploiye using(a_nom) join clients using(e_id) join contrat using(cl_id) 
group by  a_nom, a_ville
;

-- 10) Quelle est la évolution du nombre de contrats par année depuis 2016 ?

select year(cl_date) as annee, round(    (count(co_id))*100/ (  select count(co_id) from contrat join clients using(cl_id) where year(cl_date)=2016) , 2) as evolution
from contrat join clients using(cl_id)
group by annee
having annee between 2017 and 2023
order by annee


		-- scénario 2:   suivi opérationnel et maintenance des véhicules--
--  Superviser l’état et l’utilisation des véhicules, 
-- planifier les interventions de maintenance, suivre les ventes liées à des types de véhicules spécifiques, 
-- identifier les véhicules qui n’ont jamais été loués ou vendus, et analyser les performances techniques par type ou modèle de véhicule.                                                                                     
                                                                                       
                                  
-- 1) Quels véhicules n’ont jamais été associés à un contrat actif ou passé ?
SELECT v.id_vehicule, v.marque, v.modele
FROM vehicule v
LEFT JOIN contrat c ON v.id_vehicule = c.id_vehicule
WHERE c.id_vehicule IS NULL;

-- 2) Top 5 véhicules les plus utilisés par type ? 
SELECT v.type, v.id_vehicule, COUNT(c.id_contrat) AS nb_utilisations
FROM vehicule v
JOIN contrat c ON v.id_vehicule = c.id_vehicule
GROUP BY v.type, v.id_vehicule
ORDER BY nb_utilisations DESC
LIMIT 5;
        
-- 3) Liste les concessions ayant des véhicules stockés depuis plus d’un an sans contrat. 
SELECT DISTINCT con.id_concession, con.nom_concession
FROM concession con
JOIN vehicule v ON con.id_concession = v.id_concession
LEFT JOIN contrat c ON v.id_vehicule = c.id_vehicule
WHERE c.id_contrat IS NULL
  AND v.date_arrivee BETWEEN '2015-01-01' AND '2024-10-19';
        
-- 4) Quels modèles sont présents dans plusieurs concessions ?
SELECT v.modele, COUNT(DISTINCT v.id_concession) AS nb_concessions
FROM vehicule v
GROUP BY v.modele
HAVING COUNT(DISTINCT v.id_concession) > 1;
         
-- 5) Quels clients ont loué au moins un véhicule de chaque modèle SUV ? 
SELECT c.id_client, c.nom
FROM client c
JOIN contrat ct ON c.id_client = ct.id_client
JOIN vehicule v ON ct.id_vehicule = v.id_vehicule
WHERE v.type = 'SUV'
GROUP BY c.id_client, c.nom
HAVING COUNT(DISTINCT v.modele) = (
    SELECT COUNT(DISTINCT v2.modele)
    FROM vehicule v2
    WHERE v2.type = 'SUV'
);

         
-- 6) Affiche chaque véhicule et la date de sa dernière intervention (NULL si jamais entretenu)
 SELECT v.id_vehicule, v.marque, v.modele, MAX(i.date_intervention) AS derniere_intervention
FROM vehicule v
LEFT JOIN intervention i ON v.id_vehicule = i.id_vehicule
GROUP BY v.id_vehicule, v.marque, v.modele;
     
     
-- 7) Quels véhicules ont un prix supérieur à tous les véhicules de type citadine ? 
SELECT v.id_vehicule, v.modele, v.prix_location
FROM vehicule v
WHERE v.prix_location > ALL (
    SELECT v2.prix_location
    FROM vehicule v2
    WHERE v2.type = 'citadine'
);

-- 8) Quelles agences n’ont aucun véhicule ayant été entretenu depuis 2023 ? 
SELECT a.id_agence, a.nom_agence
FROM agence a
WHERE NOT EXISTS (
    SELECT 1
    FROM vehicule v
    JOIN intervention i ON v.id_vehicule = i.id_vehicule
    WHERE v.id_agence = a.id_agence
      AND i.date_intervention >= '2023-01-01'
);
           

-- 9) Véhicules moins chers que certains SUV 
SELECT v.id_vehicule, v.modele, v.prix_location
FROM vehicule v
WHERE v.prix_location < ANY (
    SELECT v2.prix_location
    FROM vehicule v2
    WHERE v2.type = 'SUV'
);

-- 10) Identifier les clients qui n’ont pas eu de contrat actif depuis plus d’un an.
SELECT c.id_client, c.nom
FROM client c
WHERE NOT EXISTS (
    SELECT 1
    FROM contrat ct
    WHERE ct.id_client = c.id_client
      AND ct.date_debut >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
);

           
           
        
        
	
                                                                                       
                                                                                       