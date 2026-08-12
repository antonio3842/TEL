/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/
params [
	["_unit",objNull,[objNull]],
	["_pos","",[""]],
	["_veh",objNull,[objNull]],
	["_turret",[],[[]]]
];

if !(isNull ALF_PhoneObject) then {
	[] spawn {
		ALF_PhoneObject hideObject true;
		sleep 2;
		_pos = (vehicle player) worldToModel (player modelToWorldVisual ((player selectionPosition "RightHandMiddle1") vectorAdd [0.02,0.01,0.15]));
		detach ALF_PhoneObject;
		ALF_PhoneObject attachTo [(vehicle player),_pos];
		ALF_PhoneObject setVectorDirAndUp [[-0.21017,0.265195,-0.94101],[-0.949623,0.173499,0.260989]];
		ALF_PhoneObject hideObject false;
	};
};

if ({_x isKindOf "Man"} count (attachedObjects _unit) > 0) exitWith {
	_unit action ["Eject",_veh];
	["Porter", "Vous arrivez à rentrer dans un véhicule en portant un corps ?", "danger"] spawn ALF_fnc_doMsg;
	_unit playMoveNow "AcinPercMstpSnonWnonDnon";
};

if (_veh isKindOf "Air" && {ALF_Prison}) exitWith {
	if(ALF_Count_Penit < 5) then {
		_unit action ["Eject",_veh];
		["INFO", "Il n'y a assez pas de gardien, vous ne pouvez pas vous évader par les airs.", "danger"] spawn ALF_fnc_doMsg;
	};
};

if (_pos isEqualTo "driver" && {({typeOf _x isEqualTo "ALF_Pistolet_Essence"} count (attachedObjects _veh)) > 0}) then {
	player action ["engineOff", vehicle player];
};

if ((_this select 0) isEqualTo player && { (_this select 2) isKindOf "Ship" }) then {private _veh = _this select 2;[_veh] spawn {params ["_v"];uiSleep 4; // attendre 1 frame
        if (driver _v isEqualTo player) then {
            [] call ALF_fnc_pecheBateau;
        };
    };
};

// Vérifier les roues et bloquer le véhicule si nécessaire
if ((_this select 0) isEqualTo player && { (_this select 2) isKindOf "LandVehicle" }) then {
	private _veh = _this select 2;
	[_veh] spawn ALF_fnc_checkWheelsAndFreeze;
};