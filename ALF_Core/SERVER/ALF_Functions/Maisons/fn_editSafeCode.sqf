/*
	File: fn_editSafeCode.sqf
	Author: ALF TEAM
*/
params [
	["_obj",objNull,[objNull]],
	["_number","",[""]],
	["_uid","",[""]]
];
if(isNull _obj OR {_number isEqualTo ""}) exitWith {};

// Récupérer l'UID du joueur qui a fait la demande
if (_uid isEqualTo "") then {
	private _player = (allPlayers select {owner _x isEqualTo remoteExecutedOwner}) # 0;
	if (!isNil "_player" && {!isNull _player}) then {
		_uid = getPlayerUID _player;
	};
};

private _var = _obj getVariable ["mobilier_data",["",-1,"",objNull,"",false]];
_var params [
	["_owner","",[""]],
	["_id",-1,[0]],
	["_classname","",[""]],
	["_house",objNull,[objNull]],
	["_safe","",[""]],
	["_perced",false,[false]],
	["_locked",false,[false]]
];
if(_id isEqualTo -1) exitWith {};

// Vérification propriétaire (même logique que deleteDBmobilier)
private _exit = false;
private _businessData = _house getVariable ["business", []];
if (count _businessData > 0) then {
	private _ownerBiz = _businessData # 0;
	if (_uid isNotEqualTo _ownerBiz) then {
		private _ownerHouse = (_house getVariable ["house_owner", [""]]) # 0;
		if (_uid isNotEqualTo _ownerHouse) exitWith { _exit = true; };
	};
} else {
	private _ownerHouse = (_house getVariable ["house_owner", [""]]) # 0;
	if (_uid isNotEqualTo _ownerHouse) exitWith { _exit = true; };
};

if (_exit) exitWith {
	["ERREUR", "Vous n'êtes pas le propriétaire.", "danger"] remoteExec ["ALF_fnc_doMsg", remoteExecutedOwner];
};

_var set[4,_number];
_obj setVariable ["mobilier_data",_var];

[format["UPDATE mobiliers SET code='%2' WHERE id='%1'",_id,_number],1] call ALF_Server_fnc_asyncCall;