// ALF_fnc_impoundMenu = {
disableSerialization;
params [
	["_vehNonFourriere",[],[[]]],
	["_vehFourriere",[],[[]]]
];
// ['_vehNonFourriere ' + str(_vehNonFourriere)] remoteExec ['systemchat',0];

ctrlShow[2804,false];
ctrlShow[2830,false];
waitUntil {sleep 0.2; !isNull (findDisplay 2800)};

private _d = findDisplay 2800;
private _btnassu = _d displayCtrl 97480;
private _btnassupro = _d displayCtrl 97481;
private _btntransfert = _d displayCtrl 97484;
private _btnsortir = _d displayCtrl 97482;
private _btnvendre = _d displayCtrl 97483;
_btnassu ctrlShow false;
_btnassupro ctrlShow false;
_btntransfert ctrlShow false;
_btnsortir ctrlShow false;
_btnvendre ctrlShow false;

if(_vehNonFourriere isEqualTo [] && {_vehFourriere isEqualTo []}) exitWith {ctrlSetText[2811,localize "STR_Garage_NoVehicles"];};

private _control = ((findDisplay 2800) displayCtrl 2802);
lbClear _control;

{
	_vehicleInfo = [_x # 1] call ALF_fnc_fetchVehInfo;
	_control lbAdd (_vehicleInfo # 3);
	_control lbSetData [(lbSize _control)-1,(str([_x # 1,_x # 6,_x # 7,_x # 8,_x # 9,_x # 12,_x # 13,_x # 14,"",0]))];
	_control lbSetPicture [(lbSize _control)-1,_vehicleInfo # 2];
	_control lbSetValue [(lbSize _control)-1,_x # 0];
	// ['_x # 14 ' + str(_x # 14)] remoteExec ['systemchat',0];
	// ['_x # 13 ' + str(_x # 13)] remoteExec ['systemchat',0];
	// ['_x # 1 ' + str(_x # 1)] remoteExec ['systemchat',0];

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

_vehFourriere = [_vehFourriere,[],{([_x # 1] call ALF_fnc_fetchVehInfo) # 3},"ASCEND"] call BIS_fnc_sortBy;

{
	_vehicleInfo = [_x # 1] call ALF_fnc_fetchVehInfo;
	_control lbAdd (_vehicleInfo # 3);
	_control lbSetData [(lbSize _control)-1,(str([_x # 1,_x # 6,_x # 7,_x # 8,_x # 9,_x # 11,"",0]))];
	_control lbSetPicture [(lbSize _control)-1,_vehicleInfo # 2];
	_control lbSetValue [(lbSize _control)-1,_x # 0];
} forEach _vehFourriere;
// };