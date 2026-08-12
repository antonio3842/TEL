/*
	File: fn_bieEteindre.sqf
	Author: ALF TEAM
*/
params [
	["_object",objNull,[objNull]],
	["_unit",objNull,[objNull]]
];
if (isNull _object || {isNull _unit}) exitWith {};

if ((playableUnits findIf { (_x getVariable ["b_18", false]) || (_x getVariable ["MRP_Bie_EnService", false]) }) == -1) exitWith {
    ["ENEDIS","Impossible d'attaquer le transformateur.","success"] remoteExec ["ALF_fnc_doMsg",_unit];
};


if !((_object animationSourcePhase "explo_source") isEqualTo 0) exitWith {};

["ALF_C4",false] remoteExec ["ALF_fnc_handleItem",_unit];

_object animateSource ["explo_source",1,true];

private _ville_Proche = text ((nearestLocations [position _object, ["NameLocal","NameVillage","NameCity","NameCityCapital"], 1000]) # 0);


["ENEDIS","Vous avez posé un C4 sur le compteur.","success"] remoteExec ["ALF_fnc_doMsg",_unit];

playSound3D ["ALF_Client2\sounds\banque_activeC4.ogg", _object, false, (_object modelToWorld (_object selectionPosition "action_c4")), 5, 1, 100];
uiSleep 10;

private _bomb = "mini_Grenade" createVehicle [0,0,0];
_bomb setPos (_object modelToWorld (_object selectionPosition "action_c4"));
uiSleep 5;

_object animateSource ["explo_source",0,true];
_object animateSource ["damage_source",1,true];
_object animateSource ["disable_source",1,true];

_object setVariable ["broken",true,true];

["ENEDIS",format["Le transformateur de %1 vient d'exploser !",_ville_Proche]] remoteExecCall ["ALF_Server_fnc_doCopCall",2];
["ENEDIS",format["Une coupure de courant impacte actuelement le transformateur de %1. Les équipes d'ENEDIS font leur maximum pour rétablir le réseau",_ville_Proche]] remoteExec ["ALF_fnc_doBfmO",playableUnits];


private _msg = format ["Le transformateur de %1 vient d'être déconnecté",_ville_Proche];
["ENEDIS", _msg, "warning"] remoteExec [
    "ALF_fnc_doMsg",
    (allPlayers select { _x getVariable ['MRP_Bie_EnService', false] })
];


uiSleep 600;

_object setVariable ["broken",false,true];

private _dice = random(100);
private _adn = _unit getVariable "adnface" select 0;
if(_dice > 80 ) then {
	private  _data = _object getVariable ["ilyadeladn",[]];
	if(count _data isEqualTo 0) then {
		_object setVariable["ilyadeladn",[_adn],true];
	} else {
		_data pushBack _adn;
		_object setVariable["ilyadeladn",_data,true];
	};
};