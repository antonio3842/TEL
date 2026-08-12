#include "\ALF_Client\script_macros.hpp"
/*
	File: fn_adnHouse.sqf
	Author: ALF Team
	Description: Recherche d'ADN sur une maison cambriolée
*/
private["_house"];
_house = _this select 0;
if(isNil "_house" || {isNull _house}) exitWith {};

// Vérifier si le joueur a la licence TIC
if(!license_TIC) exitWith {
	["ADN", "Vous devez avoir la licence TIC pour effectuer une recherche d'ADN.", "warning"] spawn ALF_fnc_doMsg;
};

// Vérifier si le joueur a la Malette_TIC
if(!("Malette_TIC" in (magazines player))) exitWith {
	["ADN", "Vous devez avoir une Malette TIC pour effectuer une recherche d'ADN.", "warning"] spawn ALF_fnc_doMsg;
};

life_action_inUse = true;
private _displayName = getText(configFile >> "CfgVehicles" >> (typeOf _house) >> "displayName");
private _upp = format["Recherche ADN: %1",_displayName];

disableSerialization;
5 cutRsc ["life_progress","PLAIN"];
private _ui = uiNameSpace getVariable "life_progress";
private _progress = _ui displayCtrl 38201;
private _pgText = _ui displayCtrl 38202;
_pgText ctrlSetText format["%2 (1%1)...","%",_upp];
_progress progressSetPosition 0.01;
private _cP = 0.01;

for "_i" from 0 to 1 step 0 do {
	if(animationState player != "AinvPknlMstpSnonWnonDnon_medic_1") then {
		player switchMove "AinvPknlMstpSnonWnonDnon_medic_1";
		player playMoveNow "AinvPknlMstpSnonWnonDnon_medic_1";
	};
	sleep 0.3;
	_cP = _cP + 0.01;
	_progress progressSetPosition _cP;
	_pgText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_upp];
	if(_cP >= 1) exitWith {};
	if(!alive player) exitWith {};
	if(life_interrupted) exitWith {};
	if(life_istazed) exitWith {};
};
life_action_inUse = false;
if(!alive player) exitWith {};
if(life_interrupted) exitWith {life_interrupted = false; ["INFO", "Action annulée.", "danger"] spawn ALF_fnc_doMsg;};
if(life_istazed) exitWith {};
5 cutText ["","PLAIN"];
player playActionNow "stop";
player switchMove "";

// Rechercher l'ADN sur la maison elle-même
private _houseData = _house getVariable ["ilyadeladn",[]];
private _allAdnData = [];

// Si la maison a de l'ADN, l'ajouter
if(count _houseData > 0) then {
	_allAdnData = _allAdnData + _houseData;
};

// Rechercher l'ADN dans les mobiliers de la maison
private _mobiliers = _house getVariable ["mobiliers", []];
if(count _mobiliers > 0) then {
	{
		private _mobilierData = _x getVariable ["ilyadeladn",[]];
		if(count _mobilierData > 0) then {
			_allAdnData = _allAdnData + _mobilierData;
		};
	} forEach _mobiliers;
};

// Vérifier si on a trouvé de l'ADN
if(count _allAdnData isEqualTo 0) then {
	["ADN", "Il n'y a pas de traces d'ADN suspectes sur cette maison.", "success"] spawn ALF_fnc_doMsg;
} else {
	// Supprimer les doublons
	private _uniqueAdn = [];
	{
		if(!(_x in _uniqueAdn)) then {
			_uniqueAdn pushBack _x;
		};
	} forEach _allAdnData;
	
	private _dice = random(100);
	if(_dice <= 90) then {
		["ADN", format["Vous avez trouvé des traces d'ADN suspectes. %1 trace(s) unique(s) détectée(s).", count _uniqueAdn], "success"] spawn ALF_fnc_doMsg;
		sleep 1;
		hint format["Traces ADN trouvées:\n%1", _uniqueAdn];
	} else {
		if(_dice > 90 && {_dice < 95}) then {
			["ADN", "Il n'y a pas de traces d'ADN exploitables.", "success"] spawn ALF_fnc_doMsg;
		} else {
			if(_dice >= 95) then {
				["ADN", "Il y avait bien quelque chose, mais vous avez sans doute effacé toutes les traces d'ADN. Faites plus attention !", "warning"] spawn ALF_fnc_doMsg;
				// Effacer l'ADN de la maison et des mobiliers
				_house setVariable ["ilyadeladn",[],true];
				{
					_x setVariable ["ilyadeladn",[],true];
				} forEach _mobiliers;
			};
		};
	};
};

