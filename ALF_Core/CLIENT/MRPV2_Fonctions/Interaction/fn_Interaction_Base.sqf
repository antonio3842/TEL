/*
// MRPV2_fnc_Interaction_base = {
private _obj = param [0,objnull];

systemChat format ["[DEBUG] Interaction_Base DEBUT: typeOf = %1", typeof _obj];

if (((getModelInfo _obj) # 1) in ALF_Mobiliers_Objects_Data) exitWith {[_obj] spawn ALF_fnc_mobilierMenu;TRUE};
// if (_obj distance player > 5) exitWith {FALSE};

private _info_Modele = tolowerANSI ((getModelInfo _obj) # 0);
systemChat format ["[DEBUG] Interaction_Base: _info_Modele = %1", _info_Modele];

// Interaction derick pétrole baril vide vers baril plein
if (tolowerANSI "derrick" in _info_Modele) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Derrick;TRUE};

// Interaction scanner hopital
if (tolowerANSI "alf_irm" in _info_Modele) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Scanner_IRM;TRUE};

// Interaction Fonte
if (tolowerANSI "fonte" in _info_Modele) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Fonte;TRUE};

// Interaction PNJ, a des variables associées
if (tolowerANSI "MRPV2_PNJ" in (tolowerANSI str _obj)) exitWith {[_obj] spawn MRPV2_fnc_Interaction_PNJ;TRUE};

// Interaction Charriot Valise Brinks
if (tolowerANSI "MRPV2_Valise_Argent" in (tolowerANSI str _obj)) exitWith {[] spawn MRPV2_fnc_Interaction_Objets_BRINKS;TRUE};

// Interaction Joueur
if (isplayer _obj AND {crew _obj isequalto [_obj]}) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Joueurs;TRUE};

// Interaction s’asseoir sur mobilier
private _liste_Mobiliers = ["officechair_01_f"];
if (_liste_Mobiliers select {_x in _info_Modele} isnotequalto []) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction ecran prefecture
if (tolowerANSI "pcset_01_screen_f" in _info_Modele) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction bureau 1
if (tolowerANSI "bureau1" in _info_Modele) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction bureau 2
if (tolowerANSI "mrp_bureau" in _info_Modele) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction Tailleuse Diamant
if (tolowerANSI "tailleuse" in _info_Modele) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction Transformation planche
if (tolowerANSI "table_bois" in _info_Modele) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction Transformation banane
if (tolowerANSI "mixeur" in _info_Modele) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction Transformation
if (tolowerANSI "workbench" in _info_Modele) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction Transformation diamant
if (tolowerANSI "milling" in _info_Modele) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction sechage
if (tolowerANSI "secheurTabac" in _info_Modele) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction confection Cigarette/Cigare
if (tolowerANSI "cigcigare" in _info_Modele) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction Transformation Lingot
if (tolowerANSI "furnace" in _info_Modele) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction Transformation sushi
if (tolowerANSI "fedex" in _info_Modele) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction Transformation bouteille
if (tolowerANSI "embouteillage" in _info_Modele) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction Transformation bouteille
if (tolowerANSI "conditionnement" in _info_Modele) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction Transformation Pressage
if (tolowerANSI "pressoir" in _info_Modele) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction Fermentation
if (tolowerANSI "barrel" in _info_Modele) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction Fermentation
if (tolowerANSI "recharge" in _info_Modele) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction Brancard (ALF_Brancard_P et VEH_MRP_Brancard_Vsav)
if (typeOf _obj in ["ALF_Brancard_P", "VEH_MRP_Brancard_Vsav"]) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction Concentrateur traitement pétrole
if (tolowerANSI "concentrateur" in _info_Modele) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction Casier
if (tolowerANSI "casier" in _info_Modele) exitwith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction Machine à  sous
if (tolowerANSI "alf_slotmachine" in _info_Modele) exitwith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction borne
if (tolowerANSI "land_infoStand" in _info_Modele) exitwith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction Malette
if (tolowerANSI "suitcase_f" in _info_Modele) exitwith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction avec citerne de station essence
if (tolowerANSI "plp_up_propanetanka" in _info_Modele) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Citerne_Station_Essence;TRUE};

// Interaction pompe ravitaillement voiture
if (tolowerANSI "alf_pompe" in _info_Modele) exitWith {[tolowerANSI typeof _obj] spawn MRPV2_fnc_Interaction_Batiments;TRUE};

// Interaction Banque Credit mutuel
if (tolowerANSI "alf_crem" in _info_Modele) exitWith {[tolowerANSI typeof _obj] spawn MRPV2_fnc_Interaction_Batiments;TRUE};

// Interaction Dab
if (tolowerANSI "alf_atm" in _info_Modele) exitWith {[tolowerANSI typeof _obj] spawn MRPV2_fnc_Interaction_Batiments;TRUE};

// Interaction Transformateur
if (tolowerANSI "alf_trafo" in _info_Modele) exitWith {[tolowerANSI typeof _obj] spawn MRPV2_fnc_Interaction_Batiments;TRUE};
// Interaction trash - désactivé (appel incorrect à Incendie_FX)
// if (tolowerANSI "Land_GarbageBin_02_F" in _info_Modele) exitWith {[tolowerANSI typeof _obj] spawn ALF_fnc_interactions_player_to_trash;TRUE};

// Interaction Ent
if (tolowerANSI "alf_entreprise" in _info_Modele) exitWith {
	systemChat "[DEBUG] Interaction_Base: Détection par MODELE (alf_entreprise dans _info_Modele) - EXIT";
	[tolowerANSI typeof _obj] spawn MRPV2_fnc_Interaction_Batiments;TRUE
};

// Interaction Ent Spéciale Concessionnaire
if (tolowerANSI "mrp_concessionnaire" in _info_Modele) exitWith {[tolowerANSI typeof _obj] spawn MRPV2_fnc_Interaction_Batiments;TRUE};

// Interaction Batiment CHien Cynophile
if (tolowerANSI "touristshelter_01_f" in _info_Modele) exitWith {[tolowerANSI typeof _obj] spawn MRPV2_fnc_Interaction_Batiments;TRUE};

// Interaction niche Chien Cynophile
if (tolowerANSI "plp_up_dogkennellight" in _info_Modele) exitWith {[_info_Modele] spawn MRPV2_fnc_Interaction_Batiments;TRUE};

// Interaction Hangar Entreprise (vérifier avant les maisons car les hangars sont aussi des House_F)
private _typeObj = tolowerANSI (typeof _obj);
private _resultat_Hangar = [_typeObj, _obj] call {
	params ["_typeObj", "_obj"];
	if (_typeObj in [tolowerANSI "Land_i_Shed_Ind_F", tolowerANSI "Land_SM_01_shed_F"]) then {
		systemChat "[DEBUG] Interaction_Base: Détection hangar";
		private _info_Hangar = _obj getVariable ["business",[]];
		
		// Si le hangar a une variable business, vérifier si c'est un hangar entreprise
		if ((count _info_Hangar) > 0) then {
			private _siret_Hangar = _info_Hangar select 2;
			private _siret_Joueur = player getVariable ["isEmployed",""];
			
			// Vérifier si le joueur est membre de l'entreprise
			if (_siret_Joueur isNotEqualTo "" AND {_siret_Hangar isEqualTo _siret_Joueur}) then {
				private _batiments_Entreprise = nearestObjects [_obj, ["Land_ALF_Entreprise"], 150];
				
				private _batiment_Entreprise = objNull;
				{
					private _siret_Ent = (_x getVariable ["business",["","",""]]) select 2;
					if (_siret_Ent isEqualTo _siret_Hangar) exitWith {
						_batiment_Entreprise = _x;
					};
				} forEach _batiments_Entreprise;
				
				if (!isNull _batiment_Entreprise) then {
					systemChat "[DEBUG] Interaction_Base: Hangar entreprise trouvé - Appel Interaction_Batiments";
					[tolowerANSI typeof _obj] spawn MRPV2_fnc_Interaction_Batiments;
					TRUE
				} else {
					systemChat "[DEBUG] Interaction_Base: Hangar avec business mais pas d'entreprise trouvée - Continue vers House_F";
					FALSE
				};
			} else {
				systemChat "[DEBUG] Interaction_Base: Hangar avec business mais joueur pas membre - Continue vers House_F";
				FALSE
			};
		} else {
			systemChat "[DEBUG] Interaction_Base: Hangar sans business - Continue vers House_F";
			FALSE
		};
	} else {
		FALSE
	};
};
if (_resultat_Hangar) exitWith {TRUE};

// Vérification supplémentaire pour les entreprises basée sur typeOf (avant House_F)
if ((tolowerANSI typeof _obj) isEqualTo tolowerANSI "Land_ALF_Entreprise") exitWith {
	systemChat "[DEBUG] Interaction_Base: Détection par TYPEOF (Land_ALF_Entreprise)";
	[tolowerANSI typeof _obj] spawn MRPV2_fnc_Interaction_Batiments;TRUE
};
if ((tolowerANSI typeof _obj) isEqualTo tolowerANSI "Land_MRP_Concessionnaire") exitWith {
	systemChat "[DEBUG] Interaction_Base: Détection par TYPEOF (Land_MRP_Concessionnaire)";
	[tolowerANSI typeof _obj] spawn MRPV2_fnc_Interaction_Batiments;TRUE
};

// Interaction Maison joueur DOIT TOUJOUR ETRE EN DERNIER !
if (_obj isKindOf "House_F") exitWith {
	systemChat format ["[DEBUG] Interaction_Base: Détection House_F pour %1 - Appel Interaction_Maison (V2)", typeof _obj];
	[_obj] spawn MRPV2_fnc_Interaction_Maison;
	TRUE
};



// Interaction pompe ravitaillement voiture
// if (tolowerANSI typeof _obj in tolowerANSI "Land_ALF_radar_m") exitWith {["Land_ALF_radar_m"] spawn MRPV2_fnc_Interaction_Objets;};

FALSE
// };

*/




// MRPV2_fnc_Interaction_base = {
private _obj = param [0,objnull];

if (!isNil "ALF_Mobiliers_Objects_Data" AND {((getModelInfo _obj) # 1) in ALF_Mobiliers_Objects_Data}) exitWith {[_obj] spawn ALF_fnc_mobilierMenu;TRUE};
// if (_obj distance player > 5) exitWith {FALSE};

private _info_Modele = tolowerANSI ((getModelInfo _obj) # 0);

// Interaction derick pétrole baril vide vers baril plein
if (tolowerANSI "derrick" in _info_Modele) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Derrick;TRUE};

// Interaction scanner hopital
if (tolowerANSI "alf_irm" in _info_Modele) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Scanner_IRM;TRUE};

// Interaction Fonte
if (tolowerANSI "fonte" in _info_Modele) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Fonte;TRUE};

// Interaction PNJ, a des variables associées
if (tolowerANSI "MRPV2_PNJ" in (tolowerANSI str _obj)) exitWith {[_obj] spawn MRPV2_fnc_Interaction_PNJ;TRUE};

// Interaction Charriot Valise Brinks
if (tolowerANSI "MRPV2_Valise_Argent" in (tolowerANSI str _obj)) exitWith {[] spawn MRPV2_fnc_Interaction_Objets_BRINKS;TRUE};

// Interaction Joueur
if (isplayer _obj AND {crew _obj isequalto [_obj]}) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Joueurs;TRUE};

// Interaction s’asseoir sur mobilier
private _liste_Mobiliers = ["officechair_01_f","alf_g_chaise_bois","alf_chaise_3","alf_g_chaise"];
if (_liste_Mobiliers select {_x in _info_Modele} isnotequalto []) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

//poubelle
private _poubelles = ["wheeliebin"];
if (_poubelles select {_x in _info_Modele} isnotequalto []) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction ecran prefecture
if (tolowerANSI "pcset_01_screen_f" in _info_Modele) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction bureau 1
if (tolowerANSI "bureau1" in _info_Modele) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction bureau 2
if (tolowerANSI "mrp_bureau" in _info_Modele) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction Tailleuse Diamant
if (tolowerANSI "tailleuse" in _info_Modele) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction Transformation planche
if (tolowerANSI "table_bois" in _info_Modele) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction Transformation banane
if (tolowerANSI "mixeur" in _info_Modele) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction Transformation
if (tolowerANSI "workbench" in _info_Modele) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction Transformation diamant
if (tolowerANSI "milling" in _info_Modele) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction sechage
if (tolowerANSI "secheurTabac" in _info_Modele) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction confection Cigarette/Cigare
if (tolowerANSI "cigcigare" in _info_Modele) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction Transformation Lingot
if (tolowerANSI "furnace" in _info_Modele) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction Transformation sushi
if (tolowerANSI "fedex" in _info_Modele) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction Transformation bouteille
if (tolowerANSI "embouteillage" in _info_Modele) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction Transformation bouteille
if (tolowerANSI "conditionnement" in _info_Modele) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction Transformation Pressage
if (tolowerANSI "pressoir" in _info_Modele) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction Fermentation
if (tolowerANSI "barrel" in _info_Modele) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction Fermentation
if (tolowerANSI "recharge" in _info_Modele) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction Objet DIR sur les voies
if (tolowerANSI "tyre_f" in _info_Modele AND b_18) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction projecteurs portables
if (typeOf _obj in ["Land_PortableLight_single_F","Land_PortableLight_double_F"]) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction barrière
if (typeOf _obj isEqualTo "ALF_Barricades") exitWith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction RecupGénérateur
if (tolowerANSI "portable_generator_f" in _info_Modele) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};
if (tolowerANSI "powergenerator_f" in _info_Modele) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction Brancard (ALF_Brancard_P et VEH_MRP_Brancard_Vsav)
if (typeOf _obj in ["ALF_Brancard_P", "VEH_MRP_Brancard_Vsav"]) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction Table de Blackjack
if (typeOf _obj isEqualTo "ALF_TableBlackJack") exitWith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction Concentrateur traitement pétrole
if (tolowerANSI "concentrateur" in _info_Modele) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction Casier
if (tolowerANSI "casier" in _info_Modele) exitwith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction Machine à  sous
if (tolowerANSI "alf_slotmachine" in _info_Modele) exitwith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction Malette
if (tolowerANSI "suitcase_f" in _info_Modele) exitwith {[_obj] spawn MRPV2_fnc_Interaction_Objets;TRUE};

// Interaction avec citerne de station essence
if (tolowerANSI "plp_up_propanetanka" in _info_Modele) exitWith {[_obj] spawn MRPV2_fnc_Interaction_Citerne_Station_Essence;TRUE};

// Interaction pompe ravitaillement voiture
if (tolowerANSI "alf_pompe" in _info_Modele) exitWith {[tolowerANSI typeof _obj] spawn MRPV2_fnc_Interaction_Batiments;TRUE};

// Interaction Banque Credit mutuel
if (tolowerANSI "alf_crem" in _info_Modele) exitWith {[tolowerANSI typeof _obj] spawn MRPV2_fnc_Interaction_Batiments;TRUE};

// Interaction Dab
if (tolowerANSI "alf_atm" in _info_Modele) exitWith {[tolowerANSI typeof _obj] spawn MRPV2_fnc_Interaction_Batiments;TRUE};

if (tolowerANSI "alf_trafo" in _info_Modele) exitWith {[tolowerANSI typeof _obj] spawn MRPV2_fnc_Interaction_Batiments;TRUE};

// Interaction trash - désactivé (appel incorrect à Incendie_FX)
// if (tolowerANSI "Land_GarbageBin_02_F" in _info_Modele) exitWith {[tolowerANSI typeof _obj] spawn ALF_fnc_interactions_player_to_trash;TRUE};

// Interaction Ent
if (tolowerANSI "alf_entreprise" in _info_Modele) exitWith {
	[tolowerANSI typeof _obj] spawn MRPV2_fnc_Interaction_Batiments;TRUE
};

// Interaction NightClub
if (tolowerANSI "Land_ALF_NightClub" in _info_Modele) exitWith {};

// Interaction Ent Spéciale Concessionnaire
if (tolowerANSI "mrp_concessionnaire" in _info_Modele) exitWith {[tolowerANSI typeof _obj] spawn MRPV2_fnc_Interaction_Batiments;TRUE};

// Interaction Batiment CHien Cynophile
if (tolowerANSI "touristshelter_01_f" in _info_Modele) exitWith {[tolowerANSI typeof _obj] spawn MRPV2_fnc_Interaction_Batiments;TRUE};

// Interaction niche Chien Cynophile
if (tolowerANSI "plp_up_dogkennellight" in _info_Modele) exitWith {[_info_Modele] spawn MRPV2_fnc_Interaction_Batiments;TRUE};

// Interaction Hangar Entreprise (vérifier avant les maisons car les hangars sont aussi des House_F)
private _typeObj = tolowerANSI (typeof _obj);
private _resultat_Hangar = [_typeObj, _obj] call {
	params ["_typeObj", "_obj"];
	if (_typeObj in [tolowerANSI "Land_i_Shed_Ind_F", tolowerANSI "Land_SM_01_shed_F", tolowerANSI "Land_Hangar2", tolowerANSI "Land_entreprise1"]) then {
		private _info_Hangar = _obj getVariable ["business",[]];
		
		// Si le hangar a une variable business, vérifier si c'est un hangar entreprise
		if ((count _info_Hangar) > 0) then {
			private _siret_Hangar = _info_Hangar select 2;
			private _siret_Joueur = player getVariable ["isEmployed",""];
			
			// Vérifier si le joueur est membre de l'entreprise
			if (_siret_Joueur isNotEqualTo "" AND {_siret_Hangar isEqualTo _siret_Joueur}) then {
				private _batiments_Entreprise = nearestObjects [_obj, ["Land_ALF_Entreprise"], 150];
				
				private _batiment_Entreprise = objNull;
				{
					private _siret_Ent = (_x getVariable ["business",["","",""]]) select 2;
					if (_siret_Ent isEqualTo _siret_Hangar) exitWith {
						_batiment_Entreprise = _x;
					};
				} forEach _batiments_Entreprise;
				
				if (!isNull _batiment_Entreprise) then {
					[tolowerANSI typeof _obj] spawn MRPV2_fnc_Interaction_Batiments;
					TRUE
				} else {
					FALSE
				};
			} else {
				FALSE
			};
		} else {
			FALSE
		};
	} else {
		FALSE
	};
};
if (_resultat_Hangar) exitWith {TRUE};

// Vérification supplémentaire pour les entreprises basée sur typeOf (avant House_F)
if ((tolowerANSI typeof _obj) isEqualTo tolowerANSI "Land_ALF_Entreprise") exitWith {
	[tolowerANSI typeof _obj] spawn MRPV2_fnc_Interaction_Batiments;TRUE
};
if ((tolowerANSI typeof _obj) isEqualTo tolowerANSI "Land_MRP_Concessionnaire") exitWith {
	[tolowerANSI typeof _obj] spawn MRPV2_fnc_Interaction_Batiments;TRUE
};

// TEMPORAIRE — distributeur désactivé
// // Interaction distributeur automatique (boissons / snacks)
// if ([_obj] call ALF_fnc_distrib_isMachine) exitWith {
// 	[_obj] spawn MRPV2_fnc_Interaction_Distributeur;
// 	TRUE
// };

// Pupitre tutoriel (variable Eden MRPV2_TUTO — avant House_F)
if (toLowerANSI "MRPV2_TUTO" in (toLowerANSI str _obj)) exitWith {
	[_obj] spawn MRPV2_fnc_Interaction_Tuto;
	TRUE
};

// Bornes shop illegal (variables Eden — avant House_F)
if (toLowerANSI "MRPV2_Shop_Delinquant" in (toLowerANSI str _obj)) exitWith {
	[_obj, "mag_delinquant", "Magasin delinquant", "Magasin reserve aux delinquants"] spawn MRPV2_fnc_Interaction_ShopIllegal;
	TRUE
};
if (toLowerANSI "MRPV2_Shop_Criminel" in (toLowerANSI str _obj)) exitWith {
	[_obj, "mag_criminel", "Magasin criminel", "Magasin reserve aux criminels"] spawn MRPV2_fnc_Interaction_ShopIllegal;
	TRUE
};

// Interaction Maison joueur DOIT TOUJOUR ETRE EN DERNIER !
if (_obj isKindOf "House_F") exitWith {
	[_obj] spawn MRPV2_fnc_Interaction_Maison;
	TRUE
};



// Interaction pompe ravitaillement voiture
// if (tolowerANSI typeof _obj in tolowerANSI "Land_ALF_radar_m") exitWith {["Land_ALF_radar_m"] spawn MRPV2_fnc_Interaction_Objets;};

FALSE
// };
