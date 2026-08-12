/*
	File: fn_copHouseMarker.sqf
	Author: ALF NiiRoZz
	Modifié: Gestion sécurisée de house_owner + support b_6 sans propriétaire
*/
params [
	["_h",objNull,[objNull]],
	["_uid","",[""]]
];
if (isNull _h) exitWith {};

// Si _uid n'est pas fourni, essayer de le récupérer depuis la maison
if (_uid isEqualTo "") then {
	private _owner = _h getVariable ["house_owner", []];
	if (_owner isNotEqualTo []) then {
		_uid = _owner select 0;
	};
};

// Identifier les joueurs qui doivent recevoir la notification :
// 1. Le propriétaire de la maison (si _uid n'est pas vide)
// 2. Tous les membres de b_6 (entreprise de sécurité, secteur 6)
private _targetPlayers = [];

// Récupérer tous les membres de b_6 depuis la base de données
private _queryB6 = format["SELECT membres FROM business WHERE active='1' AND secteur='6'"];
private _resultB6 = [_queryB6,2,true] call ALF_Server_fnc_asyncCall;

private _b6Members = [];
if (_resultB6 isNotEqualTo []) then {
	{
		private _membres = _x # 0;
		private _membresArray = [_membres] call ALF_Server_fnc_mresToArray;
		if (_membresArray isEqualType "") then {
			_membresArray = call compile format["%1", _membresArray];
		};
		// _membresArray est de la forme [[name, uid, level], ...]
		if (_membresArray isEqualType []) then {
			{
				if (_x isEqualType [] && {count _x >= 2}) then {
					_b6Members pushBack (_x # 1); // UID du membre
				};
			} forEach _membresArray;
		};
	} forEach _resultB6;
};

// Ajouter le propriétaire s'il existe
if (_uid isNotEqualTo "") then {
	{
		if (getPlayerUID _x isEqualTo _uid) then {
			_targetPlayers pushBack _x;
		};
	} forEach playableUnits;
};

// Ajouter tous les membres de b_6 connectés
{
	private _playerUID = getPlayerUID _x;
	if (_playerUID in _b6Members) then {
		if !(_x in _targetPlayers) then {
			_targetPlayers pushBack _x;
		};
	};
} forEach playableUnits;

// Si aucun joueur cible trouvé, envoyer à tous (filtrage côté client pour b_6)
// Cela garantit que même si la requête DB échoue, b_6 recevra quand même la notification
if (_targetPlayers isEqualTo []) then {
	_targetPlayers = playableUnits;
};

// Envoyer la notification aux joueurs cibles
if (_targetPlayers isNotEqualTo []) then {
	[_h,_uid] remoteExecCall ["ALF_fnc_copHouseMarker",_targetPlayers, false];
};