// ALF_fnc_adminRevived = {
closeDialog 0;
life_deathCamera cameraEffect ["TERMINATE","BACK"];
camDestroy life_deathCamera;

alf_death_effect ppEffectEnable false;
ppEffectDestroy alf_death_effect;

player setUnconscious true;

life_radio_connected = false;
ALF_Sony_Freq = 0;
player setVariable ["SonyFreq",0,2];
ALF_Sony_FreqAdd = 0;
player setVariable ["SonyFreqAdd",0,2];

player setVariable ["Reviving",nil,true];
player setVariable ["tf_voiceVolume", 1, true];
player setVariable ["ReviveMedic",false,true];
player setVariable ["requestMedic",false,true];

if (ALF_Bracelet) then 
{
	_array = missionNamespace getVariable ["ALF_AllBracelets",[]];
	if !(player in _array) then 
	{
		_array pushBack player;
		missionNamespace setVariable ["ALF_AllBracelets",_array,true];
	};
};

if (ALF_Prison) then {player setVariable ["ALF_EnPrison",true,true];};

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

if(life_penit > 0) then {player setVariable ["PenitService",life_penit_service,true];};

alf_ms_active = false;
alf_ms_isdead = false;

life_is_alive = true;
life_hunger = 100;
life_thirst = 100;

alf_ms_bpm = 80;
alf_ms_mmHg = 120;
alf_ms_resp = 15;
alf_ms_spo2 = 97;
alf_ms_pain = 0;
alf_ms_bleeding = false;
alf_ms_bouteille = false;

player setVariable ["bouteilleo2",alf_ms_bouteille,2];
player setVariable ["MedicalStats",[],true];
player setdamage 0;
player setUnconscious false;
player allowDamage true;
call ALF_fnc_incendie_initPlayer;

[player,"AmovPpneMstpSrasWrflDnon"] remoteExecCall ["ALF_fnc_animSync",0];
[] call SOCK_fnc_updateRequest;
// };