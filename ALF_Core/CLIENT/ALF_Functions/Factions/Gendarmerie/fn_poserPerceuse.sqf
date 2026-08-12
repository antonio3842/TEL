#include "\ALF_Client\script_macros.hpp"
/*
	File: fn_poserPerceuse.sqf
	Author: ALF NiiRoZz
*/
params [
	["_item","",[""]]
];

private _GN_En_Service = (((groups civilian) select {groupId _x isEqualto "Gendarmerie"}) # 0);

// Si le joueur EST gendarme mais qu'ils sont trop peu → blocage RP
if (!isNil {_GN_En_Service} AND {count (units _GN_En_Service) < 7 AND {life_gendarme_service}}) exitWith {
    closeDialog 2;
    ["Mec suspect", "T'es de la maison… va bosser !", "danger", false] spawn alf_fnc_doMsg;
};

// Si PAS gendarme → trop risqué, dealer refuse
if (isNil {_GN_En_Service} OR {count (units _GN_En_Service) < 2}) exitWith {
    closeDialog 2;
    ["Cambriolage", "Lâche l'affaire, c'est pas un bon moment.", "danger", false] spawn alf_fnc_doMsg;
};

if (_item isEqualTo "") exitwith {};
if (ALF_PoserPerceuseActive) exitwith {["Perceuse", "Vous posez dejà une charge", "danger", false] spawn ALF_fnc_doMsg;};


[_item,false] spawn ALF_fnc_handleItem;
ALF_PoserChargeObject = "ALF_Perceuse_GDM" createVehicle [0,0,0];
ALF_PoserPerceuseActive = true;
ALF_PoserChargeHouse = objNull;
[ALF_PoserChargeObject,false] remoteExecCall ["enableSimulationGlobal",2];
ALF_EventHandlerPoserCharge = addMissionEventHandler ["EachFrame", {
	_ins = lineIntersectsSurfaces [
		AGLToASL positionCameraToWorld [0,0,0], 
		AGLToASL positionCameraToWorld [0,0,4], 
		player,
		ALF_PoserChargeObject,
		true,
		1,
		"GEOM",
		"NONE"
	];
	if (count _ins == 0) exitWith {ALF_PoserChargeObject setPosASL [0,0,0]};
	ALF_PoserChargeObject setPosASL (_ins select 0 select 0); 
	ALF_PoserChargeObject setVectorUp (_ins select 0 select 1);
	ALF_PoserChargeHouse = (_ins select 0 select 3);
}];

