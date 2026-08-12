/*
	File: fn_distrib_shopOpen.sqf
	Ouvre le shop distributeur lié à la machine visée (gestion stock).
*/
params [["_machine", objNull, [objNull]]];

if (isNull _machine) exitWith {
	["Distributeur", "Machine invalide.", "warning"] spawn ALF_fnc_doMsg;
};

[_machine] call ALF_fnc_distrib_stockEnsure;
uiNamespace setVariable ["MRP_Distrib_Machine", _machine];
[nil, nil, nil, "distributeur_auto"] call ALF_fnc_weaponShopMenu;
