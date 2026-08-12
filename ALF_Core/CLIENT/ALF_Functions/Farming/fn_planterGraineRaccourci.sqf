#include "\ALF_Client\script_macros.hpp"
/*
	File: fn_planterGraineRaccourci.sqf
	Raccourci Shift+G : plante la graine correspondant au champ où se trouve le joueur.
*/

if (life_action_inUse) exitWith {};
if (dialog) exitWith {};

private _delaiPlantation = 0.3;
private _dernierPlantage = missionNamespace getVariable ["life_action_delay_plantation", 0];
if ((time - _dernierPlantage) < _delaiPlantation) exitWith {
	["Plantation", "Vous appuyez trop vite.", "warning", false] spawn ALF_fnc_doMsg;
};

private _zones = [
	["champ_mais", 100, "ALF_Graine_M", "ALF_fnc_planterMais", "maïs"],
	["champ_tabac", 50, "ALF_Graine_T", "ALF_fnc_planterTabac", "tabac"],
	["champ_canne", 90, "Graine_canne_sucre", "ALF_fnc_planterCanneSucre", "canne à sucre"]
];

private _posJoueur = getPosATL player;
private _champsProches = _zones select {
	player distance (getMarkerPos (_x # 0)) <= (_x # 1)
};

if (_champsProches isEqualTo []) exitWith {
	["Plantation", "Tu n'es pas dans un champ de plantation.", "warning", false] spawn ALF_fnc_doMsg;
};

private _zone = _champsProches # 0;
if (count _champsProches > 1) then {
	_zone = [_champsProches, _posJoueur] call {
		params ["_liste", "_pos"];
		private _meilleur = _liste # 0;
		private _distMin = _pos distance (getMarkerPos (_meilleur # 0));
		{
			private _dist = _pos distance (getMarkerPos (_x # 0));
			if (_dist < _distMin) then {
				_distMin = _dist;
				_meilleur = _x;
			};
		} forEach _liste;
		_meilleur
	};
};

_zone params ["_marker", "_rayon", "_item", "_fncPlanter", "_label"];

if (([_item] call ALF_fnc_distrib_countPlayerItem) < 1) exitWith {
	["Plantation", format ["Tu n'as pas de graine de %1 sur toi.", _label], "warning", false] spawn ALF_fnc_doMsg;
};

missionNamespace setVariable ["life_action_delay_plantation", time];

switch (_item) do {
	case "ALF_Graine_M": { [_item] spawn ALF_fnc_planterMais; };
	case "ALF_Graine_T": { [_item] spawn ALF_fnc_planterTabac; };
	case "Graine_canne_sucre": { [_item] spawn ALF_fnc_planterCanneSucre; };
};
