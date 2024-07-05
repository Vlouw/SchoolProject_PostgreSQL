-- Projet 2
-- ----------------------------
-- Henri-Paul Bolduc
-- Edgar Garcia
-- Jacques Duymentz
-- ----------------------------
-- Création des outils PL/pgSQL
-- ----------------------------

-- Procedure #1
-- Inserer 2x le troncon et calculer la longueur
-- ----------------------------
CREATE OR REPLACE PROCEDURE create_troncon (
	lim_vit_tron	NUMERIC(3,0),
	v_tron			NUMERIC(1,0),
	t_pava			pavage,
	n_rue			VARCHAR(32),
	id_inter_1		NUMERIC(7,0),
	id_inter_2		NUMERIC(7,0))
	
LANGUAGE PLPGSQL
AS $$
DECLARE
	lon_tron	NUMERIC(7,1);
	lat1_p		NUMERIC(9,6);
	lon1_p		NUMERIC(9,6);
	lat2_p		NUMERIC(9,6);
	lon2_p		NUMERIC(9,6);

BEGIN
	SELECT latitude_intersection  INTO lat1_p FROM inter_section WHERE id_intersection = id_inter_1;
	SELECT longitude_intersection INTO lon1_p FROM inter_section WHERE id_intersection = id_inter_1;
	SELECT latitude_intersection  INTO lat2_p FROM inter_section WHERE id_intersection = id_inter_2;
	SELECT longitude_intersection INTO lon2_p FROM inter_section WHERE id_intersection = id_inter_2;
	
	lon_tron := long_tronc(lat1_p,lon1_p,lat2_p,lon2_p);
	
	INSERT INTO troncon 	(id_troncon, 	longueur_troncon, 	limite_vitesse_troncon, voie_troncon, 	type_pavage, 	id_rue, 										id_intersection_debut, 															id_intersection_fin																)	
		VALUES				(DEFAULT,		lon_tron,			lim_vit_tron,			v_tron,			t_pava,			(SELECT id_rue FROM rue WHERE nom_rue = n_rue),	(SELECT id_intersection FROM inter_section WHERE id_intersection = id_inter_1),	(SELECT id_intersection FROM inter_section WHERE id_intersection = id_inter_2)	),
							(DEFAULT,		lon_tron,			lim_vit_tron,			v_tron,			t_pava,			(SELECT id_rue FROM rue WHERE nom_rue = n_rue),	(SELECT id_intersection FROM inter_section WHERE id_intersection = id_inter_2),	(SELECT id_intersection FROM inter_section WHERE id_intersection = id_inter_1)	);

END $$;

-- Procedure #2
-- Créer X inspections
-- ----------------------------
CREATE OR REPLACE PROCEDURE creer_inspection (nbre_a_creer INT DEFAULT 1)
	
LANGUAGE PLPGSQL
AS $$
DECLARE
	compteur 		INT;
	rand_1 			INT;
	rand_2 			INT;
	rand_veh		INT;
	nbre_employe 	INT;
	kilo_veh 		INT;
	kilo_veh_1 		INT;
	kilo_veh_2 		INT;
	date_d			TIMESTAMP;
	imm_veh			CHAR(6);
	num_las			CHAR(16);
BEGIN
	compteur := 0;
	kilo_veh_1 := 990;
	kilo_veh_2 := 990;
	date_d := '2018-03-08 11:00:00-05';
	
	SELECT COUNT(*) INTO nbre_employe FROM employe;
	
	WHILE compteur < nbre_a_creer LOOP
		rand_1 := FLOOR(RANDOM() * nbre_employe + 1);
		rand_2 := FLOOR(RANDOM() * nbre_employe + 1);
		rand_veh := FLOOR(RANDOM() * 2 + 1);
		date_d := date_d + INTERVAL '3 day';
		
		CASE rand_veh
			WHEN 1 THEN
				kilo_veh_1 := kilo_veh_1 + 30;	
				kilo_veh := kilo_veh_1;	
				imm_veh := 'KYA725';
				num_las := '1234567890123456';
			WHEN 2 THEN
				kilo_veh_2 := kilo_veh_2 + 30;
				kilo_veh := kilo_veh_2;	
				imm_veh := 'FFF350';
				num_las := '2345678901234567';
		END CASE;
		
		WHILE rand_1 = rand_2 LOOP
			rand_2 := FLOOR(RANDOM() * nbre_employe + 1);
		END LOOP;		
	
		INSERT INTO inspection (id_inspection,	
								lien_fichier_inspection,		
								date_inspection_debut,
								date_inspection_fin,
								kilo_debut_inspection,
								kilo_fin_inspection,
								immatriculation_vehicule,
								id_employe_conducteur,
								num_serie_laser,
								id_employe_laser)
			
			VALUES				(DEFAULT,
								 'C:\Inspection',
								 date_d,
								 date_d + INTERVAL '1 hour',
								 kilo_veh,
								 kilo_veh + 10,
								 imm_veh,
								 rand_1,
								 num_las,
								 rand_2);
		
		compteur := compteur + 1;
	END LOOP;
END $$;

-- Procedure #3
-- Créer X inspection troncon pour chaque inspection
-- ----------------------------
CREATE OR REPLACE PROCEDURE creer_insp_tron (nbre_a_creer INT DEFAULT 1)
	
LANGUAGE PLPGSQL
AS $$
DECLARE
	compteur_1 		INT;
	compteur_2 		INT;
	rand 			INT;
	nbre_inspection	INT;

BEGIN	
	compteur_1 := 0;
	compteur_2 := 0;
	
	SELECT COUNT(*) INTO nbre_inspection FROM inspection;
	
	WHILE compteur_1 < nbre_inspection LOOP
		compteur_1 := compteur_1 + 1;
		compteur_2 := 0;
		rand = FLOOR(RANDOM() * 45);
		
		WHILE compteur_2 < nbre_a_creer LOOP
			compteur_2 := compteur_2 + 1;
			
			INSERT INTO inspection_troncon (id_inspection_troncon,
											id_inspection,
											id_troncon)			
				VALUES						(DEFAULT,
											compteur_1,
								 			rand + compteur_2);		
		END LOOP;		
	END LOOP;
END $$;
	
-- Fonction #1
-- Calcul distance selon latitude / longitude
-- ----------------------------
CREATE OR REPLACE FUNCTION long_tronc(
	lat1_f		NUMERIC(9,6),
	lon1_f		NUMERIC(9,6),
	lat2_f		NUMERIC(9,6),
	lon2_f		NUMERIC(9,6))

RETURNS NUMERIC(7,1)

LANGUAGE PLPGSQL
AS $$
DECLARE
	rad_terre	DOUBLE PRECISION := 63710090;
	lat1_rad	DOUBLE PRECISION;
	lon1_rad	DOUBLE PRECISION;
	lat2_rad	DOUBLE PRECISION;
	lon2_rad	DOUBLE PRECISION;
	
BEGIN
	lat1_rad	:= RADIANS(lat1_f);
	lon1_rad	:= RADIANS(lon1_f);
	lat2_rad	:= RADIANS(lat2_f);
	lon2_rad	:= RADIANS(lon2_f);
	
	RETURN rad_terre * SQRT((lat2_rad - lat1_rad) ^ 2 + (COS((lat1_rad + lat2_rad) / 2) * (lon2_rad - lon1_rad)) ^ 2);
END$$;

-- Fonction #2
-- Retourner si la calibration est requise ou non
-- ----------------------------
CREATE OR REPLACE FUNCTION cal_requise(num_serie_laser_f CHAR(16))

RETURNS CHAR(3)

LANGUAGE PLPGSQL
AS $$
DECLARE
	calcul_1	DOUBLE PRECISION;
	calcul_2	DOUBLE PRECISION;
	v1_f		NUMERIC(8,4); 
	v2_f		NUMERIC(8,4); 
	v3_f		NUMERIC(8,4);
	
BEGIN
	SELECT v1, v2, v3 INTO v1_f, v2_f, v3_f FROM calibration_laser
		WHERE num_serie_laser = num_serie_laser_f
		ORDER BY date_fin_calibration DESC
		LIMIT 1;
	
	calcul_1 := sqrt(abs((v1_f * v2_f / (v3_f ^ 2)) - 1));
	calcul_2 := 1 / (pi() ^ 2);
	
	IF calcul_1 <= calcul_2 THEN
		return 'oui';
	ELSE
		return 'non';
	END IF;
END$$;

SELECT * FROM inspection;

-- Fonction déclancheur
-- Generation d'un fichier
-- ----------------------------
CREATE OR REPLACE FUNCTION generer_nom_fichier()

RETURNS TRIGGER

LANGUAGE PLPGSQL
AS $$
DECLARE
	ext		CHAR(5);
	rand	INT;
BEGIN
	rand := FLOOR(RANDOM() * 4 + 1);
	
	CASE rand
		WHEN 1 THEN
			ext := '.xdat';			
		WHEN 2 THEN
			ext := '.jdat';
		WHEN 3 THEN
			ext := '.bdat';
		WHEN 4 THEN
			ext := '.kdat';
	END CASE;
	
	SELECT CONCAT('PZ2_', TRIM(TO_CHAR(nextval('seq_nom_fichier'), '00000000')), '_', TO_CHAR(CURRENT_TIMESTAMP, 'YYMMDDHHMMSS'), ext)
		INTO NEW.nom_fichier_inspection;
	RETURN NEW;
END$$;

-- Création du déclencheur
-- ----------------------------
CREATE TRIGGER trigger_nom_fichier
	BEFORE INSERT ON inspection
	FOR EACH ROW
	EXECUTE PROCEDURE generer_nom_fichier();