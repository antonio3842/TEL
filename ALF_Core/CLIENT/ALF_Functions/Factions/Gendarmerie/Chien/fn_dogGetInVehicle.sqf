/*
	File: fn_dogGetInVehicle.sqf
	Author: ALF TEAM
*/
private _dog = player getvariable ["ALF_Dog", objNull];
private _vehicule = cursorObject;

if (isNull _dog || {isNull _vehicule}) exitWith {};

player setVariable ["ALF_dogAction","monterVehicule"];

_dog moveTo (getPosATL _vehicule);
[player,"ALF_Sifler"] remoteExecCall ["ALF_fnc_say3D",0];

waitUntil {_dog distance2D _vehicule < 5};

switch (typeOf _vehicule) do {
	case "V_ALF_Vito_Gendarmerie_MRPV2" : {_dog attachTo [_vehicule, [0,-2,-0.95]];};
	case "V_ALF_Vito_Penit_MRPV2" : {_dog attachTo [_vehicule, [0,-2,-0.95]];};
	case "V_ALF_Vito_G_SR_MRPV2" : {_dog attachTo [_vehicule, [0,-2,-0.95]];};
	case "V_ALF_Vito_Cyno" : {_dog attachTo [_vehicule, [0,-2,-0.95]];};
	case "V_ALF_Vito_Black_MRPV2" : {_dog attachTo [_vehicule, [0,-2,-0.95]];};
	case "V_ALF_Vito_White_MRPV2" : {_dog attachTo [_vehicule, [0,-2,-0.95]];};
	case "V_ALF_Vito_Blue_MRPV2" : {_dog attachTo [_vehicule, [0,-2,-0.95]];};
	case "V_ALF_Vito_Darkgreen_MRPV2" : {_dog attachTo [_vehicule, [0,-2,-0.95]];};
	case "V_ALF_Vito_Darkred_MRPV2" : {_dog attachTo [_vehicule, [0,-2,-0.95]];};
	case "V_ALF_Vito_Green_MRPV2" : {_dog attachTo [_vehicule, [0,-2,-0.95]];};
	case "V_ALF_Vito_Orange_MRPV2" : {_dog attachTo [_vehicule, [0,-2,-0.95]];};
	case "V_ALF_Vito_Silver_MRPV2" : {_dog attachTo [_vehicule, [0,-2,-0.95]];};
	case "V_ALF_Vito_Red_MRPV2" : {_dog attachTo [_vehicule, [0,-2,-0.95]];};
	case "V_ALF_Vito_Yellow_MRPV2" : {_dog attachTo [_vehicule, [0,-2,-0.95]];};
	case "V_ALF_RS6_MRPV2" : {_dog attachTo [_vehicule, [-0.2,-1.6,-1.02]];};
	case "V_ALF_RS6_Blue_MRPV2" : {_dog attachTo [_vehicule, [-0.2,-1.6,-1.02]];};
	case "V_ALF_RS6_Darkgreen_MRPV2" : {_dog attachTo [_vehicule, [-0.2,-1.6,-1.02]];};
	case "V_ALF_RS6_Darkred_MRPV2" : {_dog attachTo [_vehicule, [-0.2,-1.6,-1.02]];};
	case "V_ALF_RS6_Green_MRPV2" : {_dog attachTo [_vehicule, [-0.2,-1.6,-1.02]];};
	case "V_ALF_RS6_Orange_MRPV2" : {_dog attachTo [_vehicule, [-0.2,-1.6,-1.02]];};
	case "V_ALF_RS6_Pink_MRPV2" : {_dog attachTo [_vehicule, [-0.2,-1.6,-1.02]];};
	case "V_ALF_RS6_Purple_MRPV2" : {_dog attachTo [_vehicule, [-0.2,-1.6,-1.02]];};
	case "V_ALF_RS6_Red_MRPV2" : {_dog attachTo [_vehicule, [-0.2,-1.6,-1.02]];};
	case "V_ALF_RS6_Silver_MRPV2" : {_dog attachTo [_vehicule, [-0.2,-1.6,-1.02]];};
	case "V_ALF_RS6_Black_MRPV2" : {_dog attachTo [_vehicule, [-0.2,-1.6,-1.02]];};
	case "V_ALF_CLA45_GND_MRPV2" : {_dog attachTo [_vehicule, [0,-1.2,-0.95]];};
	case "VEH_Mercura_MRP_Citroen_Berlingo_Gn" : {_dog attachTo [_vehicule, [0.25,-0.7,0.47]];};
	case "VEH_Mercura_MRP_Skoda_Karoq_Gn" : {_dog attachTo [_vehicule, [0,-1.4,0.6]];};
	default {_dog attachTo [_vehicule, [-0.2,-1.6,-1.02]];};
};

_dog disableAI "PATH";

[_dog, "Dog_Sit"] remoteExec ["switchMove", 0];   
