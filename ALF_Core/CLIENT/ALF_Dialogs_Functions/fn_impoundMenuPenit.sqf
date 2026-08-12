/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/
#include "\ALF_Client\script_macros.hpp"

disableSerialization;
params [
	["_vehNonFourriere",[],[[]]],
	["_vehFourriere",[],[[]]],
	["_type",-1,[-1]]
];

waitUntil {sleep 0.2; !isNull (findDisplay 080520)};

ctrlShow[2804,false];
ctrlShow[2830,false];

private _d = findDisplay 080520;
private _btnsortir = _d displayCtrl 97482;
private _btnvendre = _d displayCtrl 97483;
_btnsortir ctrlShow false;
_btnvendre ctrlShow false;

if(_vehNonFourriere isEqualTo [] && {_vehFourriere isEqualTo []}) exitWith {
	ctrlSetText[2811,localize "STR_Garage_NoVehicles"];
};

private _control = CONTROL(080520,2802);
lbClear _control;

{
	_vehicleInfo = [_x select 1] call ALF_fnc_fetchVehInfo;
	_control lbAdd (_vehicleInfo select 3);
	_control lbSetData [(lbSize _control)-1,(str([_x select 1,_x select 5,_x select 6,_x select 9,_x select 10,_type]))];
	_control lbSetPicture [(lbSize _control)-1,_vehicleInfo select 2];
	_control lbSetValue [(lbSize _control)-1,_x select 0];
} forEach _vehNonFourriere;
lbSort _control;

ctrlShow[2810,false];
ctrlShow[2811,false];
ctrlShow[97480,false];

if (_vehFourriere isEqualTo []) exitWith {};

_index = _control lbAdd "";
_control lbSetData [_index,"affichage"];
_index = _control lbAdd "\\\\\\\\FOURRIERE\\\\\\\\\\";
_control lbSetData [_index,"affichage"];
_index = _control lbAdd "";
_control lbSetData [_index,"affichage"];

_vehFourriere = [_vehFourriere,[],{([_x select 1] call ALF_fnc_fetchVehInfo) select 3},"ASCEND"] call BIS_fnc_sortBy;

{
	_vehicleInfo = [_x select 1] call ALF_fnc_fetchVehInfo;
	_control lbAdd (_vehicleInfo select 3);
	_control lbSetData [(lbSize _control)-1,(str([_x select 1,_x select 5,_x select 6,_x select 8,_type]))];
	_control lbSetPicture [(lbSize _control)-1,_vehicleInfo select 2];
	_control lbSetValue [(lbSize _control)-1,_x select 0];
} forEach _vehFourriere;
