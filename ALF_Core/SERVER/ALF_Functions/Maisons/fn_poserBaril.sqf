/*
	File: fn_poserBaril.sqf
	Author: ALF NiiRoZz
*/
params [
	["_house",objNull,[objNull]],
	["_unit",objNull,[objNull]]
];
if (isNull _house || {isNull _unit}) exitWith {};

private _ms = _house getVariable ["mobiliers",[]];
if(count(_ms) > 0) exitWith {["CARAVAN","Vous avez deja posé un baril.","danger"] remoteExec ["ALF_fnc_doMsg",_unit];};

private _index = ALF_Mobiliers_Objects find "ALF_Barrel";
if (_index isEqualTo -1) exitWith {};
private _data = ALF_Mobiliers_Objects_Data select _index;

["ALF_Barrel_boite",false] remoteExec ["ALF_fnc_handleItem",_unit];

private _m = createSimpleObject [_data,[0,0,0]];
_m setPosWorld (_house modelToWorld [-0.7,-1.2,2]);

[getPlayerUID _unit,_m,_house,"ALF_Barrel",(getPosWorld _m),(getDir _m),"ALF_Barrel_boite"] spawn ALF_Server_fnc_addMobilier;

["CARAVAN","Votre baril est posé.","success"] remoteExec ["ALF_fnc_doMsg",_unit];
