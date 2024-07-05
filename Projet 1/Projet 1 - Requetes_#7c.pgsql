-- Projet 1
-- -------------------
-- Henri-Paul Bolduc
-- Edgar Garcia
-- Jacques Duymentz
-- -------------------
-- Requêtes #7c
-- Retourner les informations du joueur ayant obtenu le premier l'item le plus rare ainsi que le jeu d'où l'item provient.
--
-- Fonctionnelle: Oui
-- -------------------

SELECT
		jeu.nom_jeu						AS "Jeu",
		item.nom_item 					AS "Item", 
		item.prob_item					AS "Probabilité", 
		item_avatar.date_obtention_item AS "Date Obtenu",
		joueur.alias_joueur				AS "Nom du joueur", 
		joueur.courriel_joueur			AS "Courriel", 
		joueur.genre_joueur				AS "Genre"
	FROM joueur
		INNER JOIN avatar
			ON joueur.alias_joueur = avatar.alias_joueur
				INNER JOIN item_avatar
					ON avatar.nom_avatar = item_avatar.nom_avatar
						INNER JOIN item
							ON item_avatar.sigle_item = item.sigle_item
								INNER JOIN jeu
									ON item.sigle_jeu = jeu.sigle_jeu
							
	ORDER BY item.prob_item, item_avatar.date_obtention_item
	LIMIT 1;