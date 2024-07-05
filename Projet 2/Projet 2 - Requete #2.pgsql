-- Projet 2
-- =======================================================
-- Requête # 2
--
-- Objectif : 
-- Donner le nombre de calibrations que chaque employé a fait.
--
-- Évaluation :
-- 
-- 
-- Réalisé par : Henri-Paul Bolduc 
-- Aidé par : N/A 
-- ======================================================= 

SELECT 	employe.id_employe					AS "ID"						,
		employe.nom_employe 				AS "Nom"					, 
		employe.prenom_employe 				AS "Prenom"					,		
		COUNT(calibration_laser.id_employe)	AS "Nbre de calibration"
		
		FROM employe, calibration_laser	
			WHERE employe.id_employe = calibration_laser.id_employe		
		GROUP BY employe.id_employe
		ORDER BY employe.nom_employe;
-- =======================================================
/*
-- -------------------
-- Henri-Paul Bolduc
-- Edgar Garcia
-- Jacques Duymentz
-- -------------------
*/