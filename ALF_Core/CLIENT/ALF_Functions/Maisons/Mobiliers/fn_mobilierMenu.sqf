/*
	File : mobilierMenu.sqf
	Author: ALF Team
	Converted to MRPV2
*/
params[["_mobilier",objNull,[objNull]]];
if(isNull _mobilier) exitWith {};

life_pInact_mobilier = _mobilier;
life_pInact_curObject = _mobilier;

private _name = (getModelInfo _mobilier) select 1;
if(isNil "_name") exitWith {};

ALF_Mobilier_Data = [];
[_mobilier] remoteExecCall ["ALF_Server_fnc_recupMobilierData",2];
private _timeout = diag_tickTime + 5;
waitUntil {count(ALF_Mobilier_Data) isEqualTo 6 OR {diag_tickTime > _timeout}};
if (count(ALF_Mobilier_Data) isNotEqualTo 6) exitWith {};

private _liste_Actions = createHashMap;
private _liste_Sous_Actions = [];

if (ALF_Mobilier_Data isEqualTo [-1,0,0,0,0,0]) exitWith
{
	//CHAISES
	if (!(jesuisassis) AND {(typeOf (_mobilier) isEqualTo "Land_OfficeChair_01_F") OR (_name in ["alf_mobiliers\alf_batterie\alf_batterie.p3d","alf_mobiliers\alf_chaise_2\alf_chaise_5.p3d","alf_mobiliers\alf_chaise_2\alf_chaise_4.p3d","alf_mobiliers\alf_chaise_2\alf_chaise_3.p3d","alf_mobiliers\alf_chaise_2\alf_chaise_2.p3d","alf_mobiliers\alf_chaise_2\alf_chaise_1.p3d","alf_mobiliers\alf_chaise\alf_chaise_5.p3d","alf_mobiliers\alf_chaise\alf_chaise_4.p3d","alf_mobiliers\alf_chaise\alf_chaise_3.p3d","alf_mobiliers\alf_chaise\alf_chaise_2.p3d","alf_mobiliers\alf_chaise\alf_chaise_1.p3d","alf_mobiliers\alf_g_chaise\alf_g_chaise_bois.p3d","a3\structures_f_heli\furniture\officechair_01_f.p3d"])}) then
	{
		_liste_Sous_Actions pushBack ["S'asseoir","S'asseoir sur le mobilier",
		{
			closeDialog 0;
			[life_pInact_mobilier,"action"] call ALF_fnc_sitDown;
		}];
		_liste_Actions set ["",_liste_Sous_Actions];
		[_liste_Actions] call MRPV2_fnc_Interaction_Menu_Creation;
	};

	//CANAPE
	if(!(jesuisassis) AND {_name in ["alf_mobiliers\alf_canap_2\alf_canap_2.p3d","alf_mobiliers\alf_canap_1\alf_canap_5.p3d","alf_mobiliers\alf_canap_1\alf_canap_4.p3d","alf_mobiliers\alf_canap_1\alf_canap_3.p3d","alf_mobiliers\alf_canap_1\alf_canap_1.p3d","alf_mobiliers\alf_canap_1\alf_canap_2.p3d"]}) then
	{
		_liste_Sous_Actions pushBack ["S'assoir à Gauche","S'asseoir à gauche du canapé",
		{
			closeDialog 0;
			[life_pInact_mobilier,"action"] call ALF_fnc_sitDown;
		}];
		_liste_Sous_Actions pushBack ["S'assoir au Milieu","S'asseoir au milieu du canapé",
		{
			closeDialog 0;
			[life_pInact_mobilier,"action2"] call ALF_fnc_sitDown;
		}];
		_liste_Sous_Actions pushBack ["S'assoir à Droite","S'asseoir à droite du canapé",
		{
			closeDialog 0;
			[life_pInact_mobilier,"action3"] call ALF_fnc_sitDown;
		}];
		_liste_Actions set ["",_liste_Sous_Actions];
		[_liste_Actions] call MRPV2_fnc_Interaction_Menu_Creation;
	};
};

ALF_Mobilier_Data params
[
	["_owner","",[""]],
	["_id",-1,[0]],
	["_classname","",[""]],
	["_house",objNull,[objNull]],
	["_safe","",[""]],
	["_locked",false,[false]]
];

if(_owner isEqualTo "" OR {_id isEqualTo -1 OR {_classname isEqualTo "" OR {isNull _house OR {_safe isEqualTo ""}}}}) exitWith {};

private _perced = _mobilier getVariable ["perced",false];

//BTN 1 - Retirer/Détruire le mobilier
private _businessData = _house getVariable["business",[]];
if (count _businessData > 0) then
{
	private _owner2 = _businessData select 0;
	if (_owner2 isEqualTo (getPlayerUID player)) then
	{
		_liste_Sous_Actions pushBack ["Retirer le mobilier","Retirer le mobilier",
		{
			closeDialog 0;
			[life_pInact_mobilier] spawn ALF_fnc_removeMobilier;
		}];
	} else
	{
		if (life_gendarme_service) then
		{
			_liste_Sous_Actions pushBack ["Détruire le mobilier","Détruire le mobilier",
			{
				closeDialog 0;
				[life_pInact_mobilier] spawn ALF_fnc_copRemovemobilier;
			}];
		};
	};
} else
{
	if (_owner isEqualTo (getPlayerUID player)) then
	{
		_liste_Sous_Actions pushBack ["Retirer le mobilier","Retirer le mobilier",
		{
			closeDialog 0;
			[life_pInact_mobilier] spawn ALF_fnc_removeMobilier;
		}];
	} else
	{
		if (life_gendarme_service) then
		{
			_liste_Sous_Actions pushBack ["Détruire le mobilier","Détruire le mobilier",
			{
				closeDialog 0;
				[life_pInact_mobilier] spawn ALF_fnc_copRemovemobilier;
			}];
		};
	};
};

//BTN 2 - Table Weed
if(_name isEqualTo "alf_objects\table_weed\table_weed.p3d" AND {{_x isEqualTo "ALF_Weed"} count (magazines player) >= 5}) then {
	_liste_Sous_Actions pushBack ["Couper OG Kush","Couper OG Kush",
	{
		closeDialog 0;
		[0] spawn ALF_fnc_couperWeed;
	}];
};
if(_name isEqualTo "alf_objects\table_weed\table_weed.p3d" AND {{_x isEqualTo "ALF_Weed_2"} count (magazines player) >= 5}) then {
	_liste_Sous_Actions pushBack ["Couper White Widow","Couper White Widow",
	{
		closeDialog 0;
		[1] spawn ALF_fnc_couperWeed;
	}];
};
if(_name isEqualTo "alf_objects\table_weed\table_weed.p3d" AND {{_x isEqualTo "ALF_Weed_3"} count (magazines player) >= 5}) then {
	_liste_Sous_Actions pushBack ["Couper Amnesia","Couper Amnesia",
	{
		closeDialog 0;
		[2] spawn ALF_fnc_couperWeed;
	}];
};

//Security Cam
if(_name isEqualTo "alf_mobiliers\alf_security\alf_security.p3d" AND {player distance _mobilier < 2} AND {speed player isEqualto 0} AND {"ALF_laptop_unfolded_f" in (magazines player)}) then {
	_liste_Sous_Actions pushBack ["Brancher ASUS Portable GX11","Brancher l'ordinateur portable",
	{
		closeDialog 0;
		[life_pInact_mobilier] spawn ALF_fnc_checkSecurityCam;
	}];
};

//Inventaire (mobiliers avec stockage)
if(_name in ["alf_mobiliers\alf_barrel\barrel.p3d","alf_mobiliers\alf_chest\alf_chest.p3d","alf_mobiliers\alf_tv_2\alf_tv_2.p3d","alf_mobiliers\alf_tv_1\alf_tv_1.p3d","alf_mobiliers\alf_stock_2\alf_stock_2.p3d","alf_mobiliers\alf_stock_1\alf_stock_1.p3d","alf_mobiliers\alf_lit_2\alf_lit_5.p3d","alf_mobiliers\alf_lit_2\alf_lit_4.p3d","alf_mobiliers\alf_lit_2\alf_lit_3.p3d","alf_mobiliers\alf_lit_2\alf_lit_1.p3d","alf_mobiliers\alf_lit_2\alf_lit_2.p3d","alf_mobiliers\alf_lit_1\alf_lit_5.p3d","alf_mobiliers\alf_lit_1\alf_lit_4.p3d","alf_mobiliers\alf_lit_1\alf_lit_3.p3d","alf_mobiliers\alf_lit_1\alf_lit_1.p3d","alf_mobiliers\alf_lit_1\alf_lit_2.p3d","a3\structures_f_heli\items\electronics\fridge_01_f.p3d","alf_items_2019\alf_frigo_basique.p3d","alf_mobiliers\alf_canap_2\alf_canap_2.p3d","alf_mobiliers\alf_canap_1\alf_canap_5.p3d","alf_mobiliers\alf_canap_1\alf_canap_4.p3d","alf_mobiliers\alf_canap_1\alf_canap_3.p3d","alf_mobiliers\alf_canap_1\alf_canap_1.p3d","alf_mobiliers\alf_canap_1\alf_canap_2.p3d","a3\structures_f_heli\items\electronics\fridge_01_f.p3d","alf_mobiliers\alf_frigo\alf_frigo.p3d","alf_items_2019\alf_cavevin.p3d"]) then {
	_liste_Sous_Actions pushBack ["Inventaire","Ouvrir l'inventaire du mobilier",
	{
		closeDialog 0;
		[life_pInact_mobilier] call ALF_fnc_mobilierInv;
	}];
};

//CHAISES
if(!(jesuisassis) AND {_name in ["alf_mobiliers\alf_batterie\alf_batterie.p3d","alf_mobiliers\alf_chaise_2\alf_chaise_5.p3d","alf_mobiliers\alf_chaise_2\alf_chaise_4.p3d","alf_mobiliers\alf_chaise_2\alf_chaise_3.p3d","alf_mobiliers\alf_chaise_2\alf_chaise_2.p3d","alf_mobiliers\alf_chaise_2\alf_chaise_1.p3d","alf_mobiliers\alf_chaise\alf_chaise_5.p3d","alf_mobiliers\alf_chaise\alf_chaise_4.p3d","alf_mobiliers\alf_chaise\alf_chaise_3.p3d","alf_mobiliers\alf_chaise\alf_chaise_2.p3d","alf_mobiliers\alf_chaise\alf_chaise_1.p3d"]}) then {
	_liste_Sous_Actions pushBack ["S'assoir","S'asseoir sur la chaise",
	{
		closeDialog 0;
		[life_pInact_mobilier,"action"] call ALF_fnc_sitDown;
	}];
};

//CANAPE
if(!(jesuisassis) AND {_name in ["alf_mobiliers\alf_canap_2\alf_canap_2.p3d","alf_mobiliers\alf_canap_1\alf_canap_5.p3d","alf_mobiliers\alf_canap_1\alf_canap_4.p3d","alf_mobiliers\alf_canap_1\alf_canap_3.p3d","alf_mobiliers\alf_canap_1\alf_canap_1.p3d","alf_mobiliers\alf_canap_1\alf_canap_2.p3d"]}) then {
	_liste_Sous_Actions pushBack ["S'assoir à Gauche","S'asseoir à gauche du canapé",
	{
		closeDialog 0;
		[life_pInact_mobilier,"action"] call ALF_fnc_sitDown;
	}];
	_liste_Sous_Actions pushBack ["S'assoir au Milieu","S'asseoir au milieu du canapé",
	{
		closeDialog 0;
		[life_pInact_mobilier,"action2"] call ALF_fnc_sitDown;
	}];
	_liste_Sous_Actions pushBack ["S'assoir à Droite","S'asseoir à droite du canapé",
	{
		closeDialog 0;
		[life_pInact_mobilier,"action3"] call ALF_fnc_sitDown;
	}];
};

//COFFRE SECURISE - Entrer code
if(_name isEqualTo "alf_mobiliers\alf_safe_1\alf_safe_1.p3d" AND {!(_safe isEqualTo "0000")}) then {
	_liste_Sous_Actions pushBack ["Entrer Code","Entrer le code du coffre",
	{
		closeDialog 0;
		[life_pInact_mobilier,0] call ALF_fnc_paramSafe;
	}];
};

//COFFRE - Parametrer (proprio)
private _businessData2 = _house getVariable["business",[]];
if (count _businessData2 > 0) then {
	if(_name isEqualTo "alf_mobiliers\alf_safe_1\alf_safe_1.p3d") then {
		private _owner2 = _businessData2 select 0;
		if (_owner2 isEqualTo (getPlayerUID player)) then {
			_liste_Sous_Actions pushBack ["Parametrer","Paramétrer le coffre",
			{
				closeDialog 0;
				[life_pInact_mobilier,1] call ALF_fnc_paramSafe;
			}];
		};
	};
} else {
	if(_name isEqualTo "alf_mobiliers\alf_safe_1\alf_safe_1.p3d" AND {_owner isEqualTo (getPlayerUID player)}) then {
		_liste_Sous_Actions pushBack ["Parametrer","Paramétrer le coffre",
		{
			closeDialog 0;
			[life_pInact_mobilier,1] call ALF_fnc_paramSafe;
		}];
	};
};

//COFFRE PERCE
if(_name isEqualTo "alf_mobiliers\alf_safe_1\alf_safe_1.p3d" AND {_perced}) then {
	_liste_Sous_Actions pushBack ["Inventaire","Ouvrir l'inventaire du coffre",
	{
		closeDialog 0;
		[life_pInact_mobilier] call ALF_fnc_mobilierInv;
	}];
};

//COFFRE - Perceuse (si non percé et avec perceuse)
if(_name isEqualTo "alf_mobiliers\alf_safe_1\alf_safe_1.p3d" AND {!_perced} AND {"ALF_Perceuse_GDM_M" in (magazines player)}) then {
	_liste_Sous_Actions pushBack ["Percer le coffre","Percer le coffre avec la perceuse",
	{
		closeDialog 0;
		['ALF_Perceuse_GDM_M'] call ALF_fnc_poserPerceuse;
	}];
};

//Gendarme - Recueillir ADN
if(life_gendarme_service) then {
	private _hasMaletteTIC = "Malette_TIC" in (magazines player);
	if !(license_TIC AND {!_hasMaletteTIC}) then {
		_liste_Sous_Actions pushBack ["[G] Recueillir ADN","Recueillir l'ADN sur le mobilier",
		{
			closeDialog 0;
			[life_pInact_mobilier] spawn ALF_fnc_adnMobilier;
		}];
	};
};

// Afficher le menu
if (_liste_Sous_Actions isNotEqualTo []) then {
	_liste_Actions set ["",_liste_Sous_Actions];
	[_liste_Actions] call MRPV2_fnc_Interaction_Menu_Creation;
};