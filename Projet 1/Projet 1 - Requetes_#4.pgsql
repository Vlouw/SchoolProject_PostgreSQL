-- Projet 1
-- -------------------
-- Henri-Paul Bolduc
-- Edgar Garcia
-- Jacques Duymentz
-- -------------------
-- Requêtes #4
-- Pour l’avatar principal, donnez la valeur totale des tous les items qu’il possède (les habilités considérant le niveau et les items considérant la quantité).
--
-- Fonctionnelle: Oui
-- -------------------

SELECT	avt.nom_avatar 				AS "Nom Avatar",
		SUM(itm.qte_item) + 		
		SUM(habilete.coef1_habilete * (hab.niveau_habilete ^ 2) 
			+ habilete.coef2_habilete * hab.niveau_habilete 
			+ habilete.coef3_habilete	
			)						AS "Valeur total"		
			FROM avatar AS avt
				JOIN habilete_avatar AS hab
					ON avt.nom_avatar = hab.nom_avatar
						JOIN item_avatar AS itm 
							ON avt.nom_avatar = itm.nom_avatar
								JOIN habilete 
									ON hab.sigle_habilete = habilete.sigle_habilete 
									AND avt.nom_avatar = 'Vlouw*'
		GROUP BY avt.nom_avatar;