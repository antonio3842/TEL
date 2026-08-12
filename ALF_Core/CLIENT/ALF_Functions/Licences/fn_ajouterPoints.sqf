/*
	File: fn_ajouterPoints.sqf
	Author: ALF Team
*/

private["_val","_u","_nbPoints"];
_u = _this select 0;
_val = ctrlText 2752;
_nbPoints = parseNumber _val;

if(isNull _u) exitWith {};
if(!([_val] call TON_fnc_isnumber)) exitWith {["ERREUR", "Veuillez entrer un nombre valide.", "danger", false] spawn ALF_fnc_doMsg;};
if(_nbPoints <= 0) exitWith {["ERREUR", "Le nombre de points doit être supérieur à 0.", "danger", false] spawn ALF_fnc_doMsg;};
if(_nbPoints > 12) exitWith {["ERREUR", "Vous ne pouvez pas ajouter plus de 12 points.", "danger", false] spawn ALF_fnc_doMsg;};

[4, _nbPoints] remoteExecCall ["ALF_fnc_driver", _u];
closeDialog 0;

