-- Projet 1
-- -------------------
-- Henri-Paul Bolduc
-- Edgar Garcia
-- Jacques Duymentz
-- -------------------
-- Requêtes #7a
-- Trouver tous les avatars (sauf le principal) qui ont seulement une habileté
--
-- Fonctionnelle: Oui
-- -------------------
	
SELECT 		
	hab_av.nom_avatar				AS "Nom avatar",
	hab.nom_habilete  				AS "Habilete"
		FROM habilete_avatar AS hab_av
			JOIN habilete AS hab
				ON hab_av.sigle_habilete = hab.sigle_habilete
					JOIN avatar AS avt
						ON hab_av.nom_avatar =  avt.nom_avatar
							WHERE hab_av.nom_avatar NOT LIKE '%*'
		GROUP BY	avt.nom_avatar,
					hab_av.nom_avatar,
					hab.nom_habilete
		HAVING COUNT(hab_av.nom_avatar)<=1;