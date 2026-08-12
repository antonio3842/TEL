/*
// ALF_fnc_CopService = {
if (life_copLevel isEqualTo 0) exitWith {["INFO","Vous ne pouvez pas prendre votre service ici.","warning"] spawn ALF_fnc_doMsg;};

private _name = name player;

if (life_gendarme_service) then 
{
    life_gendarme_service = false;
    player setVariable ["tf_unable_to_use_radio", true];
    life_radio_connected = false;
    ALF_Sony_Freq = 0;
    ALF_Sony_FreqAdd = 0;

    [(call TFAR_fnc_activeSwRadio), 1, getPlayerUID player] call TFAR_fnc_SetChannelFrequency;
    [(call TFAR_fnc_activeSwRadio), 2, getPlayerUID player] call TFAR_fnc_SetChannelFrequency;
    private _groupe_GN = units ((groups civilian select {"Gendarmerie" in groupid _x}) # 0);
	if (isnil {_groupe_GN}) then {_groupe_GN = [];};

    player setVariable ["SonyFreq",0,[2] + _groupe_GN];
    player setVariable ["SonyFreqAdd",0,[2] + _groupe_GN];
    ["Info",format["%1 termine son service.",_name]] remoteExecCall ["ALF_Server_fnc_doCopCall",2];
    [name player,"termine son service"] remoteExecCall ["ALF_Server_fnc_copLogIt",2];
    player setVariable ["CopService",life_gendarme_service,2];
    [0] remoteExecCall ["ALF_Server_fnc_priseService",2];

    private _liste_veh = life_vehicles select {"gendarmerie" in (toLower str ((_x getvariable ["vehicle_info_owners",["",""]]) # 0))};
    life_vehicles = life_vehicles select {!isnull _x};
    life_vehicles = life_vehicles - _liste_veh;

    [player] joinSilent grpnull;
} else 
{
    life_gendarme_service = true;
    player setVariable ["CopService",life_gendarme_service,2];
    
    ["Info",format["%1 prend son service.",_name]]remoteExecCall ["ALF_Server_fnc_doCopCall",2];
    [name player,"prend son service"] remoteExecCall ["ALF_Server_fnc_copLogIt",2];
    [0] remoteExecCall ["ALF_Server_fnc_priseService",2];

    [player] call MRPV2_fnc_charactersEH;
    
    private _groupe_SP_Existe = ((groups civilian) select {groupId _x isEqualto "Gendarmerie"}) isnotequalto [];
    if (_groupe_SP_Existe) then
    {
        private _groupe = ((groups civilian) select {groupId _x isEqualto "Gendarmerie"}) # 0;
        [player] joinSilent _groupe;
    } else 
    {
        private _groupe = createGroup civilian;
        _groupe setGroupIdGlobal ["Gendarmerie"];
        [player] joinSilent _groupe;
    };

    [{params ["_time"]; 
        if !(life_gendarme_service) exitwith {[_this # 1] call CBA_fnc_removePerFrameHandler;};   
        if (_time < time - 5) then {[] spawn ALF_fnc_paycheck;};        
    }, (15*60),time] call CBA_fnc_addPerFrameHandler;//600

};
// };
*/



//ALF_fnc_CopService = {


if (life_copLevel isEqualTo 0) exitWith {
    ["INFO","Vous ne pouvez pas prendre votre service ici.","warning"] spawn ALF_fnc_doMsg;
};

private _name = name player;

if (life_gendarme_service) then 
{
    life_gendarme_service = false;
    player setVariable ["tf_unable_to_use_radio", true];
    life_radio_connected = false;
    ALF_Sony_Freq = 0;
    ALF_Sony_FreqAdd = 0;

    [(call TFAR_fnc_activeSwRadio), 1, getPlayerUID player] call TFAR_fnc_SetChannelFrequency;
    [(call TFAR_fnc_activeSwRadio), 2, getPlayerUID player] call TFAR_fnc_SetChannelFrequency;

    private _groupe_GN = units ((groups civilian select {"Gendarmerie" in groupid _x}) # 0);
    if (isnil {_groupe_GN}) then {_groupe_GN = [];};

    player setVariable ["SonyFreq",0,[2] + _groupe_GN];
    player setVariable ["SonyFreqAdd",0,[2] + _groupe_GN];

    ["Info", format["%1 termine son service.", _name]] remoteExecCall ["ALF_Server_fnc_doCopCall", 2];
    [name player, "termine son service"] remoteExecCall ["ALF_Server_fnc_copLogIt", 2];

    player setVariable ["CopService", life_gendarme_service, true];

    [0] remoteExecCall ["ALF_Server_fnc_priseService", 2];

    private _liste_veh = life_vehicles select {
        "gendarmerie" in toLower str ((_x getVariable ["vehicle_info_owners", ["", ""]]) # 0)
    };
    life_vehicles = life_vehicles select {!isnull _x};
    life_vehicles = life_vehicles - _liste_veh;

    [player] joinSilent grpnull;
} 
else
{
    life_gendarme_service = true;
    player setVariable ["CopService", life_gendarme_service, true];

    if (!isNil "license_PSIG_Sabre" && {license_PSIG_Sabre}) then {
        player setVariable ["license_PSIG_Sabre", true, true];
        diag_log format ["[WL DEBUG] %1 → licence PSIG_Sabre synchronisée au serveur à la prise de service.", name player];
    };

    ["Info", format["%1 prend son service.", _name]] remoteExecCall ["ALF_Server_fnc_doCopCall", 2];
    [name player, "prend son service"] remoteExecCall ["ALF_Server_fnc_copLogIt", 2];

    [0] remoteExecCall ["ALF_Server_fnc_priseService", 2];
    [player] call MRPV2_fnc_charactersEH; 

    private _groupe_SP_Existe = ((groups civilian) select {groupId _x isEqualTo "Gendarmerie"}) isNotEqualTo [];
    if (_groupe_SP_Existe) then {
        private _groupe = ((groups civilian) select {groupId _x isEqualTo "Gendarmerie"}) # 0;
        [player] joinSilent _groupe;
    } else {
        private _groupe = createGroup civilian;
        _groupe setGroupIdGlobal ["Gendarmerie"];
        [player] joinSilent _groupe;
    };

    [{params ["_time"]; 
        if !(life_gendarme_service) exitWith {[_this # 1] call CBA_fnc_removePerFrameHandler;};   
        if (_time < time - 5) then {[] spawn ALF_fnc_paycheck;};        
    }, (15 * 60), time] call CBA_fnc_addPerFrameHandler;
};


// };

