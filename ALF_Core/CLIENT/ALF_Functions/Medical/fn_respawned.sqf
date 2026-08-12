/*
	File: fn_respawned.sqf
	Author: ALF TEAM
*/
private["_handle"];

life_use_atm = true;
life_hunger = 100;
life_thirst = 100;
life_drunk = 0;
if !(ALF_Prison) then {
	_handle = [player] spawn ALF_fnc_dropItems;
	waitUntil {scriptDone _handle};
	life_cash = 0;
};
life_respawned = false;

//EN VIE
life_is_alive = true;

alf_ms_active = false;
alf_ms_isdead = false;

if (lifeState player isEqualTo "INCAPACITATED") then {
	player setUnconscious false;
};

player allowDamage true;

alf_ms_bpm = 80;
alf_ms_mmHg = 120;
alf_ms_resp = 15;
alf_ms_spo2 = 97;
alf_ms_pain = 0;
alf_ms_bleeding = false;
alf_ms_bouteille = false;
player setVariable ["bouteilleo2",alf_ms_bouteille,2];

alf_death_effect ppEffectEnable false;
ppEffectDestroy alf_death_effect;

player setVariable ["MedicalStats",[],true];

if (life_radio_connected) then {
	life_radio_connected = false;
	ALF_iPhone_Freq = 0;
	player setVariable ["tf_unable_to_use_radio", true];
	[(call TFAR_fnc_activeSwRadio), 1, getPlayerUID player] call TFAR_fnc_SetChannelFrequency;
};
ALF_Sony_Freq = 0;
player setVariable ["SonyFreq",0,2];
ALF_Sony_FreqAdd = 0;
player setVariable ["SonyFreqAdd",0,2];

player setVariable ["tf_voiceVolume", 1, true];
player setVariable ["ReviveMedic",false,true];
alf_deseases = [];
alf_medecine = [];
alf_vaccins = [];

player setVariable ["Reviving",nil,true];

//Load gear for a 'new life'
_handle = [] spawn ALF_fnc_civLoadout;
waitUntil {sleep 0.3; scriptDone _handle};

//Cleanup of weapon containers near the body & hide it.
private _containers = nearestObjects[player,["WeaponHolderSimulated"],5];
{deleteVehicle _x;} forEach _containers; //Delete the containers.

//Destroy our camera...
life_deathCamera cameraEffect ["TERMINATE","BACK"];
camDestroy life_deathCamera;

//Bad boy
if (ALF_Prison) exitWith {
	player setVariable ["ALF_EnPrison",true,true];
	player setPosATL [11029.246,3926.061,0.269];
	// Ajouter la position de base
	[] call SOCK_fnc_updateRequest;
};

if(life_coplevel > 0) then 
{
	private _groupe_GN = units ((groups civilian select {"Gendarmerie" in groupid _x}) # 0);
	if (isnil {_groupe_GN}) then {_groupe_GN = [];};

    player setVariable ["SonyFreq",0,[2] + _groupe_GN];
    player setVariable ["SonyFreqAdd",0,[2] + _groupe_GN];
	player setVariable ["CopService",life_gendarme_service,true];
	[0] remoteExecCall ["ALF_Server_fnc_priseService",2];
};
if(life_mediclevel > 0) then
{
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
if(ALF_AdminLevel > 1) then {
	player addAction ["Cheveux Noirs", {player setObjectTextureGlobal [0, "\ALF_Perso\textures\T_Chr0010_hair_C.paa"]}, "", 4, true, true, "", "(uniform player) == ""U_ALF_Vegeta"""];
	player addAction ["Cheveux Jaunes", {[] spawn {_smoke = createVehicle ["SmokeShellYellow", (getPos player), [], 0, "CAN_COLLIDE"]; _smoke attachTo [player, [0, 0, -0.1], ""]; uisleep 6; deleteVehicle _smoke; uisleep 2; player setObjectTextureGlobal [0, "\ALF_Perso\textures\T_Chr0010_hair_C_Yellow.paa"]; player say3D ["son1", 20, 1,false];}}, "", 3, true, true, "", "(uniform player) == ""U_ALF_Vegeta"""];
	player addAction ["Cheveux Rouges", {[] spawn {_smoke = createVehicle ["SmokeShellRed", (getPos player), [], 0, "CAN_COLLIDE"]; _smoke attachTo [player, [0, 0, -0.1], ""]; uisleep 6; deleteVehicle _smoke; uisleep 2; player setObjectTextureGlobal [0, "\ALF_Perso\textures\T_Chr0010_hair_C_Red.paa"]; player say3D ["son1", 20, 1,false];}}, "", 2, true, true, "", "(uniform player) == ""U_ALF_Vegeta"""];
	player addAction ["Cheveux Bleus", {[] spawn {_smoke = createVehicle ["SmokeShellBlue", (getPos player), [], 0, "CAN_COLLIDE"]; _smoke attachTo [player, [0, 0, -0.1], ""]; uisleep 6; deleteVehicle _smoke; uisleep 2; player setObjectTextureGlobal [0, "\ALF_Perso\textures\T_Chr0010_hair_C_Blue.paa"]; player say3D ["son1", 20, 1,false];}}, "", 1, true, true, "", "(uniform player) == ""U_ALF_Vegeta"""];
};

call ALF_fnc_incendie_initPlayer;

//SAUVEGARDE TOTAL.
[] call SOCK_fnc_updateRequest;
