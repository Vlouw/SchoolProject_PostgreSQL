-- Projet 1
-- ----------------------------
-- Henri-Paul Bolduc
-- Edgar Garcia
-- Jacques Duymentz
-- ----------------------------
-- Création des enregistrements
-- ----------------------------

-- DISABLE TRIGGER ALL
ALTER TABLE jeu					DISABLE TRIGGER ALL;
ALTER TABLE joueur				DISABLE TRIGGER ALL;
ALTER TABLE avatar				DISABLE TRIGGER ALL;
ALTER TABLE habilete			DISABLE TRIGGER ALL;
ALTER TABLE item				DISABLE TRIGGER ALL;
ALTER TABLE phrase_avatar		DISABLE TRIGGER ALL;
ALTER TABLE habilete_avatar		DISABLE TRIGGER ALL;
ALTER TABLE item_avatar			DISABLE TRIGGER ALL;
ALTER TABLE activite			DISABLE TRIGGER ALL;
ALTER TABLE capsule_activite	DISABLE TRIGGER ALL;

-- Enregistrements
INSERT INTO jeu					(sigle_jeu,			nom_jeu, 				desc_jeu)
	VALUES 						('SPACEX', 			'SpaceX', 				'Espace'),
								('DEHORX', 			'DeepHorizonX',			'Horizon');

INSERT INTO joueur				(alias_joueur,		courriel_joueur,		mdp_joueur,				genre_joueur,		date_inscription_joueur,	date_naissance_joueur	)
	VALUES 						('Henri-Paul*',		'hp@jeu.com', 			'hpb',					'f',				'2020-01-05',				'1985-01-01'			),
								('Edgar',			'ed@jeu.com', 			'edg',					'h',				'2020-05-05',				'1990-05-08'			),
								('Jacques',			'ja@jeu.com', 			'jac',					'x',				'2021-01-10',				'1987-12-06'			);

INSERT INTO avatar				(nom_avatar,		couleur_1_avatar,		couleur_2_avatar,		couleur_3_avatar,	date_creation_avatar,		qte_mox_avatar,			alias_joueur															)
	VALUES						('Vlouw*',			'160046617',			DEFAULT,				DEFAULT,			'2020-01-08',				'10000',				(SELECT alias_joueur FROM joueur WHERE alias_joueur = 'Henri-Paul*')	),
								('Hama',			'255200244',			DEFAULT,				DEFAULT,			'2021-01-02',				'56423',				(SELECT alias_joueur FROM joueur WHERE alias_joueur = 'Henri-Paul*')	),
								('BigE',			'244218025',			DEFAULT,				DEFAULT,			'2020-05-07',				'78945',				(SELECT alias_joueur FROM joueur WHERE alias_joueur = 'Edgar')			),
								('Jack',			'000255255',			DEFAULT,				DEFAULT,			'2021-01-12',				'997456',				(SELECT alias_joueur FROM joueur WHERE alias_joueur = 'Jacques')		);

INSERT INTO habilete			(sigle_habilete,	nom_habilete,			ener_max_habilete,		coef1_habilete,		coef2_habilete,				coef3_habilete,			desc_habilete,					sigle_jeu												)
	VALUES						('SRA',				'RalentirTemps',		'100.255',				'2.2',				'2.2',						'2.2',					'Ralenti le temps',				(SELECT sigle_jeu FROM jeu WHERE sigle_jeu = 'SPACEX')	),
								('SBP',				'BouclierProximite',	'905.545',				'1.2',				'4.1',						'6.1',					'Protege le joueur',			(SELECT sigle_jeu FROM jeu WHERE sigle_jeu = 'SPACEX')	),
								('SAG',				'AutoGuerison',			'500.455',				'4.6',				'2.1',						'0.5',					'Auto guerison au x sec',		(SELECT sigle_jeu FROM jeu WHERE sigle_jeu = 'DEHORX')	),
								('SZO',				'ZoomOculaire',			'250.000',				'1.5',				'3.5',						'1.4',					'Voir de plus proche',			(SELECT sigle_jeu FROM jeu WHERE sigle_jeu = 'DEHORX')	);

INSERT INTO item				(sigle_item,		nom_item,				prob_item,				desc_item,										sigle_jeu												)
	VALUES						('IMOR',			'Montre du roi',		0.22,					'Bonus manipulation du temps',					(SELECT sigle_jeu FROM jeu WHERE sigle_jeu = 'SPACEX')	),
								('IBOG',			'Bouclier Geant',		DEFAULT,				'Bouclier rare',								(SELECT sigle_jeu FROM jeu WHERE sigle_jeu = 'SPACEX')	),
								('IMEP',			'MedPac',				0.33,					'100 points de vie',							(SELECT sigle_jeu FROM jeu WHERE sigle_jeu = 'DEHORX')	),
								('ISNS',			'Sniper Scope',			0.18,					'Zoom oculaire x2',								(SELECT sigle_jeu FROM jeu WHERE sigle_jeu = 'DEHORX')	);

INSERT INTO phrase_avatar		(id_phrase, 		phrase, 				nom_avatar	)
	VALUES						(DEFAULT,			'Hello World!',			(SELECT nom_avatar FROM avatar WHERE nom_avatar = 'Vlouw*')	),
								(DEFAULT,			'Goodbye World!',		(SELECT nom_avatar FROM avatar WHERE nom_avatar = 'Hama')	),
								(DEFAULT,			'I am hungry!',			(SELECT nom_avatar FROM avatar WHERE nom_avatar = 'BigE')	),
								(DEFAULT,			'Give me tha money!',	(SELECT nom_avatar FROM avatar WHERE nom_avatar = 'Jack')	);

INSERT INTO habilete_avatar		(nom_avatar, 													sigle_habilete,															niveau_habilete,	date_obtention_habilete		)
	VALUES						((SELECT nom_avatar FROM avatar WHERE nom_avatar = 'Vlouw*'),	(SELECT sigle_habilete FROM habilete WHERE sigle_habilete = 'SRA'),		'4',				'2020-01-08 17:32:41-05'	),
								((SELECT nom_avatar FROM avatar WHERE nom_avatar = 'Vlouw*'),	(SELECT sigle_habilete FROM habilete WHERE sigle_habilete = 'SBP'),		'4',				'2020-03-12 19:48:47-05'	),
								((SELECT nom_avatar FROM avatar WHERE nom_avatar = 'Hama'),		(SELECT sigle_habilete FROM habilete WHERE sigle_habilete = 'SBP'),		'3',				'2021-01-02 16:54:22-05'	),
								((SELECT nom_avatar FROM avatar WHERE nom_avatar = 'BigE'),		(SELECT sigle_habilete FROM habilete WHERE sigle_habilete = 'SAG'),		'6',				'2020-05-07 20:11:10-05'	),
								((SELECT nom_avatar FROM avatar WHERE nom_avatar = 'Jack'),		(SELECT sigle_habilete FROM habilete WHERE sigle_habilete = 'SZO'),		'2',				'2021-01-12 21:13:55-05'	);

INSERT INTO item_avatar			(nom_avatar,													sigle_item,																qte_item,			date_obtention_item			)
	VALUES						((SELECT nom_avatar FROM avatar WHERE nom_avatar = 'Vlouw*'),	(SELECT sigle_item FROM item WHERE sigle_item = 'IMOR'),				'4',				'2020-01-08 16:28:47-05'	),
								((SELECT nom_avatar FROM avatar WHERE nom_avatar = 'Vlouw*'),	(SELECT sigle_item FROM item WHERE sigle_item = 'IBOG'),				'2',				'2020-03-12 18:48:47-05'	),
								((SELECT nom_avatar FROM avatar WHERE nom_avatar = 'Hama'),		(SELECT sigle_item FROM item WHERE sigle_item = 'IBOG'),				'6',				'2021-01-02 14:42:12-05'	),
								((SELECT nom_avatar FROM avatar WHERE nom_avatar = 'BigE'),		(SELECT sigle_item FROM item WHERE sigle_item = 'IMEP'),				'1',				'2020-05-07 17:15:10-05'	),
								((SELECT nom_avatar FROM avatar WHERE nom_avatar = 'BigE'),		(SELECT sigle_item FROM item WHERE sigle_item = 'ISNS'),				'3',				'2020-05-07 18:31:04-05'	),
								((SELECT nom_avatar FROM avatar WHERE nom_avatar = 'Jack'),		(SELECT sigle_item FROM item WHERE sigle_item = 'ISNS'),				'7',				'2021-01-12 20:10:55-05'	);

INSERT INTO activite			(id_activite,			date_debut_activite,					duree_activite,			alias_joueur															)
	VALUES						(DEFAULT, 				'2020-01-08 15:22:47-05',				'14400',				(SELECT alias_joueur FROM joueur WHERE alias_joueur = 'Henri-Paul*')	),
								(DEFAULT, 				'2020-03-12 18:45:54-05',				'7200',					(SELECT alias_joueur FROM joueur WHERE alias_joueur = 'Henri-Paul*')	),
								(DEFAULT, 				'2021-01-02 13:13:22-05',				'14400',				(SELECT alias_joueur FROM joueur WHERE alias_joueur = 'Henri-Paul*')	),
								(DEFAULT, 				'2020-05-07 16:55:35-05',				'18000',				(SELECT alias_joueur FROM joueur WHERE alias_joueur = 'Edgar')			),
								(DEFAULT, 				'2021-01-12 20:35:05-05',				'9000',					(SELECT alias_joueur FROM joueur WHERE alias_joueur = 'Jacques')		);
							
INSERT INTO capsule_activite 	(id_capsule,			duree_capsule,		id_activite,													sigle_jeu,													nom_avatar													)
	VALUES						(DEFAULT,				'8000',				(SELECT id_activite FROM activite WHERE id_activite = '1'),		(SELECT sigle_jeu FROM jeu WHERE sigle_jeu = 'SPACEX'),		(SELECT nom_avatar FROM avatar WHERE nom_avatar = 'Vlouw*')	),
								(DEFAULT,				'2000',				(SELECT id_activite FROM activite WHERE id_activite = '1'),		(SELECT sigle_jeu FROM jeu WHERE sigle_jeu = 'DEHORX'),		(SELECT nom_avatar FROM avatar WHERE nom_avatar = 'Vlouw*')	),
								(DEFAULT,				'4400',				(SELECT id_activite FROM activite WHERE id_activite = '1'),		(SELECT sigle_jeu FROM jeu WHERE sigle_jeu = 'SPACEX'),		(SELECT nom_avatar FROM avatar WHERE nom_avatar = 'Vlouw*')	),
								(DEFAULT,				'4000',				(SELECT id_activite FROM activite WHERE id_activite = '2'),		(SELECT sigle_jeu FROM jeu WHERE sigle_jeu = 'SPACEX'),		(SELECT nom_avatar FROM avatar WHERE nom_avatar = 'Vlouw*')	),
								(DEFAULT,				'1000',				(SELECT id_activite FROM activite WHERE id_activite = '2'),		(SELECT sigle_jeu FROM jeu WHERE sigle_jeu = 'DEHORX'),		(SELECT nom_avatar FROM avatar WHERE nom_avatar = 'Vlouw*')	),
								(DEFAULT,				'2200',				(SELECT id_activite FROM activite WHERE id_activite = '2'),		(SELECT sigle_jeu FROM jeu WHERE sigle_jeu = 'SPACEX'),		(SELECT nom_avatar FROM avatar WHERE nom_avatar = 'Vlouw*')	),
								(DEFAULT,				'11400',			(SELECT id_activite FROM activite WHERE id_activite = '3'),		(SELECT sigle_jeu FROM jeu WHERE sigle_jeu = 'SPACEX'),		(SELECT nom_avatar FROM avatar WHERE nom_avatar = 'Hama')	),
								(DEFAULT,				'3000',				(SELECT id_activite FROM activite WHERE id_activite = '3'),		(SELECT sigle_jeu FROM jeu WHERE sigle_jeu = 'DEHORX'),		(SELECT nom_avatar FROM avatar WHERE nom_avatar = 'Hama')	),
								(DEFAULT,				'16000',			(SELECT id_activite FROM activite WHERE id_activite = '4'),		(SELECT sigle_jeu FROM jeu WHERE sigle_jeu = 'DEHORX'),		(SELECT nom_avatar FROM avatar WHERE nom_avatar = 'BigE')	),
								(DEFAULT,				'2000',				(SELECT id_activite FROM activite WHERE id_activite = '4'),		(SELECT sigle_jeu FROM jeu WHERE sigle_jeu = 'SPACEX'),		(SELECT nom_avatar FROM avatar WHERE nom_avatar = 'BigE')	),
								(DEFAULT,				'7500',				(SELECT id_activite FROM activite WHERE id_activite = '5'),		(SELECT sigle_jeu FROM jeu WHERE sigle_jeu = 'DEHORX'),		(SELECT nom_avatar FROM avatar WHERE nom_avatar = 'Jack')	),
								(DEFAULT,				'1500',				(SELECT id_activite FROM activite WHERE id_activite = '5'),		(SELECT sigle_jeu FROM jeu WHERE sigle_jeu = 'SPACEX'),		(SELECT nom_avatar FROM avatar WHERE nom_avatar = 'Jack')	);

-- ENABLE TRIGGER ALL
ALTER TABLE jeu					ENABLE TRIGGER ALL;
ALTER TABLE joueur				ENABLE TRIGGER ALL;
ALTER TABLE avatar				ENABLE TRIGGER ALL;
ALTER TABLE habilete			ENABLE TRIGGER ALL;
ALTER TABLE item				ENABLE TRIGGER ALL;
ALTER TABLE phrase_avatar		ENABLE TRIGGER ALL;
ALTER TABLE habilete_avatar		ENABLE TRIGGER ALL;
ALTER TABLE item_avatar			ENABLE TRIGGER ALL;
ALTER TABLE activite			ENABLE TRIGGER ALL;
ALTER TABLE capsule_activite	ENABLE TRIGGER ALL;