// ALF_fnc_PenitService = {
#include "\ALF_Client\script_macros.hpp"
private _name = name player;

if (life_penit_service) then 
{
    life_penit_service = false;
    // player setVariable ["tf_unable_to_use_radio", true];
    // life_radio_connected = false;
    // ALF_Sony_Freq = 0;
    // ALF_Sony_FreqAdd = 0;

    // [(call TFAR_fnc_activeSwRadio), 1, getPlayerUID player] call TFAR_fnc_SetChannelFrequency;
    // [(call TFAR_fnc_activeSwRadio), 2, getPlayerUID player] call TFAR_fnc_SetChannelFrequency;
    private _groupe_APPM = units ((groups civilian select {"policemunicipale" in groupid _x}) # 0);
	if (isnil {_groupe_APPM}) then {_groupe_APPM = [];};

    // player setVariable ["SonyFreq",0,[2] + _groupe_APPM];
    // player setVariable ["SonyFreqAdd",0,[2] + _groupe_APPM];
    // ["Info",format["%1 termine son service.",_name]] remoteExecCall ["ALF_Server_fnc_doCopCall",2];
    // [name player,"termine son service"] remoteExecCall ["ALF_Server_fnc_copLogIt",2];
    player setVariable ["PenitService",life_penit_service,true];
    [0] remoteExecCall ["ALF_Server_fnc_priseService",2];

    private _liste_veh = life_vehicles select {"policemunicipale" in (toLower str ((_x getvariable ["vehicle_info_owners",["",""]]) # 0))};
    life_vehicles = life_vehicles select {!isnull _x};
    life_vehicles = life_vehicles - _liste_veh;

    [player] joinSilent grpnull;
} else
{
    life_penit_service = true;
    player setVariable ["PenitService",life_penit_service,true];

     ["Info",format["%1 prend son service.",_name]]remoteExecCall ["ALF_Server_fnc_doPenitCall",2];
    // [name player,"prend son service"] remoteExecCall ["ALF_Server_fnc_copLogIt",2];
    [0] remoteExecCall ["ALF_Server_fnc_priseService",2];

    [player] call MRPV2_fnc_charactersEH;
    
    private _groupe_SP_Existe = ((groups civilian) select {groupId _x isEqualto "policemunicipale"}) isnotequalto [];
    if (_groupe_SP_Existe) then
    {
        private _groupe = ((groups civilian) select {groupId _x isEqualto "policemunicipale"}) # 0;
        [player] joinSilent _groupe;
    } else 
    {
        private _groupe = createGroup civilian;
        _groupe setGroupIdGlobal ["policemunicipale"];
        [player] joinSilent _groupe;
    };

    [{params ["_time"]; 
        if !(life_penit_service) exitwith {[_this # 1] call CBA_fnc_removePerFrameHandler;};   
        if (_time < time - 5) then {[] spawn ALF_fnc_paycheck;};        
    }, (15*60),time] call CBA_fnc_addPerFrameHandler;//600

};

[1] call SOCK_fnc_updatePartial;
// };
// ["Corps de direction.",format["%1",_msg2]] remoteExecCall ["ALF_Server_fnc_doPenitCall",2];
// };


// #include "\ALF_Client\script_macros.hpp"
// /*
//     File: fn_penitSetLic.sqf
//     Author: ALF Team Dev
// */
// private _mode = _this select 0;
// private _cop = _this select 1;
// private _msg = "";
// private _msg2 = "";
// private _name = name player;

// if(life_penit isEqualTo 0) exitWith {["INFO","Cette personne n'est pas Agent penitencier.", "success"] remoteExec ["ALF_fnc_doMsg",_cop];};

// private _varnameConfig = ["STRING", ["Licenses", _mode, "variable"]] call ALFTools_Client_Config_fnc_getConfig;
// private _level = missionNamespace getVariable [format["license_%1",_varnameConfig], false];
// if(_level) exitWith {["INFO","Cette personne a déjà cette licence.", "success"] remoteExec ["ALF_fnc_doMsg",_cop];};

// switch (_mode) do {
//     case "medWork" : {
//         license_medWork = true;
//         _msg = "Tu es devenu Medécin du travail.";
//         _msg2 = format["%1 est devenu Medécin du travail.",_name];
//     }; 
//     case "NOmedWork" : {
//         license_medWork = false;
//         _msg = "Tu n'est plus Medécin du travail.";
//         _msg2 = format["%1 n'est plus Medécin du travail.",_name];
//     };
//     case "eris" : {
//         license_eris = true;
//         _msg = "Tu es devenu ERIS.";
//         _msg2 = format["%1 est devenu ERIS.",_name];
//     }; 
//     case "NOeris" : {
//         license_eris = false;
//         _msg = "Tu n'est plus ERIS.";
//         _msg2 = format["%1 n'est plus ERIS.",_name];
//     };
//     case "cynoAP" : {
//         license_cynoAP = true;
//         _msg = "Tu es devenu CYNO.";
//         _msg2 = format["%1 est devenu CYNO.",_name];
//     }; 
//     case "NOcynoAP" : {
//         license_cynoAP = false;
//         _msg = "Tu n'est plus CYNO.";
//         _msg2 = format["%1 n'est plus CYNO.",_name];
//     };
// };
// [1] call SOCK_fnc_updatePartial;

// ["INFO",format["%1",_msg],"success"] spawn ALF_fnc_doMsg;

// //Annonce pour tous les AP
// ["Corps de direction.",format["%1",_msg2]] remoteExecCall ["ALF_Server_fnc_doPenitCall",2];
