/*
	File: fn_doPenitCall.sqf
*/
params[
	["_texte1","",[""]],
	["_texte2","",[""]],
	["_effect","",[""]]
];
if(_texte1 isEqualTo "" OR {_texte2 isEqualTo "" OR {_effect isEqualTo ""}}) exitWith {};

private _groupe_pm = units ((groups civilian select {"policemunicipale" in groupid _x}) # 0);
if (isnil {_groupe_pm}) exitwith {_groupe_pm = [];};
[_texte1,_texte2,_effect] remoteExec ["ALF_fnc_doMsg",_groupe_pm];