



-- Affiche la listes employés sans client  (aucun client géré).

select *
from emploiye  
where e_id not in (select e_id from clients) ;


-- afficher les emploiyés ayant un contrat 
select cl_nom AS Nom, cl_prenom AS Prenom, cl_age AS age
From contrat join clients using(cl_id);

-- afficher les emploiyés ayant un contrat agés de plus de 34 ans 
select cl_nom AS Nom, cl_prenom AS Prenom, cl_age AS age
From contrat join clients using(cl_id)
where cl_age>=34;   

-- Donne les 5 voitures les plus chères
SELECT *
from voiture
order by v_prix DESC
limit 5;





