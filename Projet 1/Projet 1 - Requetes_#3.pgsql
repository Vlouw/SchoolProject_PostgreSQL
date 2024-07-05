-- Projet 1
-- -------------------
-- Henri-Paul Bolduc
-- Edgar Garcia
-- Jacques Duymentz
-- -------------------
-- Requêtes #3
-- Pour l’avatar principal, donnez toutes les habiletés qu’il possède en présentant : le sigle et le nom entre crochets dans la même colonne, 
-- la date d’obtention, le niveau courant, la valeur en moX du niveau courant et le coût en moX pour acheter le prochain niveau.
--
-- Fonctionnelle: Oui
-- -------------------

SELECT  CONCAT(	habilete_avatar.sigle_habilete,
				' [', habilete.nom_habilete,  ']')								AS "Sigle [Nom habilete]",
        habilete_avatar.date_obtention_habilete									AS "Date obtention",
        habilete_avatar.niveau_habilete											AS "Niveau courant",
        habilete.coef1_habilete * (habilete_avatar.niveau_habilete ^ 2) 
			+ habilete.coef2_habilete * habilete_avatar.niveau_habilete 
			+ habilete.coef3_habilete											AS "Valeur niveau courant (moX)",
        habilete.coef1_habilete * ((habilete_avatar.niveau_habilete + 1) ^ 2) 
			+ habilete.coef2_habilete * (habilete_avatar.niveau_habilete + 1) 
			+ habilete.coef3_habilete											AS "Valeur niveau suivant (moX)"
			FROM habilete_avatar
                INNER JOIN habilete
                    ON habilete_avatar.sigle_habilete = habilete.sigle_habilete 
                    AND nom_avatar = 'Vlouw*';