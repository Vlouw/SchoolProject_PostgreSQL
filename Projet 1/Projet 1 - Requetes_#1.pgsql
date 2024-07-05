-- Projet 1
-- -------------------
-- Henri-Paul Bolduc
-- Edgar Garcia
-- Jacques Duymentz
-- -------------------
-- Requêtes #1
-- Donnez la liste de tous les joueurs en présentant : alias, courriel, date d’inscription.
--
-- Fonctionnelle: Oui
-- -------------------

SELECT	alias_joueur				AS "Alias", 
		courriel_joueur				AS "Courriel", 
		date_inscription_joueur		AS "Date Inscription" 
			FROM joueur;