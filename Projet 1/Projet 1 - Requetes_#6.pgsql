-- Projet 1
-- -------------------
-- Henri-Paul Bolduc
-- Edgar Garcia
-- Jacques Duymentz
-- -------------------
-- Requêtes #6
-- Donnez la liste de tous les avatars qui possèdent plus de 1 item : nom du joueur, nom de l’avatar et nombre d’items.
--
-- Fonctionnelle: Oui
-- -------------------

SELECT  alias_joueur		AS "Alias Joueur",
		avatar.nom_avatar	AS "Nom Avatar", 
		COUNT(qte_item) 	AS "Nombre items"
    		FROM  item_avatar, avatar
				WHERE avatar.nom_avatar = item_avatar.nom_avatar
	GROUP BY avatar.nom_avatar
	HAVING COUNT(qte_item)>1;