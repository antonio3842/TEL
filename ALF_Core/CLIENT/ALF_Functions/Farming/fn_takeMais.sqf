private _obj = _this select 0;

if !(_obj animationSourcePhase "et_4_source" isEqualTo 0) exitWith {};
if !(player canAdd "ALF_Mais") exitWith {["Mais", "Vous n'avez pas assez de place.", "warning", false] spawn ALF_fnc_doMsg;};

deleteVehicle _obj;
["ALF_Mais",true] spawn ALF_fnc_handleItem;

[0,3] spawn ALF_fnc_addXP;
