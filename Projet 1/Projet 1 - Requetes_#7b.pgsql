-- Projet 1
-- -------------------
-- Henri-Paul Bolduc
-- Edgar Garcia
-- Jacques Duymentz
-- -------------------
-- Requêtes #7b
-- Retourner pour chaque capsule d'activités, en ordre de nom d'avatar : 	
-- nom de l'avatar, nom du joueur, id de la capsule, durée de la capsule et nom du jeu.
--
-- Fonctionnelle: Oui
-- -------------------

SELECT  avatar.nom_avatar 			AS "Nom avatar", 
		joueur.alias_joueur 		AS "Nom joueur",   
		id_capsule 					AS "Capsule identifiant", 
		duree_capsule				AS "Capsule durée",
		nom_jeu 					AS "Nom jeu"
	FROM avatar 
		INNER JOIN joueur
			ON  avatar.alias_joueur = joueur.alias_joueur
		INNER JOIN capsule_activite
			ON avatar.nom_avatar = capsule_activite.nom_avatar
		INNER JOIN jeu
			ON capsule_activite.sigle_jeu = jeu.sigle_jeu
	ORDER BY avatar.nom_avatar;