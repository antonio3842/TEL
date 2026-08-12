/*
	Fonderie de fer
*/
params [
	["_unit",objNull,[objNull]],
	["_curTarget",objNull,[objNull]]
];

private _cuivre = {_x isEqualTo "ALF_Pierre_cui_small"} count (magazines _unit);
if (_cuivre isEqualTo 0) exitWith {["Info", "Vous n'avez plus de minerai sur vous !!", "warning", false] remoteExec ["ALF_fnc_doMsg",_unit]};

/////////////////////////// PROCESS ///////////////////////////////////////
_curTarget animate ['door', 1];
["ALF_Pierre_cui_small",false] remoteExec ["ALF_fnc_handleItem",_unit];


waitUntil {uiSleep 0.1; _curTarget animationPhase "door" isEqualTo 1;};

private _obj = "groundweaponholder" createVehicle [0,0,0];
_obj setPosATL (_curTarget modelToWorld [-0.5,0.15,-0.4]);
_obj addMagazineCargoGlobal ["ALF_Pierre_cui_small",1];
_obj enableDynamicSimulation true;

uiSleep 1;
_curTarget animate ['door', 0];
waitUntil {uiSleep 0.3; _curTarget animationPhase "door" isEqualTo 0;};
if(isNull _obj) exitWith {["Info", "Vous avez récupéré votre minerai.", "warning", false] remoteExec ["ALF_fnc_doMsg",_unit]; _curTarget animate ['start', 0]; _curTarget animate ['end', 0]; _curTarget animate ['door', 0];};
if((count (magazineCargo _obj)) < 1) exitWith {["Info", "Vous avez récupéré votre minerai.", "warning", false] remoteExec ["ALF_fnc_doMsg",_unit]; _curTarget animate ['start', 0]; _curTarget animate ['end', 0]; _curTarget animate ['door', 0]; detach _obj; deleteVehicle _obj;};
detach _obj; deleteVehicle _obj;

_curTarget animate ['start', 1];
_curTarget animate ['end', 1];

playSound3D ["ALF_Client2\sounds\four_cuivre.ogg",_curTarget, false,getpos _curTarget, 1, 1, 100];
uiSleep 42;

private _obj2 = "groundweaponholder" createVehicle [0,0,0];
_obj2 setPosATL (_curTarget modelToWorld [-0.5,0.13,-0.39]);
_obj2 addMagazineCargoGlobal ["ALF_Cuivre",1];
_obj2 enableDynamicSimulation true;

_curTarget animate ['door', 1];
_curTarget animate ['start', 0];
_curTarget animate ['end', 0];

//[2] remoteExec ["ALF_fnc_addXP",remoteExecutedOwner];
