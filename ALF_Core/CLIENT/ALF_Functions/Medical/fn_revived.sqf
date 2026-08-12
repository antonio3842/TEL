#include "\ALF_Client\script_macros.hpp"
/*
	File: fn_revived.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	THANK YOU JESUS I WAS SAVED!
*/
params [
	["_p",objNull,[objNull]]
];
if (isNull _p) exitwith {};

if(alf_ms_isdead) exitWith {
	["INFO", "Cette personne est définitivement morte..", "warning"] remoteExec ["ALF_fnc_doMsg",_p];
	player setVariable ["ReviveMedic",false,true];
};

private _dice = random(100);
if (_dice >= 90) exitWith {
	["INFO", "Cela n'a aucun effet..", "warning"] remoteExec ["ALF_fnc_doMsg",_p];
};

closeDialog 0;
life_deathCamera cameraEffect ["TERMINATE","BACK"];
camDestroy life_deathCamera;

alf_death_effect ppEffectEnable false;
ppEffectDestroy alf_death_effect;

//Bring me back to life.
player setUnconscious true;

life_radio_connected = false;
ALF_Sony_Freq = 0;
player setVariable ["SonyFreq",0,2];
ALF_Sony_FreqAdd = 0;
player setVariable ["SonyFreqAdd",0,2];

player setVariable ["Reviving",nil,true];
player setVariable ["tf_voiceVolume", 1, true];
player setVariable ["ReviveMedic",false,true];

if (ALF_Bracelet) then {
	_array = missionNamespace getVariable ["ALF_AllBracelets",[]];
	if !(player in _array) then {
		_array pushBack player;
		missionNamespace setVariable ["ALF_AllBracelets",_array,true];
	};
};

if (ALF_Prison) then {player setVariable ["ALF_EnPrison",true,true];};

if(life_coplevel > 0) then {
	private _groupe_GN = units ((groups civilian select {"Gendarmerie" in groupid _x}) # 0);
	if (isnil {_groupe_GN}) then {_groupe_GN = [];};

    player setVariable ["SonyFreq",0,[2] + _groupe_GN];
    player setVariable ["SonyFreqAdd",0,[2] + _groupe_GN];
	player setVariable ["CopService",life_gendarme_service,true];
	[0] remoteExecCall ["ALF_Server_fnc_priseService",2];
};

if(life_mediclevel > 0) then {
	private _groupe_SP = units ((groups civilian select {"Pompiers" in groupid _x}) # 0);
	if (isnil {_groupe_SP}) then {_groupe_SP = [];};

    player setVariable ["SonyFreq",0,[2] + _groupe_SP];
    player setVariable ["SonyFreqAdd",0,[2] + _groupe_SP];
	player setVariable ["MedService",life_pompier_service,true];
	[1] remoteExecCall ["ALF_Server_fnc_priseService",2];
};

if(life_penit > 0) then {
	player setVariable ["PenitService",life_penit_service,true];
	player setVariable ["SonyFreq",0,([2] + (((missionNamespace getVariable ["ALF_AllPenits",[]])) apply {_x getVariable ["ALF_ownerID",2]}))];
	player setVariable ["SonyFreqAdd",0,([2] + (((missionNamespace getVariable ["ALF_AllPenits",[]])) apply {_x getVariable ["ALF_ownerID",2]}))];
	[2] remoteExecCall ["ALF_Server_fnc_priseService",2];
};

[] call SOCK_fnc_updateRequest;
call ALF_fnc_incendie_initPlayer;

player allowDammage false;
[] spawn ALF_fnc_deadOnBreak;
sleep 5;
player allowDammage true;
