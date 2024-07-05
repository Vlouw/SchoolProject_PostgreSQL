-- Projet 2
-- =======================================================
-- Requête # 7
--
-- Objectif : 
-- On veut la liste des profileurs laser ayant besoin d’être calibrés. 
-- La formule suivante permet de valider cette information. 
-- Si cet énoncé est vrai, une calibration est requise : √|𝑣1𝑣2𝑣32−1|≤1𝜋2
--
-- Évaluation :
-- 
-- 
-- Réalisé par : Henri-Paul Bolduc 
-- Aidé par : N/A 
-- ======================================================= 

SELECT 	num_serie_laser AS "Numero Serie",
		cal_requise(num_serie_laser) AS "Besoin Calibration"		
			FROM laser		
		ORDER BY num_serie_laser;

-- =======================================================
/*
-- -------------------
-- Henri-Paul Bolduc
-- Edgar Garcia
-- Jacques Duymentz
-- -------------------
*/