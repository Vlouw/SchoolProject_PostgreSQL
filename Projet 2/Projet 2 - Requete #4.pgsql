-- Projet 2
-- =======================================================
-- Requête # 4
--
-- Objectif : 
-- Pour chaque véhicule, combien de kilomètres ont été parcourus pour réaliser les inspections.
--
-- Évaluation :
-- 
-- 
-- Réalisé par : Henri-Paul Bolduc 
-- Aidé par : Edgar Garcia 
-- ======================================================= 

SELECT 	vehicule.immatriculation_vehicule
			AS "Immatriculation",
		MAX(inspection.kilo_fin_inspection) - MIN(inspection.kilo_debut_inspection)	
			AS "Kilo Parcourus"
			
			FROM vehicule
				INNER join inspection
					ON vehicule.immatriculation_vehicule = inspection.immatriculation_vehicule
					
			GROUP BY vehicule.immatriculation_vehicule;
			
-- =======================================================
/*
-- -------------------
-- Henri-Paul Bolduc
-- Edgar Garcia
-- Jacques Duymentz
-- -------------------
*/
