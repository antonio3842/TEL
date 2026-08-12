/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/
#include "\A3\ui_f\hpp\defineResincl.inc"

disableSerialization;
params [
	["_display",displayNull,[displayNull,controlNull]]
];

_display displayAddEventHandler ["KeyDown",{
	if ((_this select 1) isEqualTo 211) exitWith {
		private _info = ctrlMapMouseOver (findDisplay 12 displayCtrl 51);

		if (_info isEqualTo []) exitWith {};
		
		private _marker = _info select 1;
		if ((_info select 0) isEqualTo "marker" && {_marker find "depanneur_placed" > -1 || {_marker find "dir_placed" > -1} || {_marker find "gendarme_placed" > -1} || {_marker find "pompier_placed" > -1}}) then {
			[_marker] remoteExecCall ["ALF_Server_fnc_removeMarker",2];
		};
		
		true
	};
	if (visibleMap) then {call CBA_EVENTS_fnc_keyHandlerDown};
}];
