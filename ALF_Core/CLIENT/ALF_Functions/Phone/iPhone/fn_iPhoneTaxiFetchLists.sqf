/*
	Listes taxi (en ligne + appelables) — un seul remoteExec serveur, cache 5 s.
	Retour : [[joueur, numero, nom], ...] en ligne, idem appelables (sans soi).
*/
if (!hasInterface) exitWith { [[], []] };

private _cache = missionNamespace getVariable ["ALF_iPhone_TaxiListsCache", []];
if (
	_cache isEqualType [] && { count _cache >= 3 } &&
	{ (_cache # 0) isEqualTo player } &&
	{ (time - (_cache # 1)) < 5 }
) exitWith {
	_cache # 2
};

private _data = [player, true, true] remoteExecCall ["ALF_Server_fnc_iPhoneTaxiGetAvailable", 2];

if (
	isNil "_data" || { !(_data isEqualType []) } || { count _data < 2 } ||
	{ !((_data # 0) isEqualType []) } || { !((_data # 1) isEqualType []) }
) then {
	_data = [[], []];
};

if ((_data # 0) isEqualTo [] && { (_data # 1) isEqualTo [] }) then {
	private _local = allPlayers select {
		alive _x &&
		{ _x getVariable ["MRP_Taxi_EnService", false] }
	};
	_data = [
		_local apply {
			private _num = _x getVariable ["phoneNumber", ""];
			if (_num isEqualTo "" && { _x isEqualTo player }) then { _num = ALF_Phone_Number; };
			[_x, _num, name _x]
		},
		(_local select { !(_x isEqualTo player) }) apply {
			[_x, _x getVariable ["phoneNumber", ""], name _x]
		}
	];
};

missionNamespace setVariable ["ALF_iPhone_TaxiListsCache", [player, time, _data]];
_data
