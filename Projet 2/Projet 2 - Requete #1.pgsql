-- Projet 2
-- =======================================================
-- Requête # 1
--
-- Objectif : 
-- Afficher la liste des employés avec les attributs : nom, prénom, poste, nom du département, ancienneté (en année et mois), leur salaire annuel et leur salaire annuel apres une augmentation
--
-- Évaluation :
-- 
-- 
-- Réalisé par : Edgar Garcia 
-- Aidé par : N/A 
-- ======================================================= 


SELECT 	nom_employe 													AS "Nom"				, 
		prenom_employe 													AS "Prenom"				,	
		INITCAP(nom_poste)												AS "Poste"				,
		INITCAP(nom_departement )										AS "Nom_departement"	,
		date_trunc ('month' , AGE (NOW() ,  date_embauche_employe ) ) 	AS "Ancienete"			,
		ROUND((salaire_horaire_employe * 35 * 52 ),2)					AS "Salaire Annuel"		,
		ROUND((salaire_horaire_employe * 35 * 52 * 1.15),2) 			AS "Salaire Incremente"			
		
		FROM employe 
			INNER JOIN poste
				ON employe.id_poste = poste.id_poste
			INNER JOIN departement
				ON employe.id_departement =departement.id_departement;
							
