-- Projet 2
-- =======================================================
-- Requête #6
--
-- Objectif : 
-- Donner les frais associés pour chacune des inspections.
--
-- Évaluation :
-- Requête ne fonctionne pas totalement, mais plusieurs des sous-requêtes 
-- fonctionnent individuellement.
-- 
-- Réalisé par : Jacques Duymentz
-- Aidé par : Edgar Garcia 
-- ======================================================= 

-- Pour que ces requêtes fonctionnent à chaque inspection, il faudrait les inclure dans une boucle FOR...
-- pour id_inspection allant de 1 à nbre_a_creer
	
-- Coût employé laser 
SELECT	((EXTRACT(EPOCH FROM (date_inspection_fin)) -
		EXTRACT(EPOCH FROM (date_inspection_debut)))/3600 ) * salaire_horaire_employe
	FROM inspection
		INNER JOIN employe
			ON inspection.id_employe_laser = employe.id_employe;
			
-- Coût employé conducteur 		
SELECT	((EXTRACT(EPOCH FROM (date_inspection_fin)) -
		EXTRACT(EPOCH FROM (date_inspection_debut)))/3600 ) * salaire_horaire_employe
	FROM inspection
		INNER JOIN employe
			ON inspection.id_employe_conducteur = employe.id_employe;
	
-- Coût utilisation véhicule 		
SELECT	(kilo_fin_inspection - kilo_debut_inspection) * 4.79
	FROM inspection;

	
-- Coût calibration capteur

SELECT	((EXTRACT(EPOCH FROM (date_fin_calibration)) -
		EXTRACT(EPOCH FROM (date_debut_calibration)))/3600 ) 
-- ici insérer requete imbriquée pour aller chercher le salaire horaire
-- de l'employé qui a calibré le laser et multiplier avec *

--		* 

	FROM inspection
		INNER JOIN calibration_laser
			ON inspection.num_serie_laser = calibration_laser.num_serie_laser;		
		

		
-- requete  pour aller chercher le salaire horaire
-- de l'employé qui a calibré le laser			
			(SELECT salaire_horaire_employe
				FROM calibration_laser
					INNER JOIN employe
						ON calibration_laser.id_employe = employe.id_employe)

-- Ensuite, additionner ces trois parties du coût total... et faire * 1/25...
			
-- =======================================================
/*
-- -------------------
-- Henri-Paul Bolduc
-- Edgar Garcia
-- Jacques Duymentz
-- -------------------
*/		 
					