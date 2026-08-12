/*
	File: fn_updateMobilierInv.sqf
	Author: ALF TEAM
*/
params [
	["_obj",objNull,[objNull]]
];
if(isNull _obj) exitWith {};

private _id = (_obj getVariable ["mobilier_data",["",-1,"",objNull,"",false]]) select 1;
if(_id isEqualTo -1) exitWith {};

// Protection contre les sauvegardes multiples simultanées (anti-duplication)
private _saveKey = format["ALF_Mobilier_Save_%1",_id];
if !(isNil {missionNamespace getVariable _saveKey}) exitWith {
	diag_log format["[ALF] fn_updateMobilierInv - Sauvegarde déjà en cours pour mobilier ID %1, ignorée",_id];
};
missionNamespace setVariable [_saveKey, true];

// Récupérer la variable gear actuelle (doit être la dernière version synchronisée)
private _gear = +(_obj getVariable ["gear",[]]);

// S'assurer que _gear est bien un array
if !(_gear isEqualType []) then {
	_gear = [];
	diag_log format["[ALF] ERREUR: fn_updateMobilierInv - gear n'est pas un array pour meuble ID %1",_id];
};

// Filtrer les entrées vides et traiter les items valides
// IMPORTANT: Traiter et nettoyer le gear AVANT de le sauvegarder
private _processedGear = [];
{
	// Ignorer les entrées invalides
	if (_x isEqualType "") then {
		if (_x isEqualTo "") then {continue};
	};
	
	// Traiter les métadonnées de l'item
	private _arrayRet = [_x, false] call ALFTools_Server_MD_T_fnc_packData;
	if (_arrayRet isEqualTo "" || _arrayRet isEqualTo -1) then {
		continue; // Ignorer les items invalides
	};
	
	// Ajouter l'item traité (on garde les répétitions car c'est normal pour avoir plusieurs exemplaires)
	_processedGear pushBack _arrayRet;
} forEach _gear;

// Le gear traité est maintenant propre (sans doublons invalides, mais avec répétitions valides)
_gear = _processedGear;

// Mettre à jour la variable sur l'objet pour refléter le gear nettoyé
_obj setVariable ["gear", _gear, true];

private _newGear = [_gear] call ALF_Server_fnc_mresArray;

// Sauvegarder dans la base de données
[format["UPDATE mobiliers SET gear='%2' WHERE id='%1'",_id,_newGear],1] call ALF_Server_fnc_asyncCall;

// Libérer la protection après un court délai
[_saveKey] spawn {
	params ["_saveKey"];
	sleep 0.5;
	missionNamespace setVariable [_saveKey, nil];
};
