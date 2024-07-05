-- Projet 1
-- -------------------
-- Henri-Paul Bolduc
-- Edgar Garcia
-- Jacques Duymentz
-- -------------------
-- Requêtes #5
-- Pour le joueur principal, donnez le nombre total d’heures passées dans chaque jeu joué.
--
-- Fonctionnelle: Oui
-- -------------------

SELECT	sigle_jeu							AS "Jeu",
		SUM(duree_capsule) /3600::float		AS "Temps total (hrs)"		
		FROM capsule_activite
			WHERE nom_avatar = ANY(	SELECT nom_avatar 
										FROM avatar 
											WHERE alias_joueur = 'Henri-Paul*')
		GROUP BY sigle_jeu;