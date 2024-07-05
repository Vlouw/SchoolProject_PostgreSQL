-- Projet 2
-- -------------------
-- Henri-Paul Bolduc
-- Edgar Garcia
-- Jacques Duymentz
-- -------------------
-- Création des tables
-- -------------------

-- Suppression des outils
DROP TRIGGER IF EXISTS trigger_nom_fichier ON inspection; 
DROP FUNCTION IF EXISTS generer_nom_fichier;
DROP FUNCTION IF EXISTS cal_requise;
DROP FUNCTION IF EXISTS long_tronc;
DROP PROCEDURE IF EXISTS creer_insp_tron;
DROP PROCEDURE IF EXISTS creer_inspection;
DROP PROCEDURE IF EXISTS create_troncon;

-- Suppression des objets en ordre inverse de création
DROP INDEX IF EXISTS idx_intersection_latitude;
DROP INDEX IF EXISTS idx_intersection_longitude;
DROP VIEW IF EXISTS	intersection_rue;

ALTER TABLE IF EXISTS inspection_troncon DROP CONSTRAINT IF EXISTS fk_inspection_troncon_id_troncon;
ALTER TABLE IF EXISTS inspection_troncon DROP CONSTRAINT IF EXISTS fk_inspection_troncon_id_inspection;
ALTER TABLE IF EXISTS inspection 		 DROP CONSTRAINT IF EXISTS fk_inspection_id_employe_laser;
ALTER TABLE IF EXISTS inspection 		 DROP CONSTRAINT IF EXISTS fk_inspection_num_serie_laser;
ALTER TABLE IF EXISTS inspection		 DROP CONSTRAINT IF EXISTS fk_inspection_id_employe_conducteur;
ALTER TABLE IF EXISTS inspection		 DROP CONSTRAINT IF EXISTS fk_inspection_immatriculation_vehicule;
ALTER TABLE IF EXISTS vehicule			 DROP CONSTRAINT IF EXISTS fk_vehicule_id_marque_vehicule;
ALTER TABLE IF EXISTS lumiere			 DROP CONSTRAINT IF EXISTS fk_lumiere_id_troncon;
ALTER TABLE IF EXISTS lumiere			 DROP CONSTRAINT IF EXISTS fk_lumiere_id_type_lumiere;
ALTER TABLE IF EXISTS troncon			 DROP CONSTRAINT IF EXISTS fk_troncon_id_intersection_fin;
ALTER TABLE IF EXISTS troncon			 DROP CONSTRAINT IF EXISTS fk_troncon_id_intersection_debut;
ALTER TABLE IF EXISTS troncon			 DROP CONSTRAINT IF EXISTS fk_troncon_id_rue;
ALTER TABLE IF EXISTS panneau			 DROP CONSTRAINT IF EXISTS fk_panneau_id_troncon;
ALTER TABLE IF EXISTS panneau			 DROP CONSTRAINT IF EXISTS fk_panneau_id_type_panneau;
ALTER TABLE IF EXISTS dispositif		 DROP CONSTRAINT IF EXISTS fk_dispositif_id_troncon;
ALTER TABLE IF EXISTS dispositif		 DROP CONSTRAINT IF EXISTS fk_dispositif_id_type_dispositif;
ALTER TABLE IF EXISTS calibration_laser	 DROP CONSTRAINT IF EXISTS fk_calibration_laser_id_employe;
ALTER TABLE IF EXISTS calibration_laser	 DROP CONSTRAINT IF EXISTS fk_calibration_laser_num_serie_laser;
ALTER TABLE IF EXISTS laser				 DROP CONSTRAINT IF EXISTS fk_laser_id_marque_laser;
ALTER TABLE IF EXISTS employe			 DROP CONSTRAINT IF EXISTS fk_employe_id_departement;
ALTER TABLE IF EXISTS employe			 DROP CONSTRAINT IF EXISTS fk_employe_id_poste;

DROP TABLE IF EXISTS inspection_troncon;
DROP TABLE IF EXISTS inspection;
DROP TABLE IF EXISTS vehicule;
DROP TABLE IF EXISTS marque_vehicule;
DROP TABLE IF EXISTS lumiere;
DROP TABLE IF EXISTS type_lumiere;
DROP TABLE IF EXISTS rue;
DROP TABLE IF EXISTS inter_section;
DROP TABLE IF EXISTS troncon;
DROP TABLE IF EXISTS type_panneau;
DROP TABLE IF EXISTS panneau;
DROP TABLE IF EXISTS type_dispositif;
DROP TABLE IF EXISTS dispositif;
DROP TABLE IF EXISTS calibration_laser;
DROP TABLE IF EXISTS marque_laser;
DROP TABLE IF EXISTS laser;
DROP TABLE IF EXISTS departement;
DROP TABLE IF EXISTS poste;
DROP TABLE IF EXISTS employe;

DROP TYPE IF EXISTS orientLum;
DROP TYPE IF EXISTS modeLum;
DROP TYPE IF EXISTS pavage;
DROP TYPE IF EXISTS genre;

DROP SEQUENCE IF EXISTS seq_id_intersection;
DROP SEQUENCE IF EXISTS seq_nom_fichier;

-- Création des sequences
CREATE SEQUENCE seq_nom_fichier
	INCREMENT BY 1
	MINVALUE 20
	MAXVALUE 99999999;

CREATE SEQUENCE seq_id_intersection
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9999999;

-- Création des objets dont les tables dépendent
CREATE TYPE genre			AS ENUM ('f', 'h', 'x');
CREATE TYPE pavage 			AS ENUM ('asphalte', 'ciment', 'pave_brique', 'pave_pierre', 'non_pave', 'indetermine');
CREATE TYPE modeLum			AS ENUM ('solide', 'clignotant', 'controle', 'intelligente');
CREATE TYPE orientLum 		AS ENUM ('horizontale', 'verticale', 'autre');
						   
-- Création des tables sans les contraintes de clé étrangère
CREATE TABLE employe (
	id_employe					SERIAL				,
	nas_employe					CHAR(9)				NOT NULL,
	nom_employe					VARCHAR(32)			NOT NULL,
	prenom_employe				VARCHAR(32)			NOT NULL,
	genre_employe				genre				NOT NULL,
	date_embauche_employe		DATE				,
	salaire_horaire_employe		NUMERIC(5,2)		NOT NULL	DEFAULT 27.50,
	id_poste					INTEGER				NOT NULL,
	id_departement				INTEGER				NOT NULL,
	
	CONSTRAINT pk_employe							PRIMARY KEY (id_employe),
	CONSTRAINT cc_emloye_date_embauche_employe		CHECK		(date_embauche_employe <= CURRENT_DATE AND date_embauche_employe >= '2018-01-01'),
	CONSTRAINT cc_employe_salaire_horaire_employe	CHECK		(salaire_horaire_employe <= 250 AND salaire_horaire_employe >= 15)
);

CREATE TABLE poste (
	id_poste					SERIAL				,
	nom_poste					VARCHAR(128)		NOT NULL,
	
	CONSTRAINT pk_poste								PRIMARY KEY (id_poste)
);

CREATE TABLE departement (
	id_departement				SERIAL				,
	nom_departement				VARCHAR(128)		NOT NULL,
	
	CONSTRAINT pk_departement						PRIMARY KEY (id_departement)
);

CREATE TABLE laser (
	num_serie_laser				CHAR(16)			,
	date_acquisition_laser		DATE				,
	date_fabrication_laser		DATE				,
	id_marque_laser				INTEGER				NOT NULL,
	
	CONSTRAINT pk_laser								PRIMARY KEY (num_serie_laser)
);

CREATE TABLE marque_laser (
	id_marque_laser				SERIAL				,
	marque_laser				VARCHAR(32)			NOT NULL,
	
	CONSTRAINT pk_marque_laser						PRIMARY KEY (id_marque_laser)
);

CREATE TABLE calibration_laser (
	id_calibration_laser		CHAR(16)			,
	date_debut_calibration		TIMESTAMP			NOT NULL,
	date_fin_calibration		TIMESTAMP			NOT NULL,
	v1							NUMERIC(8,4)		NOT NULL,
	v2							NUMERIC(8,4)		NOT NULL,
	v3							NUMERIC(8,4)		NOT NULL,
	num_serie_laser				CHAR(16)			NOT NULL,
	id_employe					INTEGER				NOT NULL,
	
	CONSTRAINT pk_calibration_laser					PRIMARY KEY (id_calibration_laser),
	CONSTRAINT cc_calibration_laser_v1				CHECK		(v1 <= 1000 AND v1 >= -1000),
	CONSTRAINT cc_calibration_laser_v2				CHECK		(v2 <= 1000 AND v2 >= -1000),
	CONSTRAINT cc_calibration_laser_v3				CHECK		(v3 <= 1000 AND v3 >= -1000)
);

CREATE TABLE dispositif (
	id_dispositif 				BIGSERIAL			,
	position_dispositif			NUMERIC(5,2)		NOT NULL,	
	id_type_dispositif			INTEGER				NOT NULL,
	id_troncon					BIGINT				NOT NULL,
	
	CONSTRAINT pk_dispositif						PRIMARY KEY (id_dispositif),
	CONSTRAINT cc_dispositif_position_dispositif	CHECK		(position_dispositif <= 100 AND position_dispositif >= 0)	
);

CREATE TABLE type_dispositif (
	id_type_dispositif			SERIAL				,	
	type_dispositif				VARCHAR(128)		NOT NULL,	
	
	CONSTRAINT pk_type_dispositif					PRIMARY KEY (id_type_dispositif)
);

CREATE TABLE panneau (
	id_panneau					BIGSERIAL			,
	position_panneau			NUMERIC(5,2)		NOT NULL,
	id_type_panneau				INTEGER				NOT NULL,
	id_troncon					BIGINT				NOT NULL,
	
	CONSTRAINT pk_panneau							PRIMARY KEY (id_panneau),
	CONSTRAINT cc_panneau_position_panneau			CHECK		(position_panneau <= 100 AND position_panneau >= 0)
);

CREATE TABLE type_panneau (
	id_type_panneau				SERIAL				,
	type_panneau				VARCHAR(128)		NOT NULL,
	
	CONSTRAINT pk_type_panneau						PRIMARY KEY (id_type_panneau)
);		

CREATE TABLE troncon (
	id_troncon					BIGSERIAL			,
	longueur_troncon			NUMERIC(7,1)		NOT NULL,
	limite_vitesse_troncon		NUMERIC(3,0)		NOT NULL,
	voie_troncon				NUMERIC(1,0)		NOT NULL	DEFAULT 1,
	type_pavage					pavage 				NOT NULL,
	id_rue						BIGINT				NOT NULL,
	id_intersection_debut		NUMERIC(7,0)		NOT NULL,						
	id_intersection_fin			NUMERIC(7,0)		NOT NULL,
	
	CONSTRAINT pk_troncon							PRIMARY KEY (id_troncon),
	CONSTRAINT cc_troncon_longueur_troncon			CHECK		(longueur_troncon <= 100000 AND longueur_troncon >= 0),
	CONSTRAINT cc_troncon_limite_vitesse_troncon	CHECK		(limite_vitesse_troncon <= 120 AND limite_vitesse_troncon >= 25),
	CONSTRAINT cc_troncon_voie_troncon				CHECK		(voie_troncon <= 8 AND voie_troncon >= 1)	
);

CREATE TABLE  inter_section(
	id_intersection				NUMERIC(7,0)		DEFAULT nextval('seq_id_intersection'),
	latitude_intersection		NUMERIC(9,6)		NOT NULL,
	longitude_intersection		NUMERIC(9,6)		NOT NULL,
	type_pavage 				pavage				NOT NULL,
	
	CONSTRAINT pk_intersection							PRIMARY KEY (id_intersection),
	CONSTRAINT cc_intersection_latitude_intersection	CHECK		(latitude_intersection <= 90 AND latitude_intersection >= -90),
	CONSTRAINT cc_intersection_longitude_intersection	CHECK		(longitude_intersection <= 180 AND longitude_intersection >= -180)
);

CREATE TABLE rue (	
	id_rue						BIGSERIAL			,
	nom_rue						VARCHAR(32)			NOT NULL,
	
	CONSTRAINT pk_rue								PRIMARY KEY (id_rue)	
);

CREATE TABLE type_lumiere (	
	id_type_lumiere				BIGSERIAL			,
	mode_lumiere				modeLum				NOT NULL,
	orientation_lumiere			orientLum			NOT NULL,
	--id_forme_lumiere				VARCHAR(32)			NOT NULL,
	--id_couleur_lumiere			VARCHAR(32)			NOT NULL,
	
	CONSTRAINT pk_type_lumiere						PRIMARY KEY (id_type_lumiere)	
);

CREATE TABLE lumiere (	
	id_lumiere					BIGSERIAL			,
	position_lumiere			NUMERIC(5,2)		NOT NULL,
	id_type_lumiere				BIGINT				NOT NULL,
	id_troncon					BIGINT				NOT NULL,
	
	CONSTRAINT pk_lumiere							PRIMARY KEY (id_lumiere),	
	CONSTRAINT cc_lumiere_position_lumiere			CHECK		(position_lumiere >= 0 AND position_lumiere <= 100)
);

CREATE TABLE marque_vehicule (	
	id_marque_vehicule			SERIAL				,
	marque_vehicule_nom			VARCHAR(32)			NOT NULL,
	modele_vehicule				VARCHAR(32)			NOT NULL,
	
	CONSTRAINT pk_marque_vehicule					PRIMARY KEY (id_marque_vehicule)	
);

CREATE TABLE vehicule (	
	immatriculation_vehicule	CHAR(6)				,
	date_acquisition_vehicule	DATE				,
	id_marque_vehicule			INT					NOT NULL,
	
	CONSTRAINT pk_vehicule			PRIMARY KEY (immatriculation_vehicule)	
);

CREATE TABLE inspection (	
	id_inspection				BIGSERIAL			,
	lien_fichier_inspection		VARCHAR(1024)		NOT NULL,
	--nom_fichier_inspection		CHAR(30)			NOT NULL,
	date_inspection_debut		TIMESTAMP			NOT NULL,
	date_inspection_fin			TIMESTAMP			NOT NULL,
	kilo_debut_inspection		INT					NOT NULL,
	kilo_fin_inspection			INT					NOT NULL,
	immatriculation_vehicule	CHAR(6)				NOT NULL,
	id_employe_conducteur		INT					NOT NULL,
	num_serie_laser				CHAR(16)			NOT NULL,
	id_employe_laser			INT					NOT NULL,
	nom_fichier_inspection		CHAR(30)			NOT NULL,
	
	CONSTRAINT pk_inspection						PRIMARY KEY (id_inspection),
	CONSTRAINT cc_inspection_kilo_debut				CHECK		(kilo_debut_inspection >= 1 AND kilo_debut_inspection <= 500000),
	CONSTRAINT cc_inspection_kilo_fin				CHECK		(kilo_fin_inspection >= 1 AND kilo_fin_inspection <= 500000)
);


CREATE TABLE inspection_troncon (	
	id_inspection_troncon		BIGSERIAL			,
	id_inspection				BIGINT				NOT NULL,
	id_troncon					BIGINT				NOT NULL,
	
	CONSTRAINT pk_inspection_troncon				PRIMARY KEY (id_inspection_troncon)	
);

-- Modification des tables et ajout des contraintes de clé étrangères
ALTER TABLE employe
	ADD CONSTRAINT fk_employe_id_poste
		FOREIGN KEY (id_poste) REFERENCES poste(id_poste) ON DELETE SET NULL;
		
ALTER TABLE employe
	ADD CONSTRAINT fk_employe_id_departement
		FOREIGN KEY (id_departement) REFERENCES departement(id_departement) ON DELETE SET NULL;
		
ALTER TABLE laser
	ADD CONSTRAINT fk_laser_id_marque_laser
		FOREIGN KEY (id_marque_laser) REFERENCES marque_laser(id_marque_laser) ON DELETE SET NULL;
		
ALTER TABLE calibration_laser
	ADD CONSTRAINT fk_calibration_laser_num_serie_laser
		FOREIGN KEY (num_serie_laser) REFERENCES laser(num_serie_laser) ON DELETE SET NULL;
		
ALTER TABLE calibration_laser
	ADD CONSTRAINT fk_calibration_laser_id_employe
		FOREIGN KEY (id_employe	) REFERENCES employe(id_employe	) ON DELETE SET NULL;		
		
ALTER TABLE dispositif
	ADD CONSTRAINT fk_dispositif_id_type_dispositif
		FOREIGN KEY (id_type_dispositif) REFERENCES type_dispositif(id_type_dispositif) ON DELETE SET NULL;

ALTER TABLE dispositif
	ADD CONSTRAINT fk_dispositif_id_troncon
		FOREIGN KEY (id_troncon) REFERENCES troncon(id_troncon) ON DELETE SET NULL;		

ALTER TABLE panneau
	ADD CONSTRAINT fk_panneau_id_type_panneau
		FOREIGN KEY (id_type_panneau) REFERENCES type_panneau(id_type_panneau) ON DELETE SET NULL;

ALTER TABLE panneau
	ADD CONSTRAINT fk_panneau_id_troncon
		FOREIGN KEY (id_troncon) REFERENCES troncon(id_troncon) ON DELETE SET NULL;

ALTER TABLE troncon
	ADD CONSTRAINT fk_troncon_id_rue
		FOREIGN KEY (id_rue) REFERENCES rue(id_rue) ON DELETE SET NULL;

ALTER TABLE troncon
	ADD CONSTRAINT fk_troncon_id_intersection_debut
		FOREIGN KEY (id_intersection_debut)	REFERENCES inter_section(id_intersection) ON DELETE SET NULL;

ALTER TABLE troncon
	ADD CONSTRAINT fk_troncon_id_intersection_fin
		FOREIGN KEY (id_intersection_fin) REFERENCES inter_section(id_intersection) ON DELETE SET NULL;

ALTER TABLE lumiere
	ADD CONSTRAINT fk_lumiere_id_type_lumiere
		FOREIGN KEY (id_type_lumiere) REFERENCES type_lumiere(id_type_lumiere) ON DELETE SET NULL;
	
ALTER TABLE lumiere
	ADD CONSTRAINT fk_lumiere_id_troncon
		FOREIGN KEY (id_troncon) REFERENCES troncon(id_troncon) ON DELETE SET NULL;

ALTER TABLE vehicule
	ADD CONSTRAINT fk_vehicule_id_marque_vehicule
		FOREIGN KEY (id_marque_vehicule) REFERENCES marque_vehicule(id_marque_vehicule) ON DELETE SET NULL;

ALTER TABLE inspection
	ADD CONSTRAINT fk_inspection_immatriculation_vehicule
		FOREIGN KEY (immatriculation_vehicule) REFERENCES vehicule(immatriculation_vehicule) ON DELETE SET NULL;

ALTER TABLE inspection
	ADD CONSTRAINT fk_inspection_id_employe_conducteur
		FOREIGN KEY (id_employe_conducteur) REFERENCES employe(id_employe) ON DELETE SET NULL;
		
ALTER TABLE inspection
	ADD CONSTRAINT fk_inspection_num_serie_laser
		FOREIGN KEY (num_serie_laser) REFERENCES laser(num_serie_laser) ON DELETE SET NULL;
		
ALTER TABLE inspection
	ADD CONSTRAINT fk_inspection_id_employe_laser
		FOREIGN KEY (id_employe_laser) REFERENCES employe(id_employe) ON DELETE SET NULL;
		
ALTER TABLE inspection_troncon
	ADD CONSTRAINT fk_inspection_troncon_id_inspection
		FOREIGN KEY (id_inspection) REFERENCES inspection(id_inspection) ON DELETE SET NULL;
				
ALTER TABLE inspection_troncon
	ADD CONSTRAINT fk_inspection_troncon_id_troncon
		FOREIGN KEY (id_troncon) REFERENCES troncon(id_troncon) ON DELETE SET NULL;
		
-- Création d'une vue
CREATE VIEW intersection_rue AS
	SELECT	DISTINCT
			inter_section.id_intersection 	AS "ID Intersection",
			rue.nom_rue 					AS "Nom rue"
		FROM troncon
			INNER JOIN inter_section
				ON troncon.id_intersection_debut = inter_section.id_intersection
					OR troncon.id_intersection_fin = inter_section.id_intersection
			INNER JOIN rue
				ON troncon.id_rue = rue.id_rue;
				
-- Création de 2 index
CREATE INDEX idx_intersection_latitude 
	ON inter_section(latitude_intersection ASC);
	
CREATE INDEX idx_intersection_longitude 
	ON inter_section(longitude_intersection ASC);	
	