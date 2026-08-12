// #include "\ALF_Client\script_macros.hpp"
// /*
// 	File: fn_publiqueservice.sqf
// 	ALF Nanou
// */
// ALF_fnc_PubliqueService = {
if(life_publique isEqualTo 0) exitWith {["INFO","Vous ne pouvez pas prendre votre service ici.","warning"] spawn ALF_fnc_doMsg;};
private _name = name player;
if(life_publique_service) then 
{
	life_publique_service = false;
	["Info",format["%1 termine son service.",_name],"warning"] spawn ALF_fnc_doMsg;
	[name player,getPlayerUID player,"SERVICE","termine son service."] remoteExec ["ALF_Server_fnc_logIt",2];

	 [player] joinSilent grpnull;
} else 
{
	life_publique_service = true;
	["Info",format["%1 prend son service.",_name],"success"] spawn ALF_fnc_doMsg;
	[name player,getPlayerUID player,"SERVICE","prend son service."] remoteExec ["ALF_Server_fnc_logIt",2];

	[{params ["_time"];
        if !(life_publique_service) exitwith {[_this # 1] call CBA_fnc_removePerFrameHandler;};
		if (_time < time - 5) then {[] spawn ALF_fnc_paycheck;};
    }, (15*60),time] call CBA_fnc_addPerFrameHandler;//600
};
// };
