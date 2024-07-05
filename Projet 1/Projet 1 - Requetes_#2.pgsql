-- Projet 1
-- -------------------
-- Henri-Paul Bolduc
-- Edgar Garcia
-- Jacques Duymentz
-- -------------------
-- Requêtes #2
-- Donnez la liste des avatars d’un joueur quelconque (pour l’exemple, prendre le joueur principal), 
-- en donnant : nom, la couleur préférée transformée en trois composantes rouge-vert-bleu, 
-- date de création suivant le format 2000 | 12 | 25, le nombre de moX.
--
-- Fonctionnelle: Oui
-- -------------------

SELECT	nom_avatar 																	AS "Nom Avatar",
		TO_NUMBER(SUBSTRING(TO_CHAR(couleur_1_avatar, '000000000'), 2, 3), '999')	AS "Couleur Pref - Rouge",
		TO_NUMBER(SUBSTRING(TO_CHAR(couleur_1_avatar, '000000000'), 5, 3), '999')	AS "Couleur Pref - Vert",
		TO_NUMBER(SUBSTRING(TO_CHAR(couleur_1_avatar, '000000000'), 8, 3), '999')	AS "Couleur Pref - Bleu",
		TO_CHAR(date_creation_avatar, 'YYYY | MM | DD')								AS "Date de création",
		qte_mox_avatar																AS "Quantité Mox"
		
		FROM avatar
			WHERE alias_joueur = 'Henri-Paul*';