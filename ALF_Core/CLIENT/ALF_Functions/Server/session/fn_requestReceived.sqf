#include "\ALF_Client\script_macros.hpp"
/*
File: fn_requestreceived.sqf
AuthOR: ALF Team
*/
if !(hasinterface) exitwith {};
life_session_tries = life_session_tries + 1;
if (life_session_completed) exitwith {};
if (life_session_tries > 3) exitwith {failMission "NoBDD";};

private _data = _this select 0;
if(isnil "_data" OR {count _data isEqualto 0}) exitwith {failMission "NoBDD";};
Data_Request =_data;
if !(name player isEqualto (_data # 1)) exitwith 
{
    cuttext[fORmat["votre profil (%1) n'a pas le meme nom que votre personnage enregistré. Visa: %2.", name player, (_data # 1)], "BLACK FADED"];
    0 cutFadeOut 999999999; sleep 8; failMission "Badname";
};
if (str(_data # 31) isEqualto "2") exitwith {failMission "BlockVisa";};
if !(str(_data # 31) isEqualto "1") exitwith {failMission "BadVisa";};

life_cash = parseNumber(_data # 2);
ALF_AdminLevel = parseNumber(_data # 3);
life_donOR = _data # 4;
life_coplevel = parseNumber(_data # 5);
life_medicLevel = parseNumber(_data # 6);

if(life_coplevel > 0 && {!license_cop}) then {license_cop = true;};
if(life_mediclevel > 0 && {!license_med}) then {license_med = true;};
if(life_coplevel isEqualto 0 && {license_cop}) then {license_cop = false;};
if(life_mediclevel isEqualto 0 && {license_med}) then {license_med = false;};

if (count (_data # 7) > 0) then 
{
    {
        SVAR_MNS [SEL(_x, 0), SEL(_x, 1)];
    } fOREach (_data # 7);
};

diag_log format ["%1: fn_loadGear dans request recieved pour %3 called with %2", time, _data # 8,player];
[_data # 8] call ALF_fnc_loadGear;

life_hunger = (_data # 9) # 0;
life_thirst = (_data # 9) # 1;
if (((_data # 9) # 2) != 0) then {[(_data # 9) # 2] call ALF_fnc_handleAlcool;};
// Réinitialiser alf_drug à 0 car l'effet devrait être terminé après une déconnexion
// Si une valeur > 0 était sauvegardée, on la corrige en base de données
alf_drug = 0;
if (((_data # 9) # 3) > 0) then {
	[13] spawn SOCK_fnc_updatePartial;
};
// player setDamage ((_data # 9) # 3);

life_is_alive = _data # 10;
life_civ_position = _data # 11;

life_playerfirstjoinserver = _data # 12;
ALF_Playtime = parseNumber(_data # 13);

if(parseNumber(_data # 14) isEqualto 0 OR {parseNumber(_data # 15) isEqualto 0}) then 
{
    [player] remoteExec ["ALF_Server_fnc_createAdnface", 2];
} else 
{
    player setVariable["adnface", [(_data # 14), (_data # 15)], true];
};

life_permis = parseNumber(_data # 16);
life_axa = parseNumber(_data # 17);
life_axabank = parseNumber(_data # 18);
life_axacount = parseNumber(_data # 19);

if ((parseNumber(_data # 20)) isEqualto 0) then 
{
    life_permis_time = false;
} else 
{
    life_permis_time = true;
};

life_duredon = parseNumber(_data # 21);
life_publique = parseNumber(_data # 22);

life_axaprocount = parseNumber(_data # 24);

if (_data # 25) then 
{
    ALF_Bracelet = true;
    private _array = missionnamespace getVariable ["ALF_AllBracelets", []];
    _array pushBack player;
    missionnamespace setVariable ["ALF_AllBracelets", _array, true];
    ALF_timeBracelet = parseNumber(_data # 26) * 60;
    [] execFSM "\ALF_FSM\bracelet.fsm";
};

if (_data # 27) then 
{
    player setVariable ["ALF_EnPrison", true, true];
    ALF_Prison = true;
    ALF_timePrison = (parseNumber(_data # 28)) * 60;
    ALF_Prison_Coffre = parseNumber(_data # 29);
};

life_penit = parseNumber(_data # 30);

// groupe Sanguin
ALF_groupeSanguin = _data # 32;
if (ALF_groupeSanguin isEqualto "") then {[] call ALF_fnc_generergroupeSanguin;};

// Medical
alf_deseases = ((_data # 33) # 0);
if (isnil "alf_deseases") then {alf_deseases = [];};

alf_medecine = ((_data # 33) # 1);
if (isnil "alf_medecine") then {alf_medecine = [];};

alf_vaccins = ((_data # 33) # 2);
if (isnil "alf_vaccins") then {alf_vaccins = [];};

// Jobtime 34
if ((parseNumber(_data # 34)) isEqualto 0) then 
{
    if (license_eboueur) then 
    {
        license_eboueur = false;
        [1] call SOCK_fnc_updatePartial;
    };
};

// ORdonnance 35 36
alf_ORdonnance = [parseNumber(_data # 35), parseNumber(_data # 36)];

// Phone
if !(count (_data # 37) isEqualto 0) then 
{
    ALF_fORfait = parseNumber((_data # 37) # 0);
    ALF_Phone_Number = (_data # 37) # 1;
    life_contacts = (_data # 37) # 2;
};

// Bank System
if !(count(_data # 38) isEqualto 0) then 
{
    player setVariable ["numberBankAccount", ((_data # 38) # 0)];
    life_livreta = parseNumber((_data # 38) # 1);
    life_laactive = (_data # 38) # 2;
    life_livretb = parseNumber((_data # 38) # 3);
    life_lbactive = (_data # 38) # 4;
    life_livretc = parseNumber((_data # 38) # 5);
    life_lcactive = (_data # 38) # 6;
    life_activecb = parseNumber((_data # 38) # 7);
};

if !(count(_data # 39) isEqualto 0) then 
{
    if (count(_data # 39) isEqualto 4) then 
    {
        [0, (_data # 39) # 0, (_data # 39) # 1, (_data # 39) # 2, (_data # 39) # 3] call ALF_fnc_initBusinessplayer;
    } else 
    {
        [0, (_data # 39) # 0, (_data # 39) # 1, [], (_data # 39) # 3] call ALF_fnc_initBusinessplayer;
    };
};

if !(count(_data # 40) isEqualto 0) then {[(_data # 40)] call ALF_fnc_initKeystime;};

if !(count(_data # 41) isEqualto 0) then 
{
    {
        _marker = createMarkerlocal [(_x # 0), (_x # 2)];
        _marker setMarkertextLocal (_x # 1);
        _marker setMarkerDirLocal (_x # 3);
        _marker setMarkersizeLocal (_x # 4);
        _marker setMarkertypeLocal (_x # 5);
        _marker setMarkerShapeLocal (_x # 6);
        _marker setMarkerBrushLocal (_x # 7);
        _marker setMarkerColORLocal (_x # 8);
        _marker setMarkerAlphaLocal (_x # 9);
    } fOREach (_data # 41);
};

life_session_completed = true;