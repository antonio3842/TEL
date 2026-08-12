/*
	File: fn_countDownBracelet.sqf
	Author: ALF Team
	HC3: Boucle bracelet electronique
*/
for "_i" from 0 to 1 step 0 do {
	uiSleep 60;
	private _count = (["SELECT COUNT(*) FROM players WHERE bracelet='1' AND bracelettime > 0",2] call ALF_Server_fnc_asyncCall) select 0;

	if (_count > 0) then {
		["UPDATE players SET bracelettime=(bracelettime - 1) WHERE bracelet='1' AND bracelettime > 0",1] call ALF_Server_fnc_asyncCall;

		private _queryResult = ["SELECT playerid, name FROM players WHERE bracelet='1' AND bracelettime <= 0 AND bracelettime > -10",2,true] call ALF_Server_fnc_asyncCall;

		// Ne pas utiliser exitWith ici car ca sort de la boucle for!
		if (!(_queryResult isEqualTo []) && !(_queryResult isEqualType "")) then {
			{
				private _uid = _x select 0;
				private _name = _x select 1;
				private _unit = playableUnits param [playableUnits findIf {getPlayerUID _x isEqualTo _uid}, objNull];

				if !(isNull _unit) then {
					private _array = missionNamespace getVariable ["ALF_AllBracelets",[]];
					private _index = _array find _unit;
					if (_index > -1) then {
						_array deleteAt _index;
						missionNamespace setVariable ["ALF_AllBracelets",_array,true];
					};
				};

				["Bracelet",format["Le temps de %1 est termine. Il n'a plus de bracelet electronique.",_name]] remoteExec ["ALF_fnc_doCopCall",(playableUnits select {_x getVariable ["CopService",false]})];

				[format["UPDATE players SET bracelet='0', bracelettime='0' WHERE playerid='%1'",_uid],1] call ALF_Server_fnc_asyncCall;
			} forEach _queryResult;
		};
	};
};
