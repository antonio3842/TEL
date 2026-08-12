// MRPV2_fnc_Interaction_PNJ = {
private _objCurseur = tolowerANSI str cursorObject;
if !(tolowerANSI "MRPV2_PNJ" in _objCurseur) exitwith {};
if (cursorObject distance player > 4) exitwith {};

life_pInact_curObject = cursorObject;
private _liste_Actions = createhashmap;

[] call 
{
	// Gendarmerie
	if (tolowerANSI "MRPV2_PNJ_GN" in _objCurseur) exitwith {_liste_Actions = [] call MRPV2_fnc_Interaction_PNJ_GN; _liste_Actions};
	// PM
	if (tolowerANSI "MRPV2_PNJ_PM" in _objCurseur) exitwith {_liste_Actions = [] call MRPV2_fnc_Interaction_PNJ_PM; _liste_Actions};
	// Pompierie
	if (tolowerANSI "MRPV2_PNJ_SP" in _objCurseur) exitwith {_liste_Actions = [] call MRPV2_fnc_Interaction_PNJ_SP_Hopital; _liste_Actions};
	// Concessionaire
	if (tolowerANSI "MRPV2_PNJ_Concessionnaire" in _objCurseur) exitwith {_liste_Actions = [] call MRPV2_fnc_Interaction_PNJ_Concessionnaire; _liste_Actions};
	// Vente et achat divers
	if (tolowerANSI "MRPV2_PNJ_Coop" in _objCurseur OR {tolowerANSI "MRPV2_PNJ_Comm" in _objCurseur}) then {
		_liste_Actions = [] call MRPV2_fnc_Interaction_PNJ_Cooperative;
		// Fusionner avec les actions de Divers pour permettre le braquage
		private _liste_Actions_Divers = [] call MRPV2_fnc_Interaction_PNJ_Divers;
		{
			private _key = _x;
			private _actions_Divers = _liste_Actions_Divers getOrDefault [_key, []];
			private _actions_Coop = _liste_Actions getOrDefault [_key, []];
			_liste_Actions set [_key, _actions_Coop + _actions_Divers];
		} forEach (keys _liste_Actions_Divers);
	};
	// Crime
	if (tolowerANSI "MRPV2_PNJ_CRIME" in _objCurseur) exitwith {_liste_Actions = [] call MRPV2_fnc_Interaction_PNJ_Crime; _liste_Actions};
	// Garages
	if (tolowerANSI "MRPV2_PNJ_Garage" in _objCurseur) exitwith {_liste_Actions = [] call MRPV2_fnc_Interaction_PNJ_Garages; _liste_Actions};
	// France Travail (variable éditeur sans "Emploi" — licences métiers via Divers)
	if (toLowerANSI "MRPV2_PNJ_France_Travail" in _objCurseur || {toLowerANSI "MRPV2_PNJ_Emploi_France_Travail" in _objCurseur}) exitwith {
		_liste_Actions = [] call MRPV2_fnc_Interaction_PNJ_Divers;
		_liste_Actions
	};
	// Emplois public
	if (tolowerANSI "MRPV2_PNJ_Emploi" in _objCurseur) exitwith {_liste_Actions = [] call MRPV2_fnc_Interaction_PNJ_Emplois; _liste_Actions};
	// Magasin Entreprise Joueur
	if (tolowerANSI "MRPV2_PNJ_Ent_Joueur" in _objCurseur) exitwith {_liste_Actions = [] call MRPV2_fnc_Interaction_PNJ_Entreprise_Joueur; _liste_Actions};
	// Divers (a toujours laisser à la fin de la liste) !

	// Si aucune action n'a été définie précédemment, utiliser Divers
	if (_liste_Actions isEqualTo createHashMap) then {
		_liste_Actions = [] call MRPV2_fnc_Interaction_PNJ_Divers;
	};
	_liste_Actions
};

[_liste_Actions] call MRPV2_fnc_Interaction_Menu_Creation;
// };
// if true exitwith {};

// this addAction["Récupérer l'organe",ALF_fnc_takeOrgane,1,0,false,false,"",'life_medicLevel > 0']; 
// this addAction["Donner l'organe",ALF_fnc_giveOrgane,[this],0,false,false,"",'life_medicLevel > 0 AND {alf_organe isEqualTo 1}'];
// this addAction["Magasin aérien",ALF_fnc_vehicleShopMenu,["civ_heli","civ_heli_2","Aérien"]]; 

// this addAction["Mon garage aérien",  
// {
// 	[getPlayerUID player,"Air",player] remoteExecCall ["ALF_Server_fnc_getVehicles",2]; 
// life_garage_id=37;   
// createDialog "Life_impound_menu";  
//  disableSerialization;  
// ctrlSetText[2802,"Chargement..."];  } ]; 

// this addAction["Ranger mon aérien",ALF_fnc_storeVehicle,[37,"AIR"],0,false,false,"",'!life_garage_store'];