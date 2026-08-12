/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/
TON_fnc_index =
compileFinal "
	params [
		""_item"",
		[""_stack"",[],[[]]]
	];
	if (_stack isEqualTo []) exitWith {-1};

	_stack findIf {_item in _x}
";
publicVariable "TON_fnc_index";

TON_fnc_isnumber =
compileFinal "
	params [
		[""_value"","""",[""""]]
	];

	if (_value isEqualTo """") exitWith {false};

	_arr = toArray(_value);
	_return = true;

	{
		if (_x < 48 || _x > 57) exitWith {
			_return = false;
		};
	} forEach _arr;
	_return;
";

publicVariable "TON_fnc_isnumber";

TON_fnc_clientGetKey =
compileFinal "
	params [
		[""_vehicle"",objNull,[objNull]],
		[""_unit"",objNull,[objNull]]
	];
	if(isNull _vehicle || {isNull _unit}) exitWith {};
	if(player isEqualTo _unit && {!(_vehicle in life_vehicles)}) then {
		life_vehicles pushBack _vehicle;
		[getPlayerUID player,_vehicle,1] call ALF_Server_fnc_keyManagement;
	};
";
publicVariable "TON_fnc_clientGetKey";
