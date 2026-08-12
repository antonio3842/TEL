/*
	File: fn_doRobberyCall.sqf
	Author: ALF Team
	Description: Envoie une notification de cambriolage aux gendarmes en service
*/

params[
	["_texte1","",[""]],
	["_texte2","",[""]]
];

if(_texte1 isEqualTo "" OR {_texte2 isEqualTo ""}) exitWith {};

[_texte1,_texte2] remoteExec ["ALF_fnc_doCopCall",(playableUnits select {_x getVariable ["CopService",false]})];
