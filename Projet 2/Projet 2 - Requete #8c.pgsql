-- Projet 2
-- =======================================================
-- Requête #8c
--
-- Objectif : 
-- Pour chaque combination de conducteur, immatriculation et manipulateur de laser, one va compter toutes les fois qeu ces combinations sont arrivés
--
-- Évaluation :
-- 
-- 
-- Réalisé par : Jacques Duymentz
-- Aidé par : Edgar Garcia 
-- ======================================================= 
SELECT  DISTINCT marque_vehicule.modele_vehicule  AS "Modele de Vehicule", 
				inspection.immatriculation_vehicule AS "Plaque de Immatriculation", 
				COUNT(inspection.id_employe_conducteur)  AS "Nb d'inspections avec ce conducteur et ce manipulateur de laser", 
					vehicule.date_acquisition_vehicule AS " Le vehicule a ete obtenu ", 
						inspection.id_employe_conducteur||' - '||employe.prenom_employe ||' '||employe.nom_employe AS "Conducteur du vehicule", 
							inspection.id_employe_laser AS "Manipulateur du laser"
		
	FROM inspection
	 INNER JOIN vehicule
	 	ON inspection.immatriculation_vehicule = vehicule.immatriculation_vehicule
			INNER JOIN marque_vehicule 
				ON vehicule.id_marque_vehicule = marque_vehicule.id_marque_vehicule
					INNER JOIN employe
						ON inspection.id_employe_conducteur = employe.id_employe
			GROUP BY inspection.immatriculation_vehicule,vehicule.date_acquisition_vehicule,inspection.id_employe_conducteur,inspection.id_employe_laser, marque_vehicule.modele_vehicule,employe.prenom_employe,
			employe.nom_employe
			
		