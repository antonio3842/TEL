/*
	File: fn_bieEteindre.sqf
	Author: ALF TEAM
*/
params [
	["_object",objNull,[objNull]],
	["_unit",objNull,[objNull]]
];


diag_log format ["_object = %1",_object];
diag_log format ["_unit = %1",_unit];

if (isNull _object || {isNull _unit}) exitWith {};

_object animateSource ["disable_source",1,true];

["Enedis","Vous avez éteint le courant de ce secteur.","warning"] remoteExec ["ALF_fnc_doMsg",_unit];

private _ville_Proche = text ((nearestLocations [position _object, ["NameLocal","NameVillage","NameCity","NameCityCapital"], 1000]) # 0);

_random = random 100;

if (_random >= 30) then {
    ["Enedis",format["Le transformateur de %1 vient d'être déconnecté",_ville_Proche]] remoteExecCall ["ALF_Server_fnc_doCopCall",2];
	["Enedis",format["Une coupure de courant impacte actuelement le transformateur de %1. Les équipes d'Enedis font leur maximum pour rétablir le réseau",_ville_Proche]] remoteExec ["ALF_fnc_doBfmO",playableUnits];
};

private _msg = format ["Le transformateur de %1 vient d'être déconnecté",_ville_Proche];
["Enedis", _msg, "warning"] remoteExec [
    "ALF_fnc_doMsg",
    (allPlayers select { _x getVariable ['MRP_Bie_EnService', false] })
];

private _dice = random(100);
private _adn = _unit getVariable "adnface" select 0;
if(_dice > 60 ) then {
	private  _data = _object getVariable ["ilyadeladn",[]];
	if(count _data isEqualTo 0) then {
		_object setVariable["ilyadeladn",[_adn],true];
	} else {
		_data pushBack _adn;
		_object setVariable["ilyadeladn",_data,true];
	};
};