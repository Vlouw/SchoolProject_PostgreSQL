-- Projet 2
-- =======================================================
-- Requête # 3
--
-- Objectif : 
-- Donner le nombre d’inspections que chaque employé a fait.
--
-- Évaluation :
-- 
-- 
-- Réalisé par : Jacques Duymentz
-- Aidé par : Edgar Garcia 
-- ======================================================= 

SELECT	employe.id_employe 				AS "ID Employe", 
		employe.prenom_employe 			AS "Prenom Employe", 
		employe.nom_employe 			AS "Nom Employe", 
		count(inspection.id_inspection) AS "Nombre inspections effectues par cet employé"
			FROM employe 
				INNER JOIN inspection
		 			ON employe.id_employe = inspection.id_employe_laser
					OR employe.id_employe = inspection.id_employe_conducteur
		 	GROUP BY employe.id_employe;			 
-- =======================================================
/*
-- -------------------
-- Henri-Paul Bolduc
-- Edgar Garcia
-- Jacques Duymentz
-- -------------------
*/		 
					