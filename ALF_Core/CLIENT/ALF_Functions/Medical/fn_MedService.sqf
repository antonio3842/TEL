// ALF_fnc_medService = {
if (life_medicLevel isEqualTo 0) exitWith {["INFO","Vous ne pouvez pas prendre votre service ici.","warning"] spawn ALF_fnc_doMsg;};

private _name = name player;

if (life_pompier_service) then 
{
    life_pompier_service = false;
    player setVariable ["tf_unable_to_use_radio", true];
    life_radio_connected = false;
    ALF_Sony_Freq = 0;
    ALF_Sony_FreqAdd = 0;
    [(call TFAR_fnc_activeSwRadio), 1, getPlayerUID player] call TFAR_fnc_SetChannelFrequency;
    [(call TFAR_fnc_activeSwRadio), 2, getPlayerUID player] call TFAR_fnc_SetChannelFrequency;
    private _groupe_SP = units ((groups civilian select {"Pompiers" in groupid _x}) # 0);
	if (isnil {_groupe_SP}) then {_groupe_SP = [];};

    player setVariable ["SonyFreq",0,[2] + _groupe_SP];
    player setVariable ["SonyFreqAdd",0,[2] + _groupe_SP];
    player setVariable ["MedService",life_pompier_service,true];

    ["Info",format["%1 termine son service.",_name]] remoteExecCall ["ALF_Server_fnc_doMedCall",2];
    [name player,"termine son service"] remoteExecCall ["ALF_Server_fnc_medLogIt",2];

    private _liste_veh = life_vehicles select {"Pompiers" in (toLower str ((_x getVariable ["vehicle_info_owners",["",""]]) # 0))};
    life_vehicles = life_vehicles select {!isnull _x};
    life_vehicles = life_vehicles - _liste_veh;

    [player] joinSilent grpnull;

    [1] remoteExecCall ["ALF_Server_fnc_priseService",2];
} else 
{
    life_pompier_service = true;
    player setVariable ["tf_unable_to_use_radio", false];
    player setVariable ["MedService",life_pompier_service,true];

    ["Info",format["%1 prend son service.",_name]] remoteExecCall ["ALF_Server_fnc_doMedCall",2];
    [name player,"prend son service"] remoteExecCall ["ALF_Server_fnc_medLogIt",2];

    [1] remoteExecCall ["ALF_Server_fnc_priseService",2];

    private _groupe_SP_Existe = ((groups civilian) select {groupId _x isEqualto "Pompiers"}) isnotequalto [];
    if (_groupe_SP_Existe) then
    {
        private _groupe = ((groups civilian) select {groupId _x isEqualto "Pompiers"}) # 0;
        [player] joinSilent _groupe;
    } else 
    {
        private _groupe = createGroup civilian;
        _groupe setGroupIdGlobal ["Pompiers"];
        [player] joinSilent _groupe;
    };

    [{params ["_time"]; 
        if !(life_pompier_service) exitwith {[_this # 1] call CBA_fnc_removePerFrameHandler;};   
        if (_time < time - 5) then {[] spawn ALF_fnc_paycheck;};        
    }, (15*60),time] call CBA_fnc_addPerFrameHandler;//600
};
// };