/*
// MRPV2_fnc_Interaction_Maison = {
private _batiment = param [0,objNull,[objNull]];

if (isNull _batiment) exitWith {};

systemChat format ["[DEBUG] Interaction_Maison: typeOf = %1", typeof _batiment];

life_pInact_curObject = _batiment;

// Récupérer les données de la maison
ALF_House_Data = [];
[_batiment,getposatl _batiment,typeof _batiment] remoteExecCall ["ALF_Server_fnc_recupHouseData",2];
waitUntil {count(ALF_House_Data) >= 2};

private _liste_Actions = createHashMap;

// ACHETER LE BIEN
private _condition_Acheter = ((count(ALF_House_Data) > 0 AND {count(ALF_House_Data # 0) isEqualTo 0}) OR {count(ALF_House_Data) isEqualTo 0}) AND 
	{[typeOf _batiment] call ALF_fnc_houseConfig isNotequalto [] AND
	{_batiment getVariable ['business',[]] isequalto [] AND 
	{((allMapMarkers select {'MRPV2_Zone_Inachetable' in _x}) select {player inArea _x}) isequalto []}}};
	
if (_condition_Acheter) then {
	private _texte = "Acheter le bien";
	private _texte_tooltype = "";
	private _action = 
	{closeDialog 0;
		private _batiment = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
		if (isnil {_batiment} OR {isNull _batiment}) exitwith {};
		[_batiment] spawn ALF_fnc_buyHouse;
	};

	_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
	_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
	_liste_Actions set ["",_liste_Sous_Actions];
};

// ACHETER LE HANGAR ENTREPRISE
private _condition_Acheter_Hangar = ((count(ALF_House_Data) > 0 AND {count(ALF_House_Data # 0) isEqualTo 0}) OR {count(ALF_House_Data) isEqualTo 0}) AND 
	{(typeOf _batiment) in ['Land_i_Shed_Ind_F','Land_SM_01_shed_F'] AND
	{(count(_batiment getVariable ['business',[]])) isEqualTo 0 AND
	{((player getVariable ['isEmployed','']) isNotEqualTo '') AND
	{count(nearestObjects [_batiment, ['Land_ALF_Entreprise'], 150] select {
		private _varBiz = _x getVariable ['business',[]];
		(count _varBiz >= 3) AND {
			((_varBiz select 2) isEqualTo (player getVariable ['isEmployed',''])) AND
			{((_varBiz select 0) isEqualTo (getPlayerUID player))}
		}
	}) > 0}}}};

	
if (_condition_Acheter_Hangar) then {
	private _texte = "Acheter le hangar entreprise";
	private _texte_tooltype = "";
	private _action = 
	{closeDialog 0;
		private _batiment = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
		if (isnil {_batiment} OR {isNull _batiment}) exitwith {};
		[_batiment] spawn ALF_fnc_buyHouseBusiness;
	};

	_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
	_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
	_liste_Actions set ["",_liste_Sous_Actions];
};

// BIEN VENDU
private _condition_Bien_Vendu = (count(ALF_House_Data # 0) isNotEqualTo 0) AND 
	{((ALF_House_Data # 0) # 0) isNotEqualTo (getPlayerUID player)};
	
if (_condition_Bien_Vendu) then {
	private _texte = "Bien vendu";
	private _texte_tooltype = "";
	private _action = {closeDialog 0;};

	_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
	_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
	_liste_Actions set ["",_liste_Sous_Actions];
};

// VENDRE LE BIEN
private _condition_Vendre = (count(ALF_House_Data # 0) isNotEqualTo 0) AND 
	{((ALF_House_Data # 0) # 0) isEqualTo (getPlayerUID player)};
	
if (_condition_Vendre) then {
	private _texte = "Vendre le bien";
	private _texte_tooltype = "";
	private _action = 
	{closeDialog 0;
		private _batiment = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
		if (isnil {_batiment} OR {isNull _batiment}) exitwith {};
		[_batiment] spawn ALF_fnc_sellHouse;
	};

	_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
	_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
	_liste_Actions set ["",_liste_Sous_Actions];
};

// PLACER LE BARIL
private _condition_Baril = (count(ALF_House_Data # 0) isNotEqualTo 0) AND 
	{((ALF_House_Data # 0) # 0) isEqualTo (getPlayerUID player) AND 
	{(typeOf _batiment) in ['Land_ALF_Caravane'] AND 
	{'ALF_Barrel_boite' in (magazines player)}}};
	
if (_condition_Baril) then {
	private _texte = "Placer le baril";
	private _texte_tooltype = "";
	private _action = 
	{closeDialog 0;
		private _batiment = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
		if (isnil {_batiment} OR {isNull _batiment}) exitwith {};
		[_batiment,player] remoteExecCall ['ALF_Server_fnc_poserBaril',2];
	};

	_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
	_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
	_liste_Actions set ["",_liste_Sous_Actions];
};

// ALLUMER/ÉTEINDRE LES LUMIÈRES
private _batiment_Dans_Vehicles = _batiment in life_vehicles;
if (_batiment_Dans_Vehicles) then {
	private _lightSource = _batiment getVariable ['lightSource',objNull];
	if (isNull _lightSource) then {
		private _hasEnergy = [_batiment, true] call ALF_fnc_hasEnergy;
		if (_hasEnergy AND {count(ALF_House_Data # 0) isNotEqualTo 0}) then {
			private _texte = "Allumer les lumières";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				private _batiment = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
				if (isnil {_batiment} OR {isNull _batiment}) exitwith {};
				[_batiment] call ALF_fnc_lightHouseAction;
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions];
		};
	} else {
		if (count(ALF_House_Data # 0) isNotEqualTo 0) then {
			private _texte = "Éteindre les lumières";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				private _batiment = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
				if (isnil {_batiment} OR {isNull _batiment}) exitwith {};
				[_batiment] call ALF_fnc_lightHouseAction;
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions];
		};
	};
};

// BOITE AUX LETTRES
if (_batiment_Dans_Vehicles AND {count(ALF_House_Data # 0) isNotEqualTo 0}) then {
	private _texte = "Boite aux lettres";
	private _texte_tooltype = "";
	private _action = 
	{closeDialog 0;
		private _batiment = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
		if (isnil {_batiment} OR {isNull _batiment}) exitwith {};
		[_batiment] call ALF_fnc_menuMailbox;
	};

	_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
	_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
	_liste_Actions set ["",_liste_Sous_Actions];
};

// GARAGE
if (_batiment_Dans_Vehicles AND {count(ALF_House_Data # 0) isNotEqualTo 0} AND {[['ALF_GARAGES', (typeOf _batiment)]] call ALFTools_Client_Config_fnc_isClass}) then {
	// Accéder au garage
	private _texte = "Accéder au garage";
	private _texte_tooltype = "";
	private _action = 
	{closeDialog 0;
		['vehicles','Car',player] remoteExecCall ['MRPV2_Server_fnc_Vehicule_Garage_Exporter_BDD', 2];
		createDialog 'Life_impound_menu'; 
		disableSerialization; 
		ctrlSetText[2802,'Chargement...'];
	};

	_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
	_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
	_liste_Actions set ["",_liste_Sous_Actions];
	
	// Ranger le véhicule proche
	private _texte2 = "Ranger le véhicule proche";
	private _texte_tooltype2 = "";
	private _action2 = 
	{closeDialog 0;
		['Car','Civil'] call MRPV2_fnc_Vehicule_Garage_Ranger;
	};

	_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
	_liste_Sous_Actions pushback [_texte2,_texte_tooltype2,_action2];
	_liste_Actions set ["",_liste_Sous_Actions];
};

// SONNETTE
if (count(ALF_House_Data # 0) isNotEqualTo 0) then {
	private _uid_Proprio = (ALF_House_Data # 0) # 0;
	private _hasSonnette = (ALF_House_Data # 1) isEqualTo 1;
	
	// Installer une sonnette
	if (_uid_Proprio isEqualTo (getPlayerUID player) AND {!(_hasSonnette)} AND {'ALF_Sonnette4G' in (magazines player)}) then {
		private _texte = "Installer une sonnette";
		private _texte_tooltype = "";
		private _action = 
		{closeDialog 0;
			private _batiment = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
			if (isnil {_batiment} OR {isNull _batiment}) exitwith {};
			[_batiment,player] remoteExecCall ['ALF_Server_fnc_sonnetteHouse',2];
		};

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];
	};
	
	// Sonner
	if (_uid_Proprio isNotEqualTo (getPlayerUID player) AND {_hasSonnette}) then {
		private _texte = "Sonner";
		private _texte_tooltype = "";
		private _action =
		{closeDialog 0;
			private _batiment = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
			if (isNull _batiment) exitWith {};
			[_batiment] remoteExecCall ['ALF_Server_fnc_playSonnetteHouse',2];
		};

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];
	};

	// TOGGLE ALERTE GENDARMERIE (proprio + meuble alarme/camera uniquement)
	if (_uid_Proprio isEqualTo (getPlayerUID player)) then {
		private _hasSecurity = if (count ALF_House_Data > 3) then { ALF_House_Data # 3 } else { 0 };

		if (_hasSecurity isEqualTo 1) then {
			private _alarmGend = if (count ALF_House_Data > 2) then { ALF_House_Data # 2 } else { 0 };
			private _texte = if (_alarmGend isEqualTo 1) then { "Desactiver l'alerte gendarmerie" } else { "Activer l'alerte gendarmerie" };
			private _texte_tooltype = "";
			private _newState = if (_alarmGend isEqualTo 1) then { 0 } else { 1 };
			private _action = compile format [
				"closeDialog 0; private _batiment = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,'GEOM','NONE']) # 0 # 2; if (isnil {_batiment} OR {isNull _batiment}) exitwith {}; [_batiment, player, %1] remoteExecCall ['ALF_Server_fnc_setAlarmGendarmerie', 2];",
				_newState
			];

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions];
		};
	};
};

// ACTIONS GENDARMERIE
if (count(ALF_House_Data # 0) isNotEqualTo 0) then {
	// Vérifier le proprio (Gendarme)
	if (life_gendarme_service) then {
		private _texte = "[G] Vérifier le proprio";
		private _texte_tooltype = "";
		private _action = 
		{closeDialog 0;
			[] call ALF_fnc_copHouseOwner;
		};

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];
	};
	
	// Enfoncer la porte (Pompier)
	if (life_pompier_service) then {
		private _texte = "[P] Enfoncer la porte";
		private _texte_tooltype = "";
		private _action = 
		{closeDialog 0;
			private _batiment = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
			if (isnil {_batiment} OR {isNull _batiment}) exitwith {};
			[_batiment,0] spawn ALF_fnc_copBreakDoor;
		};

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];
	};
	
	// Enfoncer la porte (Gendarme)
	if (life_gendarme_service) then {
		private _texte = "[G] Enfoncer la porte";
		private _texte_tooltype = "";
		private _action = 
		{closeDialog 0;
			private _batiment = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
			if (isnil {_batiment} OR {isNull _batiment}) exitwith {};
			[_batiment,0] spawn ALF_fnc_copBreakDoor;
		};

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];
	};
	
	// Verrouiller le bâtiment (Gendarme)
	if (life_gendarme_service) then {
		private _texte = "[G] Verrouiller le bâtiment";
		private _texte_tooltype = "";
		private _action = 
		{closeDialog 0;
			private _batiment = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
			if (isnil {_batiment} OR {isNull _batiment}) exitwith {};
			[_batiment] spawn ALF_fnc_lockupHouse;
		};

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];
	};
};

// ACTIONS PREF
if (count(ALF_House_Data # 0) isNotEqualTo 0) then {

	if (life_publique >= 1 && b_13) then {
		private _texte = "[PREF] Obtenir l'adresse";
		private _texte_tooltype = "";
		private _action = 
		{closeDialog 0;
			private _batiment = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
			if (isnil {_batiment} OR {isNull _batiment}) exitwith {};
			private _pos = str (getPosATL _batiment);
			copyToClipboard _pos;
			hint format["Voici l'adresse du logement : %1", _pos];
		};

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];
	};
	if (life_publique >= 6 && b_13) then {
		private _texte = "[PREF] Expulser le logement";
		private _texte_tooltype = "";
		private _action = 
		{closeDialog 0;
			private _batiment = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
			if (isnil {_batiment} OR {isNull _batiment}) exitwith {};
			private _uid_Proprio = (ALF_House_Data # 0) # 0;
			[_batiment,_uid_Proprio] spawn ALF_fnc_virerHouse;
		};

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];
	};

};

// VERROUILLER/DÉVERROUILLER LE BÂTIMENT
if (_batiment_Dans_Vehicles) then {
	private _porte_Fermer = _batiment getVariable ['ALF_PorteFermer',FALSE];
	if (_porte_Fermer) then {
		private _texte = "Déverrouiller le bâtiment";
		private _texte_tooltype = "";
		private _action = 
		{closeDialog 0;
			private _batiment = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
			if (isnil {_batiment} OR {isNull _batiment}) exitwith {};
			_batiment setVariable ['ALF_PorteFermer',FALSE,TRUE];
		};

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];
	} else {
		private _texte = "Verrouiller le bâtiment";
		private _texte_tooltype = "";
		private _action = 
		{closeDialog 0;
			private _batiment = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
			if (isnil {_batiment} OR {isNull _batiment}) exitwith {};
			_batiment setVariable ['ALF_PorteFermer',TRUE,TRUE];
		};

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];
	};
};

// ACTIONS ADMIN
if (count(ALF_House_Data # 0) isNotEqualTo 0) then {
	// Vérifier le proprio (Admin)
	if (ALF_AdminLevel > 2 AND {!life_gendarme_service}) then {
		private _texte = "[A] Vérifier le proprio";
		private _texte_tooltype = "";
		private _action = 
		{closeDialog 0;
			[] call ALF_fnc_copHouseOwner;
		};

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];
	};
	
	// Déverrouiller/Verrouiller (Admin)
	private _porte_Fermer_Admin = _batiment getVariable ['ALF_PorteFermer',FALSE];
	if (ALF_AdminLevel > 2) then {
		if (_porte_Fermer_Admin) then {
			private _texte = "[A] Déverrouiller le bâtiment";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				private _batiment = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
				if (isnil {_batiment} OR {isNull _batiment}) exitwith {};
				_batiment setVariable ['ALF_PorteFermer',FALSE,TRUE];
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions];
		} else {
			if ([typeOf _batiment] call ALF_fnc_houseConfig isNotequalto []) then {
				private _texte = "[A] Verrouiller le bâtiment";
				private _texte_tooltype = "";
				private _action = 
				{closeDialog 0;
					private _batiment = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
					if (isnil {_batiment} OR {isNull _batiment}) exitwith {};
					_batiment setVariable ['ALF_PorteFermer',TRUE,TRUE];
				};

				_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
				_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
				_liste_Actions set ["",_liste_Sous_Actions];
			};
		};
	};
};

// DÉPOSER LE COLIS
private _condition_Colis = _batiment getVariable ['LaPoste_Colis',''] isequalto (getplayeruid player) AND 
	{'door' in tolower str ((lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,4],player,objnull,true,1,'GEOM','NONE']) # 0 # 4)};
	
if (_condition_Colis) then {
	private _texte = "Déposer le colis";
	private _texte_tooltype = "";
	private _action = 
	{closeDialog 0;
		['returnColis'] spawn ALF_fnc_laposte_fonctions;
	};

	_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
	_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
	_liste_Actions set ["",_liste_Sous_Actions];
};

[_liste_Actions] call MRPV2_fnc_Interaction_Menu_Creation;
// };

*/




// MRPV2_fnc_Interaction_Maison = {
private _batiment = param [0,objNull,[objNull]];

if (isNull _batiment) exitWith {};

life_pInact_curObject = _batiment;

// Récupérer les données de la maison
ALF_House_Data = [];
[_batiment,getposatl _batiment,typeof _batiment] remoteExecCall ["ALF_Server_fnc_recupHouseData",2];
waitUntil {count(ALF_House_Data) >= 2};

private _liste_Actions = createHashMap;

// ACHETER LE BIEN
private _condition_Acheter = ((count(ALF_House_Data) > 0 AND {count(ALF_House_Data # 0) isEqualTo 0}) OR {count(ALF_House_Data) isEqualTo 0}) AND 
	{[typeOf _batiment] call ALF_fnc_houseConfig isNotequalto [] AND
	{_batiment getVariable ['business',[]] isequalto [] AND 
	{((allMapMarkers select {'MRPV2_Zone_Inachetable' in _x}) select {player inArea _x}) isequalto []}}};
	
if (_condition_Acheter) then {
	private _texte = "Acheter le bien";
	private _texte_tooltype = "";
	private _action = 
	{closeDialog 0;
		private _batiment = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
		if (isnil {_batiment} OR {isNull _batiment}) exitwith {};
		[_batiment] spawn ALF_fnc_buyHouse;
	};

	_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
	_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
	_liste_Actions set ["",_liste_Sous_Actions];
};

// ACHETER LE HANGAR ENTREPRISE
private _condition_Acheter_Hangar = ((count(ALF_House_Data) > 0 AND {count(ALF_House_Data # 0) isEqualTo 0}) OR {count(ALF_House_Data) isEqualTo 0}) AND 
	{(typeOf _batiment) in ['Land_i_Shed_Ind_F','Land_SM_01_shed_F','Land_Hangar2','Land_entreprise1'] AND
	{(count(_batiment getVariable ['business',[]])) isEqualTo 0 AND
	{((player getVariable ['isEmployed','']) isNotEqualTo '') AND
	{count(nearestObjects [_batiment, ['Land_ALF_Entreprise'], 150] select {
		private _varBiz = _x getVariable ['business',[]];
		(count _varBiz >= 3) AND {
			((_varBiz select 2) isEqualTo (player getVariable ['isEmployed',''])) AND
			{((_varBiz select 0) isEqualTo (getPlayerUID player))}
		}
	}) > 0}}}};

	
if (_condition_Acheter_Hangar) then {
	private _texte = "Acheter le hangar entreprise";
	private _texte_tooltype = "";
	private _action = 
	{closeDialog 0;
		private _batiment = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
		if (isnil {_batiment} OR {isNull _batiment}) exitwith {};
		[_batiment] spawn ALF_fnc_buyHouseBusiness;
	};

	_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
	_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
	_liste_Actions set ["",_liste_Sous_Actions];
};

// BIEN VENDU
private _condition_Bien_Vendu = (count(ALF_House_Data # 0) isNotEqualTo 0) AND 
	{((ALF_House_Data # 0) # 0) isNotEqualTo (getPlayerUID player)};
	
if (_condition_Bien_Vendu) then {
	private _texte = "Bien vendu";
	private _texte_tooltype = "";
	private _action = {closeDialog 0;};

	_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
	_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
	_liste_Actions set ["",_liste_Sous_Actions];
};

// VENDRE LE BIEN
private _condition_Vendre = (count(ALF_House_Data # 0) isNotEqualTo 0) AND 
	{((ALF_House_Data # 0) # 0) isEqualTo (getPlayerUID player)};
	
if (_condition_Vendre) then {
	private _texte = "Vendre le bien";
	private _texte_tooltype = "";
	private _action = 
	{closeDialog 0;
		private _batiment = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
		if (isnil {_batiment} OR {isNull _batiment}) exitwith {};
		[_batiment] spawn ALF_fnc_sellHouse;
	};

	_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
	_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
	_liste_Actions set ["",_liste_Sous_Actions];
};

// PLACER LE BARIL
private _condition_Baril = (count(ALF_House_Data # 0) isNotEqualTo 0) AND 
	{((ALF_House_Data # 0) # 0) isEqualTo (getPlayerUID player) AND 
	{(typeOf _batiment) in ['Land_ALF_Caravane'] AND 
	{'ALF_Barrel_boite' in (magazines player)}}};
	
if (_condition_Baril) then {
	private _texte = "Placer le baril";
	private _texte_tooltype = "";
	private _action = 
	{closeDialog 0;
		private _batiment = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
		if (isnil {_batiment} OR {isNull _batiment}) exitwith {};
		[_batiment,player] remoteExecCall ['ALF_Server_fnc_poserBaril',2];
	};

	_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
	_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
	_liste_Actions set ["",_liste_Sous_Actions];
};

// ALLUMER/ÉTEINDRE LES LUMIÈRES
private _batiment_Dans_Vehicles = _batiment in life_vehicles;
if (_batiment_Dans_Vehicles) then {
	private _lightSource = _batiment getVariable ['lightSource',objNull];
	if (isNull _lightSource) then {
		private _hasEnergy = [_batiment, true] call ALF_fnc_hasEnergy;
		if (_hasEnergy AND {count(ALF_House_Data # 0) isNotEqualTo 0}) then {
			private _texte = "Allumer les lumières";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				private _batiment = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
				if (isnil {_batiment} OR {isNull _batiment}) exitwith {};
				[_batiment] call ALF_fnc_lightHouseAction;
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions];
		};
	} else {
		if (count(ALF_House_Data # 0) isNotEqualTo 0) then {
			private _texte = "Éteindre les lumières";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				private _batiment = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
				if (isnil {_batiment} OR {isNull _batiment}) exitwith {};
				[_batiment] call ALF_fnc_lightHouseAction;
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions];
		};
	};
};

// BOITE AUX LETTRES
if (_batiment_Dans_Vehicles AND {count(ALF_House_Data # 0) isNotEqualTo 0}) then {
	private _texte = "Boite aux lettres";
	private _texte_tooltype = "";
	private _action = 
	{closeDialog 0;
		private _batiment = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
		if (isnil {_batiment} OR {isNull _batiment}) exitwith {};
		[_batiment] call ALF_fnc_menuMailbox;
	};

	_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
	_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
	_liste_Actions set ["",_liste_Sous_Actions];
};

// GARAGE
if (_batiment_Dans_Vehicles AND {count(ALF_House_Data # 0) isNotEqualTo 0} AND {[['ALF_GARAGES', (typeOf _batiment)]] call ALFTools_Client_Config_fnc_isClass}) then {
	// Accéder au garage
	private _texte = "Accéder au garage";
	private _texte_tooltype = "";
	private _action = 
	{closeDialog 0;
		['vehicles','Car',player] remoteExecCall ['MRPV2_Server_fnc_Vehicule_Garage_Exporter_BDD', 2];
		createDialog 'Life_impound_menu'; 
		disableSerialization; 
		ctrlSetText[2802,'Chargement...'];
	};

	_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
	_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
	_liste_Actions set ["",_liste_Sous_Actions];
	
	// Ranger le véhicule proche
	private _texte2 = "Ranger le véhicule proche";
	private _texte_tooltype2 = "";
	private _action2 = 
	{closeDialog 0;
		['Car','Civil'] call MRPV2_fnc_Vehicule_Garage_Ranger;
	};

	_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
	_liste_Sous_Actions pushback [_texte2,_texte_tooltype2,_action2];
	_liste_Actions set ["",_liste_Sous_Actions];
};

// SONNETTE
if (count(ALF_House_Data # 0) isNotEqualTo 0) then {
	private _uid_Proprio = (ALF_House_Data # 0) # 0;
	private _hasSonnette = (ALF_House_Data # 1) isEqualTo 1;
	
	// Installer une sonnette
	if (_uid_Proprio isEqualTo (getPlayerUID player) AND {!(_hasSonnette)} AND {'ALF_Sonnette4G' in (magazines player)}) then {
		private _texte = "Installer une sonnette";
		private _texte_tooltype = "";
		private _action = 
		{closeDialog 0;
			private _batiment = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
			if (isnil {_batiment} OR {isNull _batiment}) exitwith {};
			[_batiment,player] remoteExecCall ['ALF_Server_fnc_sonnetteHouse',2];
		};

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];
	};
	
	// Sonner
	if (_uid_Proprio isNotEqualTo (getPlayerUID player) AND {_hasSonnette}) then {
		private _texte = "Sonner";
		private _texte_tooltype = "";
		private _action =
		{closeDialog 0;
			private _batiment = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
			if (isNull _batiment) exitWith {};
			[_batiment] remoteExecCall ['ALF_Server_fnc_playSonnetteHouse',2];
		};

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];
	};

	// TOGGLE ALERTE GENDARMERIE (proprio + meuble alarme/camera uniquement)
	if (_uid_Proprio isEqualTo (getPlayerUID player)) then {
		private _hasSecurity = if (count ALF_House_Data > 3) then { ALF_House_Data # 3 } else { 0 };

		if (_hasSecurity isEqualTo 1) then {
			private _alarmGend = if (count ALF_House_Data > 2) then { ALF_House_Data # 2 } else { 0 };
			private _texte = if (_alarmGend isEqualTo 1) then { "Desactiver l'alerte gendarmerie" } else { "Activer l'alerte gendarmerie" };
			private _texte_tooltype = "";
			private _newState = if (_alarmGend isEqualTo 1) then { 0 } else { 1 };
			private _action = compile format [
				"closeDialog 0; private _batiment = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,'GEOM','NONE']) # 0 # 2; if (isnil {_batiment} OR {isNull _batiment}) exitwith {}; [_batiment, player, %1] remoteExecCall ['ALF_Server_fnc_setAlarmGendarmerie', 2];",
				_newState
			];

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions];
		};
	};
};

// ACTIONS GENDARMERIE
if (count(ALF_House_Data # 0) isNotEqualTo 0) then {
	// Vérifier le proprio (Gendarme)
	if (life_gendarme_service) then {
		private _texte = "[G] Vérifier le proprio";
		private _texte_tooltype = "";
		private _action = 
		{closeDialog 0;
			[] call ALF_fnc_copHouseOwner;
		};

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];
	};
	
	// Enfoncer la porte (Pompier)
	if (life_pompier_service) then {
		private _texte = "[P] Enfoncer la porte";
		private _texte_tooltype = "";
		private _action = 
		{closeDialog 0;
			private _batiment = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
			if (isnil {_batiment} OR {isNull _batiment}) exitwith {};
			[_batiment,0] spawn ALF_fnc_copBreakDoor;
		};

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];
	};
	
	// Enfoncer la porte (Gendarme)
	if (life_gendarme_service) then {
		private _texte = "[G] Enfoncer la porte";
		private _texte_tooltype = "";
		private _action = 
		{closeDialog 0;
			private _batiment = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
			if (isnil {_batiment} OR {isNull _batiment}) exitwith {};
			[_batiment,0] spawn ALF_fnc_copBreakDoor;
		};

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];
	};
	
	// Verrouiller le bâtiment (Gendarme)
	if (life_gendarme_service) then {
		private _texte = "[G] Verrouiller le bâtiment";
		private _texte_tooltype = "";
		private _action = 
		{closeDialog 0;
			private _batiment = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
			if (isnil {_batiment} OR {isNull _batiment}) exitwith {};
			[_batiment] spawn ALF_fnc_lockupHouse;
		};

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];
	};
};

// ACTIONS PREF
if (count(ALF_House_Data # 0) isNotEqualTo 0) then {

	if (life_publique >= 1 && b_13) then {
		private _texte = "[PREF] Obtenir l'adresse";
		private _texte_tooltype = "";
		private _action = 
		{closeDialog 0;
			private _batiment = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
			if (isnil {_batiment} OR {isNull _batiment}) exitwith {};
			private _pos = str (getPosATL _batiment);
			copyToClipboard _pos;
			hint format["Voici l'adresse du logement : %1", _pos];
		};

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];
	};
	if (life_publique >= 6 && b_13) then {
		private _texte = "[PREF] Expulser le logement";
		private _texte_tooltype = "";
		private _action = 
		{closeDialog 0;
			private _batiment = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
			if (isnil {_batiment} OR {isNull _batiment}) exitwith {};
			private _uid_Proprio = (ALF_House_Data # 0) # 0;
			[_batiment,_uid_Proprio] spawn ALF_fnc_virerHouse;
		};

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];
	};

};

// VERROUILLER/DÉVERROUILLER LE BÂTIMENT
if (_batiment_Dans_Vehicles) then {
	private _porte_Fermer = _batiment getVariable ['ALF_PorteFermer',FALSE];
	if (_porte_Fermer) then {
		private _texte = "Déverrouiller le bâtiment";
		private _texte_tooltype = "";
		private _action = 
		{closeDialog 0;
			private _batiment = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
			if (isnil {_batiment} OR {isNull _batiment}) exitwith {};
			_batiment setVariable ['ALF_PorteFermer',FALSE,TRUE];
		};

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];
	} else {
		private _texte = "Verrouiller le bâtiment";
		private _texte_tooltype = "";
		private _action = 
		{closeDialog 0;
			private _batiment = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
			if (isnil {_batiment} OR {isNull _batiment}) exitwith {};
			_batiment setVariable ['ALF_PorteFermer',TRUE,TRUE];
		};

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];
	};
};

// ACTIONS ADMIN
if (count(ALF_House_Data # 0) isNotEqualTo 0) then {
	// Vérifier le proprio (Admin)
	if (ALF_AdminLevel > 2 AND {!life_gendarme_service}) then {
		private _texte = "[A] Vérifier le proprio";
		private _texte_tooltype = "";
		private _action = 
		{closeDialog 0;
			[] call ALF_fnc_copHouseOwner;
		};

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];
	};
	
	// Déverrouiller/Verrouiller (Admin)
	private _porte_Fermer_Admin = _batiment getVariable ['ALF_PorteFermer',FALSE];
	if (ALF_AdminLevel > 2) then {
		if (_porte_Fermer_Admin) then {
			private _texte = "[A] Déverrouiller le bâtiment";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				private _batiment = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
				if (isnil {_batiment} OR {isNull _batiment}) exitwith {};
				_batiment setVariable ['ALF_PorteFermer',FALSE,TRUE];
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions];
		} else {
			if ([typeOf _batiment] call ALF_fnc_houseConfig isNotequalto []) then {
				private _texte = "[A] Verrouiller le bâtiment";
				private _texte_tooltype = "";
				private _action = 
				{closeDialog 0;
					private _batiment = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
					if (isnil {_batiment} OR {isNull _batiment}) exitwith {};
					_batiment setVariable ['ALF_PorteFermer',TRUE,TRUE];
				};

				_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
				_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
				_liste_Actions set ["",_liste_Sous_Actions];
			};
		};
	};
};

// DÉPOSER LE COLIS
private _condition_Colis = _batiment getVariable ['LaPoste_Colis',''] isequalto (getplayeruid player) AND 
	{'door' in tolower str ((lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,4],player,objnull,true,1,'GEOM','NONE']) # 0 # 4)};
	
if (_condition_Colis) then {
	private _texte = "Déposer le colis";
	private _texte_tooltype = "";
	private _action = 
	{closeDialog 0;
		['returnColis'] spawn ALF_fnc_laposte_fonctions;
	};

	_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
	_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
	_liste_Actions set ["",_liste_Sous_Actions];
};

[_liste_Actions] call MRPV2_fnc_Interaction_Menu_Creation;


// GOFAST
private _condition_Colis = _batiment getVariable ['Gofast_Colis',''] isequalto (getplayeruid player) AND 
	{'door' in tolower str ((lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,4],player,objnull,true,1,'GEOM','NONE']) # 0 # 4)};
	
if (_condition_Colis) then {
	private _texte = "Déposer la drogue";
	private _texte_tooltype = "";
	private _action = 
	{closeDialog 0;
		[] spawn ALF_fnc_gofastDonnerDrogue;
	};

	_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
	_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
	_liste_Actions set ["",_liste_Sous_Actions];
};

[_liste_Actions] call MRPV2_fnc_Interaction_Menu_Creation;
// };

