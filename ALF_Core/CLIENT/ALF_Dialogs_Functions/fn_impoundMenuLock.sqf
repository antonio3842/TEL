// ALF_fnc_impoundMenuLock = {
private["_vehicles","_control"];
disableSerialization;
_vehicles = param [0,[],[[]]];

ctrlShow[2803,false];
ctrlShow[2830,false];
waitUntil {sleep 0.2; !isNull (findDisplay 2800)};

if(count _vehicles isEqualTo 0) exitWith {ctrlSetText[2811,localize "STR_Garage_NoVehicles"];};
// ['_vehicles fourriere ' + str(_vehicles)] remoteExec ['systemchat',0]; // PERF FIX: Debug désactivé
_control = ((findDisplay 2800) displayCtrl 2802);
lbClear _control;

{
	_vehicleInfo = [_x # 1] call ALF_fnc_fetchVehInfo;
	_control lbAdd (_vehicleInfo # 3);
	_control lbSetData [(lbSize _control)-1,(str [_x # 1,_x # 3,_x # 6,_x # 7,_x # 8,_x # 9])];
	_control lbSetPicture [(lbSize _control)-1,_vehicleInfo # 2];
	_control lbSetValue [(lbSize _control)-1,_x # 0];
} forEach _vehicles;
lbSort _control;

ctrlShow[2810,false];
ctrlShow[2811,false];
// };