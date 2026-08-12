#include "\ALF_Core\SERVER\script_macros.hpp"
/*
Spawn d'un objet, script init par "fn_dirObjEventStart.sqf"
*/


if (!isServer) exitWith { diag_log "[ENEDIS][Spawn Objet] ABORT: not server"; objNull };

params [["_objetHS", objNull]];

if (isNull _objetHS) exitWith {};

diag_log format ["[ENEDIS] Spawn de l'objet : %1", _objetHS];
diag_log format ["[ENEDIS] Spawn de l'objet pos : %1", str (getpos _objetHS)];

private _despawnDelaySec = 1800;   // 30 min Temps despawn auto

if ((typeof _objetHS) == "Land_ALF_Trafo") then {
	_objetHS animateSource ["disable_source",1,true];
};
_objetHS setVariable ["HasCourant", false, true];
_objetHS setVariable ["IsBreak", true, true];
_listePanne = missionNamespace getVariable ["listePanne", []];
_listePanne pushBack _objetHS;
missionNamespace setVariable ["listePanne", _listePanne, true];

private _ville_Proche = text ((nearestLocations [position _objetHS, ["NameLocal","NameVillage","NameCity","NameCityCapital"], 3000]) # 0);

_msg = format ["Une panne vient d'être signalé sur l'île vers %1, regardez votre carte", _ville_Proche];
["Alerte PC Enedis", _msg, "warning"] remoteExec [
	"ALF_fnc_doMsg",
	(allPlayers select { _x getVariable ['MRP_Bie_EnService', false] })
];


uiSleep _despawnDelaySec;

diag_log format ["[ENEDIS] Start despawn de l'objet : %1", _objetHS];

if (_objetHS getVariable ["IsBreak", false]) then { 
	_objetHS setVariable ["IsBreak", false, true];
	_listePanne = missionNamespace getVariable ["listePanne", []];
	_listePanne = _listePanne - [_objetHS];
	missionNamespace setVariable ["listePanne", _listePanne, true];
	_msg = "Un agent d'Enedis vient de réparer une panne";
	["Alerte PC Enedis", _msg, "warning"] remoteExec [
		"ALF_fnc_doMsg",
		(allPlayers select { _x getVariable ['MRP_Bie_EnService', false] })
	];
};



