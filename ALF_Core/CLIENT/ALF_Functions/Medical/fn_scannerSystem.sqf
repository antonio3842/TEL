/*

// ALF_fnc_scannerSystem = {
private _medecin = param [0,objnull];

if(isNull _scanner || {isNull _medecin}) exitWith {};

if !([_medecin] call ALF_fnc_hasEnergy) exitWith {["INFO", "Le scanner n'a pas d'électricité.", "success"] remoteExec ["ALF_fnc_doMsg",_medecin];};

private _scanner = (nearestObjects [player,["Land_ALF_IRM"],8]) # 0;

alf_ms_active = false;
disableUserInput true;

player setUnconscious false;
player action ["Eject",vehicle player];
sleep 1;

[player, "passenger_injured_medevac_truck01"] remoteExec ["ALF_fnc_switchMove",0];
player setPosATL (_scanner modelToWorld (_scanner selectionPosition "pos_cargo"));
player setDir ((getDir _scanner) - 180);

["INFO", "Le patient est transféré sur le Scanner.", "success"] remoteExec ["ALF_fnc_doMsg",_medecin];

_scanner setVariable ["wip",true,true];

for "_i" from 1 to 10 step 1 do 
{
	if(_scanner animationSourcePhase "box_source" > 0.5) then 
	{
		[_scanner,["box_source",0]] remoteExec ["animateSource",0];
	} else 
	{
		[_scanner,["box_source",1]] remoteExec ["animateSource",0];
		playSound3D ["ALF_Client2\sounds\irm.ogg", _scanner, false, getPosasl _scanner, 5, 1, 60];
	};

	sleep 15;
};

disableUserInput false;
_scanner setVariable ["wip",false,true];

alf_ms_isdead = false;

alf_ms_bpm = 80;
alf_ms_mmHg = 120;
alf_ms_resp = 15;
alf_ms_spo2 = 97;
alf_ms_pain = 0;
alf_ms_bleeding = false;
alf_ms_bouteille = false;

player setDamage 0;

player setVariable ["bouteilleo2",alf_ms_bouteille,2];
player setVariable ["MedicalStats",[],true];

[player, ""] remoteExec ["ALF_fnc_switchMove",0];
private _pos = getPosATL player;
player setPosATL [(_pos select 0)+1, _pos select 1, _pos select 2];


life_is_alive = true;
[3] call SOCK_fnc_updatePartial;
// };
*/


/*
//ALF_fnc_scannerSystem = {
private _medecin = param [0, objNull];

if (isNull _medecin) exitWith {};

private _scanner = (nearestObjects [player, ["Land_ALF_IRM"], 8]) # 0;
if (isNull _scanner) exitWith {};

if !([_medecin] call ALF_fnc_hasEnergy) exitWith {
    ["INFO", "Le scanner n'a pas d'électricité.", "success"] remoteExec ["ALF_fnc_doMsg", _medecin];
};

alf_ms_active = false;
disableUserInput true;

player setUnconscious false;
player action ["Eject", vehicle player];
sleep 1;

[player, "passenger_injured_medevac_truck01"] remoteExec ["ALF_fnc_switchMove", 0];
player setPosATL (_scanner modelToWorld (_scanner selectionPosition "pos_cargo"));
player setDir ((getDir _scanner) - 180);

["INFO", "Le patient est transféré sur le Scanner.", "success"] remoteExec ["ALF_fnc_doMsg", _medecin];

_scanner setVariable ["wip", true, true];

for "_i" from 1 to 10 step 1 do {
    if (_scanner animationSourcePhase "box_source" > 0.5) then {
        [_scanner, ["box_source", 0]] remoteExec ["animateSource", 0];
    } else {
        [_scanner, ["box_source", 1]] remoteExec ["animateSource", 0];
        playSound3D ["ALF_Client2\sounds\irm.ogg", _scanner, false, getPosASL _scanner, 5, 1, 60];
    };
    sleep 15;
};

disableUserInput false;
_scanner setVariable ["wip", false, true];

alf_ms_isdead = false;
alf_ms_bpm = 80;
alf_ms_mmHg = 120;
alf_ms_resp = 15;
alf_ms_spo2 = 97;
alf_ms_pain = 0;
alf_ms_bleeding = false;
alf_ms_bouteille = false;

player setDamage 0;

player setVariable ["bouteilleo2", alf_ms_bouteille, 2];
player setVariable ["MedicalStats", [], true];

[player, ""] remoteExec ["ALF_fnc_switchMove", 0];
private _pos = getPosATL player;
player setPosATL [(_pos select 0) + 1, _pos select 1, _pos select 2];

life_is_alive = true;
[player] spawn ALF_fnc_revivePlayer;
[3] call SOCK_fnc_updatePartial;
//};



//ALF_fnc_scannerSystem = {
private _medecin = param [0, objNull];
if (isNull _medecin) exitWith {};

private _scanner = (nearestObjects [player, ["Land_ALF_IRM"], 8]) # 0;
if (isNull _scanner) exitWith {};

if !([_medecin] call ALF_fnc_hasEnergy) exitWith {
    ["INFO", "Le scanner n'a pas d'électricité.", "success"] remoteExec ["ALF_fnc_doMsg", _medecin];
};

alf_ms_active = false;
disableUserInput true;

player action ["Eject", vehicle player];
sleep 1;

[player, "passenger_injured_medevac_truck01"] remoteExec ["ALF_fnc_switchMove", 0];
player setPosATL (_scanner modelToWorld (_scanner selectionPosition "pos_cargo"));
player setDir ((getDir _scanner) - 180);

["INFO", "Le patient est transféré sur le Scanner.", "success"] remoteExec ["ALF_fnc_doMsg", _medecin];
_scanner setVariable ["wip", true, true];

for "_i" from 1 to 10 step 1 do {
    if (_scanner animationSourcePhase "box_source" > 0.5) then {
        [_scanner, ["box_source", 0]] remoteExec ["animateSource", 0];
    } else {
        [_scanner, ["box_source", 1]] remoteExec ["animateSource", 0];
        playSound3D ["ALF_Client2\sounds\irm.ogg", _scanner, false, getPosASL _scanner, 5, 1, 60];
    };
    sleep 15;
};

disableUserInput false;
_scanner setVariable ["wip", false, true];

alf_ms_isdead = false;
alf_ms_bpm = 80;
alf_ms_mmHg = 120;
alf_ms_resp = 15;
alf_ms_spo2 = 97;
alf_ms_pain = 0;
alf_ms_bleeding = false;
alf_ms_bouteille = false;

player setDamage 0;
player setVariable ["bouteilleo2", alf_ms_bouteille, 2];
player setVariable ["MedicalStats", [], true];

life_deathCamera cameraEffect ["TERMINATE", "BACK"];
if (!isNil "life_deathCamera") then {
    camDestroy life_deathCamera;
    life_deathCamera = nil;
};

alf_death_effect ppEffectEnable false;
ppEffectDestroy alf_death_effect;

"mort" cutText ["", "BLACK IN"];
"mort" cutFadeOut 0;

player setVariable ["Reviving", nil, true];
player setVariable ["tf_voiceVolume", 1, true];
player setVariable ["ReviveMedic", false, true];
player setVariable ["requestMedic", false, true];

if (!isNull (findDisplay 7300)) then {
    closeDialog 0;
};

life_radio_connected = false;
ALF_Sony_Freq = 0;
ALF_Sony_FreqAdd = 0;
player setVariable ["SonyFreq", 0, 2];
player setVariable ["SonyFreqAdd", 0, 2];

if (ALF_Bracelet) then {
    private _array = missionNamespace getVariable ["ALF_AllBracelets", []];
    if !(player in _array) then {
        _array pushBack player;
        missionNamespace setVariable ["ALF_AllBracelets", _array, true];
    };
};

if (ALF_Prison) then {
    player setVariable ["ALF_EnPrison", true, true];
};

if (life_coplevel > 0) then {
    private _groupe_GN = units ((groups civilian select {"Gendarmerie" in groupid _x}) # 0);
    if (isNil "_groupe_GN") then { _groupe_GN = []; };
    player setVariable ["SonyFreq", 0, [2] + _groupe_GN];
    player setVariable ["SonyFreqAdd", 0, [2] + _groupe_GN];
    player setVariable ["CopService", life_gendarme_service, 2];
    [0] remoteExecCall ["ALF_Server_fnc_priseService", 2];
};

if (life_mediclevel > 0) then {
    private _groupe_SP = units ((groups civilian select {"Pompiers" in groupid _x}) # 0);
    if (isNil "_groupe_SP") then { _groupe_SP = []; };
    player setVariable ["SonyFreq", 0, [2] + _groupe_SP];
    player setVariable ["SonyFreqAdd", 0, [2] + _groupe_SP];
    player setVariable ["MedService", life_pompier_service, 2];
    [1] remoteExecCall ["ALF_Server_fnc_priseService", 2];
};

if (life_penit > 0) then {
    player setVariable ["PenitService", life_penit_service, 2];
};

life_is_alive = true;
life_hunger = 100;
life_thirst = 100;
player allowDamage true;
player setUnconscious false;

[player, "AmovPpneMstpSrasWrflDnon"] remoteExecCall ["ALF_fnc_animSync", 0];

private _pos = getPosATL player;
player setPosATL [(_pos select 0) + 1, _pos select 1, _pos select 2];

[] call SOCK_fnc_updateRequest;
//};
*/





































//ALF_fnc_scannerSystem = {

    
private _medecin = param [0, objNull];
if (isNull _medecin) exitWith {};

private _scanner = (nearestObjects [player, ["Land_ALF_IRM"], 8]) # 0;
if (isNull _scanner) exitWith {};

//if !([_medecin] call ALF_fnc_hasEnergy) exitWith {
//    ["INFO", "Le scanner n'a pas d'électricité.", "success"] remoteExec ["ALF_fnc_doMsg", _medecin];
//};

alf_ms_active = false;
disableUserInput true;

player action ["Eject", vehicle player];
sleep 1;

[player, "passenger_injured_medevac_truck01"] remoteExec ["ALF_fnc_switchMove", 0];
player setPosATL (_scanner modelToWorld (_scanner selectionPosition "pos_cargo"));
player setDir ((getDir _scanner) - 180);

["INFO", "Le patient est transféré sur le Scanner.", "success"] remoteExec ["ALF_fnc_doMsg", _medecin];
_scanner setVariable ["wip", true, true];

player setVariable ["scannerTimeout", time + 150, true];

// OPTIMISÉ: Animation locale (synchronisée automatiquement par Arma) au lieu de 10 broadcasts réseau
for "_i" from 1 to 10 step 1 do {
    if (_scanner animationSourcePhase "box_source" > 0.5) then {
        _scanner animateSource ["box_source", 0];
    } else {
        _scanner animateSource ["box_source", 1];
        playSound3D ["ALF_Client2\sounds\irm.ogg", _scanner, false, getPosASL _scanner, 5, 1, 60];
    };
    sleep 15;
};

disableUserInput false;
_scanner setVariable ["wip", false, true];

alf_ms_isdead = false;
alf_ms_bpm = 80;
alf_ms_mmHg = 120;
alf_ms_resp = 15;
alf_ms_spo2 = 97;
alf_ms_pain = 0;
alf_ms_bleeding = false;
alf_ms_bouteille = false;

player setDamage 0;
player setVariable ["bouteilleo2", alf_ms_bouteille, 2];
player setVariable ["MedicalStats", [], true];

life_deathCamera cameraEffect ["TERMINATE", "BACK"];
if (!isNil "life_deathCamera") then {
    camDestroy life_deathCamera;
    life_deathCamera = nil;
};

alf_death_effect ppEffectEnable false;
ppEffectDestroy alf_death_effect;

"mort" cutText ["", "BLACK IN"];
"mort" cutFadeOut 0;

player setVariable ["Reviving", nil, true];
player setVariable ["tf_voiceVolume", 1, true];
player setVariable ["ReviveMedic", false, true];
player setVariable ["requestMedic", false, true];

if (!isNull (findDisplay 7300)) then {
    closeDialog 0;
};

life_radio_connected = false;
ALF_Sony_Freq = 0;
ALF_Sony_FreqAdd = 0;
player setVariable ["SonyFreq", 0, 2];
player setVariable ["SonyFreqAdd", 0, 2];

if (ALF_Bracelet) then {
    private _array = missionNamespace getVariable ["ALF_AllBracelets", []];
    if !(player in _array) then {
        _array pushBack player;
        missionNamespace setVariable ["ALF_AllBracelets", _array, true];
    };
};

if (ALF_Prison) then {
    player setVariable ["ALF_EnPrison", true, true];
};

if (life_coplevel > 0) then {
    private _groupe_GN = units ((groups civilian select {"Gendarmerie" in groupid _x}) # 0);
    if (isNil "_groupe_GN") then { _groupe_GN = []; };
    player setVariable ["SonyFreq", 0, [2] + _groupe_GN];
    player setVariable ["SonyFreqAdd", 0, [2] + _groupe_GN];
    player setVariable ["CopService", life_gendarme_service, true];
    [0] remoteExecCall ["ALF_Server_fnc_priseService", 2];
};

if (life_mediclevel > 0) then {
    private _groupe_SP = units ((groups civilian select {"Pompiers" in groupid _x}) # 0);
    if (isNil "_groupe_SP") then { _groupe_SP = []; };
    player setVariable ["SonyFreq", 0, [2] + _groupe_SP];
    player setVariable ["SonyFreqAdd", 0, [2] + _groupe_SP];
    player setVariable ["MedService", life_pompier_service, true];
    [1] remoteExecCall ["ALF_Server_fnc_priseService", 2];
};

if (life_penit > 0) then {
    player setVariable ["PenitService", life_penit_service, true];
};

life_is_alive = true;
life_hunger = 100;
life_thirst = 100;
player allowDamage true;
player setUnconscious false;

[player, "AmovPpneMstpSrasWrflDnon"] remoteExecCall ["ALF_fnc_animSync", 0];

private _pos = getPosATL player;
player setPosATL [(_pos select 0) + 1, _pos select 1, _pos select 2];

player setVariable ["onScanner", false, true];
player setVariable ["scannerTimeout", nil, true];

[] call SOCK_fnc_updateRequest;

//};