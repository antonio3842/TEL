/*
	File: fn_doCopCall.sqf
*/

params[
	["_texte1","",[""]],
	["_texte2","",[""]]
];

if(_texte1 isEqualTo "" OR {_texte2 isEqualTo ""}) exitWith {};

[_texte1,_texte2] remoteExec ["ALF_fnc_doCopCall",(playableUnits select {_x getVariable ["CopService",false]})];


/*
//ALF_Server_fnc_doCopCall = {

params [
    ["_texte1","",[""]],
    ["_texte2","",[""]]
];

if (_texte1 isEqualTo "" || _texte2 isEqualTo "") exitWith {};

private _copsEligibles = playableUnits select {
    _x getVariable ["license_PSIG_Sabre",false] &&
    _x getVariable ["CopService",false]
};

if (_copsEligibles isEqualTo []) exitWith {};

[_texte1, _texte2] remoteExec ["ALF_fnc_doCopCall", _copsEligibles];

//};
*/
