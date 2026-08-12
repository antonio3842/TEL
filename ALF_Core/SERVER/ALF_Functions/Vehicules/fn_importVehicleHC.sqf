// ALF_Server_fnc_importVehicleHC = {
_vid = [_this,0,-1,[0]] call BIS_fnc_param;
_unit = [_this,1,objNull,[objNull]] call BIS_fnc_param;
// _garage = [_this,2,0,[0]] call BIS_fnc_param;

if (_vid isEqualTo -1) exitWith {};

private _query = format["UPDATE vehicles SET pos_save='%2' WHERE id='%1'",_vid,getposatl _unit];
[_query,1] call ALF_Server_fnc_asyncCall;

["INFO","Votre véhicule a été importé dans ce garage.","success"] remoteExec ["ALF_fnc_doMsg",_unit];
// };