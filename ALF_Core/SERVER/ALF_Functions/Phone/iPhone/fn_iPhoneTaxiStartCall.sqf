/*
	Lance un appel taxi côté serveur.
	[_caller, _anonyme, _playerNumber] → [succès, numéro, nom chauffeur]
*/
params [
	["_caller", objNull, [objNull]],
	["_anonyme", false, [false]],
	["_playerNumber", "", [""]]
];

if (isNull _caller) exitWith {[false, "", ""]};

private _fnc_normPhone = {
	params ["_n"];
	if (!(_n isEqualType "")) then { _n = str _n; };
	_n regexReplace [" ", ""]
};

_playerNumber = [_playerNumber] call _fnc_normPhone;
if (_playerNumber isEqualTo "") then {
	_playerNumber = [_caller getVariable ["phoneNumber", ""]] call _fnc_normPhone;
};
if (_playerNumber isEqualTo "") exitWith {[false, "", ""]};

private _etats_Occupe = [
	"Appel en cours",
	"Tentative appel expéditeur",
	"Tentative appel destinataire",
	"Appel CA en cours"
];

private _taxis = allPlayers select {
	alive _x &&
	{ _x != _caller } &&
	{ _x getVariable ["MRP_Taxi_EnService", false] } &&
	{ ([_x getVariable ["phoneNumber", ""]] call _fnc_normPhone) != "" } &&
	{ (_x getVariable ["call_info", 0]) isEqualTo 0 } &&
	{ !((_x getVariable ["MRP_Appel_Etat", ""]) in _etats_Occupe) }
};

if (_taxis isEqualTo []) exitWith {[false, "", ""]};

private _callerPos = getPosATL _caller;
private _cible = _taxis # 0;
private _bestDist = _callerPos distance (getPosATL _cible);
{
	private _d = _callerPos distance (getPosATL _x);
	if (_d < _bestDist) then {
		_bestDist = _d;
		_cible = _x;
	};
} forEach _taxis;
private _cibleNumber = [_cible getVariable ["phoneNumber", ""]] call _fnc_normPhone;
if (_cibleNumber isEqualTo "") exitWith {[false, "", ""]};

private _cibleNom = name _cible;

[_caller] remoteExec ["ALF_fnc_taxi_notifyIncomingCall", _cible];

[_anonyme, _playerNumber, _cibleNumber, _caller, _cible] call ALF_Server_fnc_callSystem;

[true, _cibleNumber, _cibleNom]
