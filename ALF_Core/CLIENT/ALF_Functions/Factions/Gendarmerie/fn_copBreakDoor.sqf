#include "\ALF_Client\script_macros.hpp"
/*
	File: fn_copBreakDoor.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Allows cops to 'kick' in the door?
*/
private["_house","_door","_title","_titleText","_progressBar","_cpRate","_cP","_uid"];
_house = param [0,objNull,[objNull]];
private _mode = _this select 1;

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

if (isNull _house || {!(_house isKindOf "House_F")}) exitWith {};
if (isNil {_house getVariable "ALF_PorteFermer"}) exitWith {hint localize "STR_House_Raid_NoOwner"};

_door = [_house,player] call ALF_fnc_nearestDoor;
if(EQUAL(_door,0)) exitWith {hint localize "STR_Cop_NotaDoor"};
if !(_house getVariable ["ALF_PorteFermer",false]) exitWith {hint localize "STR_House_Raid_DoorUnlocked"};

life_action_inUse = true;

//Setup the progress bar
disableSerialization;
_title = localize "STR_House_Raid_Progress";
5 cutRsc ["life_progress","PLAIN"];
_ui = GVAR_UINS "life_progress";
_progressBar = _ui displayCtrl 38201;
_titleText = _ui displayCtrl 38202;
_titleText ctrlSetText format["%2 (1%1)...","%",_title];
_progressBar progressSetPosition 0.01;
_cP = 0.01;
_cpRate = 0.0092;

for "_i" from 0 to 1 step 0 do {
	if(animationState player != "AinvPknlMstpSnonWnonDnon_medic_1") then {
		//[player,"AinvPknlMstpSnonWnonDnon_medic_1",true] remoteExecCall ["ALF_fnc_animSync",RCLIENT];
		player switchMove "AinvPknlMstpSnonWnonDnon_medic_1";
		player playMoveNow "AinvPknlMstpSnonWnonDnon_medic_1";
	};
	sleep 0.26;
	if(isNull _ui) then {
		5 cutRsc ["life_progress","PLAIN"];
		_ui = GVAR_UINS "life_progress";
	};
	_cP = _cP + _cpRate;
	_progressBar progressSetPosition _cP;
	_titleText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_title];
	if(_cP >= 1 OR !alive player) exitWith {};
	if(life_interrupted) exitWith {};
};

//Kill the UI display and check for various states
5 cutText ["","PLAIN"];
player playActionNow "stop";

if(!alive player) exitWith {life_action_inUse = false;};
if(life_interrupted) exitWith {life_interrupted = false; titleText[localize "STR_NOTF_ActionCancel","PLAIN"]; life_action_inUse = false;};

life_action_inUse = false;
_house animateSource [format ["Door_%1_sound_source",_door],1];
_house animate [format ["Door_%1",_door],1];

if(_mode isEqualTo 1) then {
	["ALF_Lockpick",false] spawn ALF_fnc_handleItem;
	[name player,getPlayerUID player,"MAISON",format["A lockpick une porte de maison | POS : %1 | MAISON : %2", getPos _house, typeOf _house]] remoteExec ["ALF_Server_fnc_logIt",2];
	
	// Déclenchement de l'alerte cambriolage (comme avec la perceuse)
	_house setVariable ["ALF_BreakDoor", true, true];
	// Passer la maison directement pour garantir la détection du système de sécurité
	_random = random 100;
	_alerte = false;
	if ([_house] call ALF_fnc_hasEnergy) then {
		[_house, player] spawn ALF_fnc_robberyAlert;
		_alerte = true;
	} else {
		if (_random >= 75) then {
			[_house, player] spawn ALF_fnc_robberyAlert;
			_alerte = true;
		};
	};
} else {
	[name player,getPlayerUID player,"MAISON",format["(Gendarme) A casser une porte de maison | POS : %1 | MAISON : %2", getPos _house, typeOf _house]] remoteExec ["ALF_Server_fnc_logIt",2];
};

if ((random(100) < 45) && _alerte) then {
private _ville_Proche = "Zone inconnue";
private _locs = nearestLocations [position player, ["NameLocal","NameVillage","NameCity","NameCityCapital"], 1000];
if (count _locs > 0) then {_ville_Proche = text (_locs # 0);};
["Cambriolage", format["Un Cambriolage est en cours dans la zone près de %1.", _ville_Proche]] remoteExecCall ["ALF_Server_fnc_doCopCall", 2];
};

[_house,player] remoteExecCall ["ALF_Server_fnc_copBreakDoor",2];
