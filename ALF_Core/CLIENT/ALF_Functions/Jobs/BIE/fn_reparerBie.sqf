//Réparer un objet cassé pour Enedis

if (!(player getVariable ["MRP_Bie_EnService", false])) exitWith {
    ["Enedis", "Vous devez prendre votre service Enedis afin de pouvoir réparer des objets", "danger"] spawn ALF_fnc_doMsg;
};

_listeobj = nearestObjects [player, [], 10, true] select {_x getVariable ["IsBreak", false]};

if (count _listeobj == 0) exitWith { ["Enedis", "Il n'y a pas d'objet en panne à coté de vous", "danger"] spawn ALF_fnc_doMsg; };


_obj = _listeobj select 0;
/*
if (((typeOf _obj) in ["Land_LampStreet_F", "Land_LampDecor_F"]) AND (((getPosASL player) select 2) - (getTerrainHeightASL (getPosASL _obj)) < 3)) exitWith {
    ["Enedis", "Vous devez monter vers l'ampoule pour réparer le lampadaire", "danger"] spawn ALF_fnc_doMsg;
};
*/
private _MRPV2OBJECT = createSimpleObject ["A3\Weapons_F\Items\Toolkit.p3d",[0,0,0]]; 
_MRPV2OBJECT attachTo [player, [-0.02,0,0], "RightHandMiddle1"];
_MRPV2OBJECT setDir 0;
_MRPV2OBJECT setVectorDirAndUp [[0,0,0],[0,0,0]];
_MRPV2OBJECT setPos (getPos _MRPV2OBJECT);

life_interrupted = false;
life_action_inUse = true;

disableSerialization;
private _display = findDisplay 46;
waitUntil { !isNull _display };

private _barW = 0.3;
private _barH = 0.04;
private _barX = safeZoneX + (safeZoneW - _barW) / 2;
private _barY = safeZoneY + (safeZoneH - _barH) / 2;

private _progressBar = _display ctrlCreate ["RscProgress", -1];
_progressBar ctrlSetPosition [_barX, _barY, _barW, _barH];
_progressBar ctrlSetBackgroundColor [0, 0, 0, 0.5];
_progressBar ctrlCommit 0;
_progressBar progressSetPosition 0;

private _upp = "Réparation de la panne";
private _text = _display ctrlCreate ["RscStructuredText", -1];
_text ctrlSetPosition [_barX, _barY - 0.05, _barW, 0.04];
_text ctrlSetStructuredText parseText format ["<t align='center' size='1.2'>%1</t>", _upp];
_text ctrlCommit 0;

private _cP = 0;
for "_i" from 0 to 60 do {
    if (!alive player || player != vehicle player || life_interrupted) exitWith {};

    if (animationState player != "Acts_carFixingWheel") then {
        player switchMove "Acts_carFixingWheel";
        player playMoveNow "Acts_carFixingWheel";
    };

    _cP = _i / 60;
    _progressBar progressSetPosition _cP;
    sleep 0.1;
};

ctrlDelete _progressBar;
ctrlDelete _text;
life_action_inUse = false;
player playActionNow "stop";
detach _MRPV2OBJECT;    
deleteVehicle _MRPV2OBJECT;
player switchMove "";
if(life_interrupted) exitWith {life_interrupted = false; ["Enedis", "Action annulée.", "danger", false] spawn ALF_fnc_doMsg;};
	_obj setVariable ["IsBreak", false, true];
	_listePanne = missionNamespace getVariable ["listePanne", []];
	_listePanne = _listePanne - [_obj];
	missionNamespace setVariable ["listePanne", _listePanne, true];
	life_cash = life_cash + 7500;
	[0] call SOCK_fnc_updatePartial;
	["Enedis", "Objet réparer, vous avez reçu 7500€.", "success", false] spawn ALF_fnc_doMsg;
	_msg = "Un agent d'Enedis vient de réparer une panne";
	["Alerte PC Enedis", _msg, "warning"] remoteExec [
		"ALF_fnc_doMsg",
		(allPlayers select { _x getVariable ['MRP_Bie_EnService', false] })
	];
