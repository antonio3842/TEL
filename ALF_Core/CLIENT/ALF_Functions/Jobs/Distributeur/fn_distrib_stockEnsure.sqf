/*
	File: fn_distrib_stockEnsure.sqf
	Assure que la machine possède un stock chargé depuis la BDD et le retourne.
*/
params [["_machine", objNull, [objNull]]];

if (isNull _machine) exitWith { createHashMap };

if (isNil {_machine getVariable "MRP_Distrib_Stock"}) then {
	if (isServer) then {
		[_machine] call ALF_Server_fnc_distrib_stockLoad;
	} else {
		[_machine] remoteExecCall ["ALF_Server_fnc_distrib_stockLoad", 2];
		private _timeout = time + 2;
		waitUntil {
			!isNil {_machine getVariable "MRP_Distrib_Stock"} || {time > _timeout}
		};
	};
};

private _stock = _machine getVariable ["MRP_Distrib_Stock", createHashMap];
if (_stock isEqualType []) then { _stock = createHashMap; };

_stock
