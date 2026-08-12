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

//if (player getVariable ["isEmployed",""] isEqualTo "" && {!(life_gendarme_service)} && {!(life_pompier_service)} && {ALF_AdminLevel < 2} && {life_penit isEqualTo 0}) exitWith {_display closeDisplay 2;};

private _channel = _display displayCtrl IDC_INSERT_MARKER_CHANNELS;
private _buttonOK = _display displayCtrl 1;

{
	if (call (_x select 2)) then {
		private _lbAdd = _channel lbAdd (_x select 0);
		private _color = _x select 1;
		if (_color isEqualType "") then {
			_color = (configfile >> "RscChatListMission" >> _color) call BIS_fnc_colorConfigToRGBA;
		};
		_channel lbSetColor [_lbAdd, _color];
		_channel lbSetSelectColor [_lbAdd,_color];
		_channel lbSetData [_lbAdd, str (_forEachIndex + 5)];
	};
} forEach [
	["Canal dépanneur","colorVehicleChannel",{b_Depanneur}],
	["Canal DIR","colorVehicleChannel",{b_18}],
	["Canal gendarme","colorSideChannel",{life_gendarme_service}],
	["Canal pompier",[0.957,0.314,0.259,1],{life_pompier_service}]
];

for "_i" from 1 to 4 do {
	_channel lbDelete 1;
};

_channel lbSetCurSel 0;

_buttonOK ctrlAddEventHandler ["buttonClick",{
	disableSerialization;
	private _display = findDisplay 54;
	private _channel = _display displayCtrl IDC_INSERT_MARKER_CHANNELS;
	private _cursel = lbCurSel _channel;
	ALF_allMarkers = allMapMarkers;

	if ((_channel lbText _cursel) isEqualTo "Canal dépanneur") then {
		[0,_display] spawn ALF_fnc_insertMarkerOK;
	};

	if ((_channel lbText _cursel) isEqualTo "Canal DIR") then {
		[1,_display] spawn ALF_fnc_insertMarkerOK;
	};

	if ((_channel lbText _cursel) isEqualTo "Canal gendarme") then {
		[2,_display] spawn ALF_fnc_insertMarkerOK;
	};

	if ((_channel lbText _cursel) isEqualTo "Canal pompier") then {
		[3,_display] spawn ALF_fnc_insertMarkerOK;
	};
}];
