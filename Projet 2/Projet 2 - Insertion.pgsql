-- Projet 2
-- ----------------------------
-- Henri-Paul Bolduc
-- Edgar Garcia
-- Jacques Duymentz
-- ----------------------------
-- Création des enregistrements
-- ----------------------------

-- DISABLE TRIGGER ALL
-- ----------------------------
ALTER TABLE poste						DISABLE TRIGGER ALL;
ALTER TABLE departement					DISABLE TRIGGER ALL;
ALTER TABLE employe						DISABLE TRIGGER ALL;

ALTER TABLE marque_laser				DISABLE TRIGGER ALL;
ALTER TABLE laser						DISABLE TRIGGER ALL;
ALTER TABLE calibration_laser			DISABLE TRIGGER ALL;

ALTER TABLE marque_vehicule				DISABLE TRIGGER ALL;
ALTER TABLE vehicule					DISABLE TRIGGER ALL;

ALTER TABLE type_dispositif				DISABLE TRIGGER ALL;
ALTER TABLE type_panneau				DISABLE TRIGGER ALL;

ALTER TABLE rue							DISABLE TRIGGER ALL;
ALTER TABLE inter_section				DISABLE TRIGGER ALL;

-- Enregistrements
-- ----------------------------
-- Employe
INSERT INTO poste		(id_poste,	nom_poste 			)
	VALUES 				(DEFAULT,	'professionnel'		),
						(DEFAULT,	'technicien'		),
						(DEFAULT,	'ingenieur'			),
						(DEFAULT,	'scientifique'		),
						(DEFAULT,	'manutentionnaire'	),
						(DEFAULT,	'soutient'			);
									
INSERT INTO departement	(id_departement,	nom_departement				)
	VALUES				(DEFAULT,			'administration'			),
						(DEFAULT,			'ventes et représentation'	),
						(DEFAULT,			'achats'					),
						(DEFAULT,			'mecanique'					),
						(DEFAULT,			'electrique'				),
						(DEFAULT,			'informatique'				),
						(DEFAULT,			'recherche'					);

INSERT INTO employe		(id_employe,	nas_employe,	nom_employe,	prenom_employe,		genre_employe,		date_embauche_employe,		salaire_horaire_employe,	id_poste,														id_departement 																	)
	VALUES 				(DEFAULT,		'298445667',	'Garcia',		'Edgar',			'f',				'2018-08-08',				28.25,						(SELECT id_poste FROM poste WHERE nom_poste = 'professionnel'),	(SELECT id_departement FROM departement WHERE nom_departement = 'mecanique')	),
						(DEFAULT,		'154566687',	'Bolduc',		'Henri-Paul',		'h',				'2019-01-18',				34.25,						(SELECT id_poste FROM poste WHERE nom_poste = 'technicien'),	(SELECT id_departement FROM departement WHERE nom_departement = 'electrique')	),									
						(DEFAULT,		'624425662',	'Duymentz',		'Jacques',			'x',				'2020-10-08',				36.25,						(SELECT id_poste FROM poste WHERE nom_poste = 'ingenieur'),		(SELECT id_departement FROM departement WHERE nom_departement = 'informatique')	); 							

-- Laser
INSERT INTO marque_laser			(id_marque_laser,	marque_laser	)
	VALUES							(DEFAULT,			'Komatsu'		),
									(DEFAULT,			'Caterpillar'	),
									(DEFAULT,			'DeWalt'		);
									
INSERT INTO laser					(num_serie_laser,			date_acquisition_laser,		date_fabrication_laser,		id_marque_laser																)
	VALUES							('1234567890123456',		'2018-04-10',				'2017-06-18',				(SELECT id_marque_laser FROM marque_laser WHERE marque_laser = 'Komatsu') 	),
									('2345678901234567',		'2019-03-17',				'2018-05-30',				(SELECT id_marque_laser FROM marque_laser WHERE marque_laser = 'DeWalt')	);

INSERT INTO calibration_laser		(id_calibration_laser, 		date_debut_calibration, 	date_fin_calibration, 		v1,				v2,			v3,			num_serie_laser,																			id_employe 														)
	VALUES							('5123456789012345',		'2020-01-08 15:00:00-05',	'2020-01-08 15:35:35-05',	-460.2545,		-560.2545,	-360.2545,	(SELECT num_serie_laser FROM laser WHERE num_serie_laser = '1234567890123456'),				(SELECT id_employe FROM employe WHERE nas_employe = '298445667')),
									('6123456789012345',		'2020-02-08 15:00:00-05',	'2020-02-08 15:47:22-05',	230.7571,		230.7571,	230.7571,	(SELECT num_serie_laser FROM laser WHERE num_serie_laser = '1234567890123456'),				(SELECT id_employe FROM employe WHERE nas_employe = '298445667')),
									('7123456789012345',		'2020-01-08 15:00:00-05',	'2020-01-08 15:27:55-05',	450.6532,		350.6532,	250.6532,	(SELECT num_serie_laser FROM laser WHERE num_serie_laser = '2345678901234567'),				(SELECT id_employe FROM employe WHERE nas_employe = '154566687')),
									('8123456789012345',		'2020-02-08 16:00:00-05',	'2020-02-08 16:55:44-05',	830.6541,		820.6541,	840.6541,	(SELECT num_serie_laser FROM laser WHERE num_serie_laser = '2345678901234567'),				(SELECT id_employe FROM employe WHERE nas_employe = '154566687')),
									('9123456789012345',		'2020-03-08 16:00:00-05',	'2020-03-08 17:10:47-05',	930.2371,		930.2371,	930.2371,	(SELECT num_serie_laser FROM laser WHERE num_serie_laser = '2345678901234567'),				(SELECT id_employe FROM employe WHERE nas_employe = '154566687'));

-- Vehicule
INSERT INTO marque_vehicule 		(id_marque_vehicule, 		marque_vehicule_nom, 			modele_vehicule	)
	VALUES							(DEFAULT,					'Toyota',					'Tacoma'		),
									(DEFAULT,					'Ford',						'F350'			);


INSERT INTO vehicule 				(immatriculation_vehicule,	date_acquisition_vehicule,	id_marque_vehicule																)
	VALUES							('KYA725',					'2018-04-10',				(SELECT id_marque_vehicule FROM marque_vehicule WHERE id_marque_vehicule = 1)	),
									('FFF350',					'2018-05-14',				(SELECT id_marque_vehicule FROM marque_vehicule WHERE id_marque_vehicule = 2)	);

-- Type
INSERT INTO type_dispositif			(id_type_dispositif,		type_dispositif			)
	VALUES							(DEFAULT,					'acces pieton'			),
									(DEFAULT,					'signal audio'			),
									(DEFAULT,					'passage pieton'		),
									(DEFAULT,					'feu circulation velo'	),
									(DEFAULT,					'rampe handicapee'		);
																
INSERT INTO type_panneau 			(id_type_panneau,			type_panneau			)
	VALUES							(DEFAULT,					'arret'					),
									(DEFAULT,					'zone scolaire'			),
									(DEFAULT,					'passage pieton'		),
									(DEFAULT,					'50km/h'				),
									(DEFAULT,					'arret intermitent'		);	

-- Rue, intersection, troncon
INSERT INTO rue 					(id_rue, 					nom_rue					)
	VALUES							(DEFAULT,					'Viau'					),
									(DEFAULT,					'Pie-IX'				),
									(DEFAULT,					'Jeanne-DArc'			),
									(DEFAULT,					'Rosemont'				),
									(DEFAULT,					'Dandurand'				),
									(DEFAULT,					'Masson'				),
									(DEFAULT,					'Laurier'				),
									(DEFAULT,					'St-Joseph'				),
									(DEFAULT,					'Mont-Royal'			),
									(DEFAULT,					'Sherbrooke'			),
									(DEFAULT,					'Pierre-De-Coubertin'	);

INSERT INTO inter_section 			(id_intersection, 			latitude_intersection, 		longitude_intersection, 	type_pavage 	)
	VALUES							(DEFAULT,					'45.569240',				'-73.566275',				'asphalte'	 	),
									(DEFAULT,					'45.565357',				'-73.554448',				'asphalte'	 	),
									(DEFAULT,					'45.562565',				'-73.545885',				'asphalte'	 	),
									(DEFAULT,					'45.560776',				'-73.573860',				'asphalte'	 	),
									(DEFAULT,					'45.559921',				'-73.571195',				'asphalte'	 	),
									(DEFAULT,					'45.559044',				'-73.568461',				'asphalte'	 	),
									(DEFAULT,					'45.558109',				'-73.565600',				'asphalte'	 	),
									(DEFAULT,					'45.557187',				'-73.562757',				'asphalte'	 	),
									(DEFAULT,					'45.555963',				'-73.558900',				'asphalte'	 	),
									(DEFAULT,					'45.554591',				'-73.554561',				'asphalte'	 	),
									(DEFAULT,					'45.553671',				'-73.551716',				'asphalte'	 	),
									(DEFAULT,					'45.560159',				'-73.574365',				'asphalte'	 	),
									(DEFAULT,					'45.559252',				'-73.571619',				'asphalte'	 	),
									(DEFAULT,					'45.558388',				'-73.568900',				'asphalte'	 	),
									(DEFAULT,					'45.557368',				'-73.566170',				'asphalte'	 	),
									(DEFAULT,					'45.556399',				'-73.563235',				'asphalte'	 	),
									(DEFAULT,					'45.555185',				'-73.559391',				'asphalte'	 	),
									(DEFAULT,					'45.553750',				'-73.554666',				'asphalte'	 	),
									(DEFAULT,					'45.552871',				'-73.552161',				'asphalte'	 	);

CALL create_troncon (50, 2, 'asphalte', 'Viau', 		1, 2);
CALL create_troncon (50, 2, 'asphalte', 'Viau', 		2, 3);
CALL create_troncon (50, 3, 'asphalte', 'Pie-IX', 		4, 5);
CALL create_troncon (50, 3, 'asphalte', 'Pie-IX', 		5, 6);
CALL create_troncon (50, 3, 'asphalte', 'Pie-IX', 		6, 7);
CALL create_troncon (50, 3, 'asphalte', 'Pie-IX', 		7, 8);
CALL create_troncon (50, 3, 'asphalte', 'Pie-IX', 		8, 9);
CALL create_troncon (50, 3, 'asphalte', 'Pie-IX', 		9, 10);
CALL create_troncon (50, 3, 'asphalte', 'Pie-IX', 		10, 11);
CALL create_troncon (50, 1, 'asphalte', 'Jeanne-DArc', 	12, 13);
CALL create_troncon (50, 1, 'asphalte', 'Jeanne-DArc', 	13, 14);
CALL create_troncon (50, 1, 'asphalte', 'Jeanne-DArc', 	14, 15);
CALL create_troncon (50, 1, 'asphalte', 'Jeanne-DArc', 	15, 16);
CALL create_troncon (50, 1, 'asphalte', 'Jeanne-DArc', 	16, 17);
CALL create_troncon (50, 1, 'asphalte', 'Jeanne-DArc', 	17, 18);
CALL create_troncon (50, 1, 'asphalte', 'Jeanne-DArc', 	18, 19);

CALL create_troncon (50, 2, 'asphalte', 'Rosemont', 	1, 4);
CALL create_troncon (50, 2, 'asphalte', 'Rosemont', 	4, 12);
CALL create_troncon (50, 1, 'asphalte', 'Dandurand', 	5, 13);
CALL create_troncon (50, 1, 'asphalte', 'Masson', 		6, 14);
CALL create_troncon (50, 2, 'asphalte', 'Laurier', 		7, 15);
CALL create_troncon (50, 2, 'asphalte', 'St-Joseph', 	8, 16);
CALL create_troncon (50, 2, 'asphalte', 'Mont-Royal', 	9, 17);
CALL create_troncon (50, 3, 'asphalte', 'Sherbrooke', 	2, 10);
CALL create_troncon (50, 3, 'asphalte', 'Sherbrooke', 	10, 18);
CALL create_troncon (50, 3, 'asphalte', 'Pierre-De-Coubertin', 	3, 11);
CALL create_troncon (50, 2, 'asphalte', 'Pierre-De-Coubertin', 	11, 19);

-- Inspection
CALL creer_inspection (100);
CALL creer_insp_tron (10);

-- ENABLE TRIGGER ALL
-- ----------------------------
ALTER TABLE poste						ENABLE TRIGGER ALL;
ALTER TABLE departement					ENABLE TRIGGER ALL;
ALTER TABLE employe						ENABLE TRIGGER ALL;

ALTER TABLE marque_laser				ENABLE TRIGGER ALL;
ALTER TABLE laser						ENABLE TRIGGER ALL;
ALTER TABLE calibration_laser			ENABLE TRIGGER ALL;

ALTER TABLE marque_vehicule				ENABLE TRIGGER ALL;
ALTER TABLE vehicule					ENABLE TRIGGER ALL;

ALTER TABLE type_dispositif				ENABLE TRIGGER ALL;
ALTER TABLE type_panneau				ENABLE TRIGGER ALL;

ALTER TABLE rue							ENABLE TRIGGER ALL;
ALTER TABLE inter_section				ENABLE TRIGGER ALL;