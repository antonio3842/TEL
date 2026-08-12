// ALF_fnc_impoundMenuCopSP = {
disableSerialization;
params 
[
	["_vehNonFourriere",[],[[]]],
	["_vehFourriere",[],[[]]]
];

waitUntil {sleep 0.2; !isNull (findDisplay 2801)};

ctrlShow[2804,false];
ctrlShow[2830,false];

private _d = findDisplay 2801;
private _btnsortir = _d displayCtrl 97482;
private _btnvendre = _d displayCtrl 97483;
_btnsortir ctrlShow false;
_btnvendre ctrlShow false;

if(_vehNonFourriere isEqualTo [] AND {_vehFourriere isEqualTo []}) exitWith {ctrlSetText[2811,localize "STR_Garage_NoVehicles"];};

private _control = ((findDisplay 2801) displayCtrl 2802);
lbClear _control;

{
	_vehicleInfo = [_x # 1] call ALF_fnc_fetchVehInfo;

	_control lbAdd (_vehicleInfo # 3);
	_control lbSetData [(lbSize _control)-1,(str([_x # 1,_x # 4,_x # 5,_x # 6,_x # 9]))];
	_control lbSetPicture [(lbSize _control)-1,_vehicleInfo # 2];
	_control lbSetValue [(lbSize _control)-1,_x # 0];
} forEach _vehNonFourriere;
lbSort _control;

ctrlShow[2810,false];
ctrlShow[2811,false];
ctrlShow[97480,false];

if (_vehFourriere isEqualTo []) exitWith {};

_index = _control lbAdd "";
_control lbSetData [_index,"affichage"];
_index = _control lbAdd toupper"\\\\\\\\fourrière\\\\\\\\\\";
_control lbSetData [_index,"affichage"];
_index = _control lbAdd "";
_control lbSetData [_index,"affichage"];

_vehFourriere = [_vehFourriere,[],{([_x # 1] call ALF_fnc_fetchVehInfo) # 3},"ASCEND"] call BIS_fnc_sortBy;

{
	_vehicleInfo = [_x # 1] call ALF_fnc_fetchVehInfo;
	_control lbAdd (_vehicleInfo # 3);
	_control lbSetData [(lbSize _control)-1,(str([_x # 1,_x # 5,_x # 6,_x # 8]))];
	_control lbSetPicture [(lbSize _control)-1,_vehicleInfo # 2];
	_control lbSetValue [(lbSize _control)-1,_x # 0];
} forEach _vehFourriere;
// };