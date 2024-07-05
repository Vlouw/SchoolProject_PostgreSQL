-- Projet 1
-- -------------------
-- Henri-Paul Bolduc
-- Edgar Garcia
-- Jacques Duymentz
-- -------------------
-- Création des tables
-- -------------------

-- Suppression des objets en ordre inverse de création
ALTER TABLE IF EXISTS capsule_activite	DROP CONSTRAINT IF EXISTS fk_capsule_activite_nom_avatar;
ALTER TABLE IF EXISTS capsule_activite	DROP CONSTRAINT IF EXISTS fk_capsule_activite_sigle_jeu;
ALTER TABLE IF EXISTS capsule_activite	DROP CONSTRAINT IF EXISTS fk_capsule_activite_id_activite;
ALTER TABLE IF EXISTS activite			DROP CONSTRAINT IF EXISTS fk_activite_alias_joueur;
ALTER TABLE IF EXISTS item_avatar		DROP CONSTRAINT IF EXISTS fk_item_avatar_sigle_item;
ALTER TABLE IF EXISTS item_avatar		DROP CONSTRAINT IF EXISTS fk_item_avatar_nom_avatar;
ALTER TABLE IF EXISTS habilete_avatar	DROP CONSTRAINT IF EXISTS fk_habilete_avatar_sigle_habilete;
ALTER TABLE IF EXISTS habilete_avatar	DROP CONSTRAINT IF EXISTS fk_habilete_avatar_nom_avatar;
ALTER TABLE IF EXISTS phrase_avatar		DROP CONSTRAINT IF EXISTS fk_phrase_avatar_nom_avatar;
ALTER TABLE IF EXISTS item				DROP CONSTRAINT IF EXISTS fk_item_sigle_jeu;
ALTER TABLE IF EXISTS habilete			DROP CONSTRAINT IF EXISTS fk_habilete_sigle_jeu;
ALTER TABLE IF EXISTS avatar			DROP CONSTRAINT IF EXISTS fk_avatar_alias_joueur;

DROP TABLE IF EXISTS capsule_activite;
DROP TABLE IF EXISTS activite;
DROP TABLE IF EXISTS item_avatar;
DROP TABLE IF EXISTS habilete_avatar;
DROP TABLE IF EXISTS phrase_avatar;
DROP TABLE IF EXISTS item;
DROP TABLE IF EXISTS habilete;
DROP TABLE IF EXISTS avatar;
DROP TABLE IF EXISTS joueur;
DROP TABLE IF EXISTS jeu;

DROP TYPE IF EXISTS genre;

-- Création des objets dont les tables dépendent
CREATE TYPE genre AS ENUM ('f', 'h', 'x');
						   
-- Création des tables sans les contraintes de clé étrangère
CREATE TABLE jeu (
	sigle_jeu					CHAR(6) 			,
	nom_jeu						VARCHAR(16) 		NOT NULL,
	desc_jeu					VARCHAR(2048)		,
	
	CONSTRAINT pk_jeu								PRIMARY KEY	(sigle_jeu),
	CONSTRAINT uc_jeu								UNIQUE		(nom_jeu)	
);

CREATE TABLE joueur (
	alias_joueur				VARCHAR(32)			,
	courriel_joueur				VARCHAR(128)		NOT NULL,
	mdp_joueur					VARCHAR(32)			NOT NULL,
	genre_joueur				genre				DEFAULT NULL,
	date_inscription_joueur		DATE				NOT NULL,
	date_naissance_joueur		DATE				NOT NULL,
	
	CONSTRAINT pk_joueur							PRIMARY KEY	(alias_joueur),
    CONSTRAINT uc_joueur							UNIQUE		(courriel_joueur),
	CONSTRAINT cc_joueur_date_inscription_joueur	CHECK		(date_inscription_joueur >= '2020-01-01'),
	CONSTRAINT cc_joueur_date_naissance_joueur		CHECK		(DATE_PART('year', AGE(CURRENT_DATE, date_naissance_joueur)) >= 13 AND date_naissance_joueur >= '1900-01-01')
);

CREATE TABLE avatar (
	nom_avatar					VARCHAR(32)			,
	couleur_1_avatar			INTEGER				NOT NULL,
	couleur_2_avatar			INTEGER				,
	couleur_3_avatar			INTEGER				,
	date_creation_avatar		DATE				NOT NULL DEFAULT CURRENT_DATE,
	qte_mox_avatar				INTEGER				NOT NULL DEFAULT 0,
	alias_joueur				VARCHAR(32)			NOT NULL, 						
	
	CONSTRAINT pk_avatar							PRIMARY KEY	(nom_avatar),
	CONSTRAINT cc_avatar_qte_mox_avatar				CHECK		(qte_mox_avatar BETWEEN -1000000000 AND 1000000000)
);

CREATE TABLE habilete (
	sigle_habilete				CHAR(3) 			,
	nom_habilete				VARCHAR(32) 		NOT NULL,
	ener_max_habilete			NUMERIC(7,3)		NOT NULL,   
	coef1_habilete				DOUBLE PRECISION	NOT NULL DEFAULT 0,
	coef2_habilete				DOUBLE PRECISION	NOT NULL DEFAULT 0,
	coef3_habilete				DOUBLE PRECISION	NOT NULL DEFAULT 1,
	desc_habilete				VARCHAR(1024)		,
	sigle_jeu					CHAR(6) 			NOT NULL,	

    CONSTRAINT pk_habilete							PRIMARY KEY	(sigle_habilete),
    CONSTRAINT uc_habilete							UNIQUE		(nom_habilete),
    CONSTRAINT cc_habilete_sigle_habilete			CHECK		(sigle_habilete LIKE 'S__'),
	CONSTRAINT cc_habilete_ener_max_habilete		CHECK		(ener_max_habilete BETWEEN 10.000 AND 1000.000)  
);

CREATE TABLE item (
	sigle_item					CHAR(4) 			,
	nom_item					VARCHAR(32) 		NOT NULL,
	prob_item					NUMERIC(4,3)		NOT NULL DEFAULT 0.025,
	desc_item					VARCHAR(1024)		,						
	sigle_jeu					CHAR(6) 			NOT NULL,	

    CONSTRAINT pk_item								PRIMARY KEY	(sigle_item),
    CONSTRAINT uc_item								UNIQUE		(nom_item),
    CONSTRAINT cc_item_sigle_item					CHECK		(sigle_item LIKE 'I___'),
	CONSTRAINT cc_item_prob_item					CHECK		(prob_item > 0.000 AND prob_item < 1.000)
);

CREATE TABLE phrase_avatar (
	id_phrase					BIGSERIAL			,
	phrase						VARCHAR(64)			,
	nom_avatar					VARCHAR(32) 		NOT NULL,
	
	CONSTRAINT pk_phrase_avatar 					PRIMARY KEY	(id_phrase)
);

CREATE TABLE habilete_avatar ( 
	nom_avatar					VARCHAR(32) 		,
	sigle_habilete				CHAR(3) 			,
	niveau_habilete				INTEGER				NOT NULL DEFAULT 1,
	date_obtention_habilete		TIMESTAMP			NOT NULL DEFAULT CURRENT_TIMESTAMP,	

    CONSTRAINT pk_habilete_avatar					PRIMARY KEY	(nom_avatar, sigle_habilete),
	CONSTRAINT cc_habilete_avatar_niveau_habilete	CHECK		(niveau_habilete BETWEEN 1 AND 100)  
);

CREATE TABLE item_avatar (
	nom_avatar					VARCHAR(32)			,
	sigle_item					CHAR(4)				,
	qte_item					NUMERIC(6,0)		NOT NULL DEFAULT 1,
	date_obtention_item			TIMESTAMP			NOT NULL DEFAULT CURRENT_TIMESTAMP,
	
	CONSTRAINT pk_item_avatar						PRIMARY KEY	(nom_avatar, sigle_item),
	CONSTRAINT cc_item_avatar_qte_item				CHECK		(qte_item BETWEEN 0 AND 100000) 
);

CREATE TABLE activite (
	id_activite  				BIGSERIAL			,
	date_debut_activite			TIMESTAMP			NOT NULL,
	duree_activite				INT					NOT NULL,
	alias_joueur				VARCHAR(32)			NOT NULL,
	
	CONSTRAINT pk_activite							PRIMARY KEY (id_activite),
	CONSTRAINT cc_activite_duree_activite 			CHECK		(duree_activite > 0 )
);

CREATE TABLE capsule_activite (
	id_capsule					BIGSERIAL			,
	duree_capsule				INT					NOT NULL,
	id_activite					BIGINT				NOT NULL,
	sigle_jeu					CHAR(6) 			NOT NULL,
	nom_avatar					VARCHAR(32) 		NOT NULL,	
	
	CONSTRAINT pk_capsule_activite					PRIMARY KEY (id_capsule),
	CONSTRAINT cc_capsule_activite_duree_capsule 	CHECK		(duree_capsule > 0 )	
);

-- Modification des tables et ajout des contraintes de clé étrangères
ALTER TABLE avatar
	ADD CONSTRAINT fk_avatar_alias_joueur 
		FOREIGN KEY (alias_joueur) REFERENCES joueur(alias_joueur) ON DELETE SET NULL;
	
ALTER TABLE habilete
	ADD CONSTRAINT fk_habilete_sigle_jeu 
		FOREIGN KEY (sigle_jeu) REFERENCES jeu(sigle_jeu) ON DELETE SET NULL;

ALTER TABLE item
	ADD CONSTRAINT fk_item_sigle_jeu 
		FOREIGN KEY (sigle_jeu) REFERENCES jeu(sigle_jeu) ON DELETE SET NULL;

ALTER TABLE phrase_avatar
	ADD CONSTRAINT fk_phrase_avatar_nom_avatar 
		FOREIGN KEY (nom_avatar) REFERENCES avatar(nom_avatar) ON DELETE SET NULL;

ALTER TABLE habilete_avatar
	ADD CONSTRAINT fk_habilete_avatar_nom_avatar 
		FOREIGN KEY (nom_avatar) REFERENCES avatar(nom_avatar) ON DELETE SET NULL;

ALTER TABLE habilete_avatar
	ADD CONSTRAINT fk_habilete_avatar_sigle_habilete 
		FOREIGN KEY (sigle_habilete) REFERENCES habilete(sigle_habilete) ON DELETE SET NULL;

ALTER TABLE item_avatar
	ADD CONSTRAINT fk_item_avatar_nom_avatar 
		FOREIGN KEY (nom_avatar) REFERENCES avatar(nom_avatar) ON DELETE SET NULL;
	
ALTER TABLE item_avatar
	ADD CONSTRAINT fk_item_avatar_sigle_item 
		FOREIGN KEY (sigle_item) REFERENCES item(sigle_item) ON DELETE SET NULL;
		
ALTER TABLE activite
	ADD CONSTRAINT fk_activite_alias_joueur
		FOREIGN KEY (alias_joueur) REFERENCES joueur(alias_joueur) ON DELETE SET NULL;
		
ALTER TABLE capsule_activite
	ADD CONSTRAINT fk_capsule_activite_id_activite
		FOREIGN KEY (id_activite) REFERENCES activite(id_activite) ON DELETE SET NULL;
		
ALTER TABLE capsule_activite
	ADD CONSTRAINT fk_capsule_activite_sigle_jeu
		FOREIGN KEY (sigle_jeu) REFERENCES jeu(sigle_jeu) ON DELETE SET NULL;
		
ALTER TABLE capsule_activite
	ADD CONSTRAINT fk_capsule_activite_nom_avatar
		FOREIGN KEY (nom_avatar) REFERENCES avatar(nom_avatar) ON DELETE SET NULL;