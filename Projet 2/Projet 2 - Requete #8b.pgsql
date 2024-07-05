-- Projet 2
-- =======================================================
-- Requête #8b
--
-- Objectif : 
-- Une liste des  calibrations de laser effectuees par les employes 
-- de la des employees qui ont effectues des calibrations dans les laser et 
-- leur derniere calibration. 

-- Évaluation :
-- 
-- 
-- Réalisé par : Edgar Garcia  
-- Aidé par : N/A 
-- ======================================================= 

		SELECT   emp.prenom_employe || ' ' ||  emp.nom_employe  AS "Employe",
				'$/ ' ||ROUND(((emp.salaire_horaire_employe*37.5)*52 ),2) || ' Par année'											AS "Salaire Annuel",
				poste.id_poste ||' '|| INITCAP(poste.nom_poste) 																	AS "Poste",
				dep.id_departement||' ' ||INITCAP(dep.nom_departement) 																AS "Departement",
				'Employé engagé le : '||emp.date_embauche_employe 																	AS "Date embauche de l'employe en charge de la calibrationl'employe en question ",
				'La Calib. No : '|| RIGHT(calib.id_calibration_laser, 8) || ' À été éffectuee du  :' 
				||  date_part('day',calib.date_debut_calibration)||'/' || date_part('month',calib.date_debut_calibration)||
				'/'|| date_part('year',calib.date_debut_calibration) ||' au '|| date_part('day',calib.date_fin_calibration)||
				'/'	|| date_part('month',calib.date_fin_calibration)||'/'|| date_part('year',calib.date_fin_calibration) AS 
				"Calibrations effectues ( les 8 prémiers numero sont masquées) "

						FROM employe AS emp
							JOIN poste AS poste
								ON emp.id_poste = poste.id_poste
									JOIN departement AS dep
										ON emp.id_departement = dep.id_departement
											JOIN calibration_laser AS calib
												ON CALIB.id_employe = emp.id_employe
													GROUP BY emp.prenom_employe,
														 emp.nom_employe,
														 emp.salaire_horaire_employe,
														 poste.id_poste,
														 poste.nom_poste,
														 dep.id_departement,
														 dep.nom_departement,
														 emp.date_embauche_employe,
														 calib.id_calibration_laser 
															ORDER BY "Salaire Annuel" DESC