-- Projet 2
-- =======================================================
-- Requête #8a
--
-- Objectif : 
-- Combien de fois un travailleur a travaillé sur une rue
-- 
--
-- Évaluation :
-- 
-- 
-- Réalisé par : Henri-Paul Bolduc 
-- Aidé par : N/A 
-- ======================================================= 

SELECT	rue.nom_rue 			AS "Rue",
		employe.nom_employe 	AS "Nom",
		employe.prenom_employe 	AS "Prenom",		
		COUNT(troncon.id_rue) 	AS "Nbre de fois"
		
		FROM employe
			INNER JOIN inspection
				ON employe.id_employe = inspection.id_employe_conducteur
				OR employe.id_employe = inspection.id_employe_laser
			INNER JOIN inspection_troncon
				ON inspection.id_inspection = inspection_troncon.id_inspection
			INNER JOIN troncon
				ON inspection_troncon.id_troncon = troncon.id_troncon
			INNER JOIN rue
				ON troncon.id_rue = rue.id_rue
			GROUP BY employe.id_employe, rue.id_rue
			ORDER BY rue.nom_rue;
-- =======================================================
/*
-- -------------------
-- Henri-Paul Bolduc
-- Edgar Garcia
-- Jacques Duymentz
-- -------------------
*/