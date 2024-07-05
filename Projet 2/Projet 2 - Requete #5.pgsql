-- Projet 2
-- =======================================================
-- Requête # 5
--
-- Objectif : 
-- Pour chaque véhicule, combien de kilomètres de tronçons ont 
-- été parcourus pour réaliser les inspections.
--
-- Évaluation :
-- 
-- 
-- Réalisé par : Henri-Paul Bolduc 
-- Aidé par : N/A 
-- ======================================================= 

SELECT 	vehicule.immatriculation_vehicule
			AS "Immatriculation",
		SUM(troncon.longueur_troncon)
			AS "Kilo Troncon"
			
			FROM vehicule
				INNER join inspection
					ON vehicule.immatriculation_vehicule = inspection.immatriculation_vehicule
				INNER join inspection_troncon
					ON inspection.id_inspection = inspection_troncon.id_inspection
				INNER join troncon
					ON inspection_troncon.id_troncon = troncon.id_troncon
				
			GROUP BY vehicule.immatriculation_vehicule;

-- =======================================================
/*
-- -------------------
-- Henri-Paul Bolduc
-- Edgar Garcia
-- Jacques Duymentz
-- -------------------
*/