// ALF_Server_fnc_recruterBusiness = {
private ["_siretstr","_membres"];
_siretstr = _this # 0;
_membres = _this # 1;
if(isNil "_siretstr" OR {isNil "_membres"}) exitWith {};

// _membres = [_membres] call ALF_Server_fnc_mresArray;

[format["UPDATE business SET membres='%1' WHERE siret='%2' AND active='1'",_membres,_siretstr],1] call ALF_Server_fnc_asyncCall;
// };