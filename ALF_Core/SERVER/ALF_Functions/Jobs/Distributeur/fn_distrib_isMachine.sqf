/*
	File: fn_distrib_isMachine.sqf
	Serveur — true si l'objet est un distributeur automatique.
*/
params [["_obj", objNull, [objNull]]];

if (isNull _obj) exitWith { false };

if (toLowerANSI typeOf _obj isEqualTo "nlrp_ice_cold_drinksv2") exitWith { true };

private _info_Modele = toLowerANSI ((getModelInfo _obj) # 0);
"ice_cold_drinks" in _info_Modele
