#include "\ALF_Client\script_macros.hpp"
/*
File: fn_refuelCar.sqf
Author: ALF Team
*/
private ["_item","_vehicle","_jerry"];
_item = _this select 0;
_vehicle = cursorObject;
if(isNull _vehicle) exitWith {};

private _info_Modele = tolowerANSI ((getModelInfo _vehicle) # 0);
if ((tolowerANSI "powergenerator_f" in _info_Modele) || (tolowerANSI "portable_generator_f" in _info_Modele)) exitWith {
	[4,_vehicle,_item] spawn ALF_fnc_poseGenerator;
};

private _info_Modele = tolowerANSI ((getModelInfo _vehicle) # 0);
hint "AVANT IF"; 
if ((tolowerANSI "powergenerator_f" in _info_Modele) || (tolowerANSI "portable_generator_f" in _info_Modele)) exitWith {
	hint "EXIT OK"; 
	[4,_vehicle,_item] spawn ALF_fnc_poseGenerator;
};

if !(_vehicle isKindOf "Car" OR _vehicle isKindOf "Air" OR _vehicle isKindOf "Ship") exitWith {};
if(player distance _vehicle > 8) exitWith {};
if(fuel _vehicle isEqualTo 1) exitWith {["Bidon", "Ce véhicule est déjà plein.", "danger"] spawn ALF_fnc_doMsg;};

life_interrupted = false;
life_action_inUse = true;

[_item,false] spawn ALF_fnc_handleItem;

_jerry = "Land_CanisterFuel_F" createVehicle [0,0,0];
_jerry attachto [player, [0.02,0,-0.27], "RightHandMiddle1"];
_jerry setDir 270;
[player,"ALF_action_refuel"] remoteExecCall ["ALF_fnc_say3D",0];

private _displayName = getText(configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName");

private _upp = format["Remplissage: %1",_displayName];
disableSerialization;
5 cutRsc ["life_progress","PLAIN"];
private _ui = uiNameSpace getVariable "life_progress";
private _progress = _ui displayCtrl 38201;
private _pgText = _ui displayCtrl 38202;
_pgText ctrlSetText format["%2 (1%1)...","%",_upp];
_progress progressSetPosition 0.01;
private _cP = 0.01;

for "_i" from 0 to 1 step 0 do {
	if(animationState player != "AinvPknlMstpSnonWnonDnon_medic_1") then {
		//[player,"AinvPknlMstpSnonWnonDnon_medic_1",true] remoteExecCall ["ALF_fnc_animSync",RCLIENT];
		player switchMove "AinvPknlMstpSnonWnonDnon_medic_1";
		player playMoveNow "AinvPknlMstpSnonWnonDnon_medic_1";
	};
	sleep 0.27;
	_cP = _cP + 0.01;
	_progress progressSetPosition _cP;
	_pgText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_upp];
	if(_cP >= 1) exitWith {};
	if(!alive player) exitWith { detach _jerry; deletevehicle _jerry;};
	if(life_interrupted) exitWith {detach _jerry; deletevehicle _jerry;};
	if(life_istazed) exitWith {detach _jerry; deletevehicle _jerry;};
};
life_action_inUse = false;
5 cutText ["","PLAIN"];
player playActionNow "stop";
if(!alive player) exitWith {};
if(life_interrupted) exitWith {life_interrupted = false; [_item,true] spawn ALF_fnc_handleItem; ["Baril", "Action annulée.", "danger", false] spawn ALF_fnc_doMsg;};
if(life_istazed) exitWith {};

switch (true) do
{
	case (_item == "ALF_Barile_10"):
	{
		if(!local _vehicle) then
		{
			[_vehicle,(Fuel _vehicle) + 0.1] remoteExec ["ALF_fnc_setFuel",_vehicle];
		}
			else
		{
			_vehicle setFuel ((Fuel _vehicle) + 0.1);
		};
	};
	
	case (_item == "ALF_Barile_20"):
	{
		if(!local _vehicle) then
		{
			[_vehicle,(Fuel _vehicle) + 0.15] remoteExec ["ALF_fnc_setFuel",_vehicle];
		}
			else
		{
			_vehicle setFuel ((Fuel _vehicle) + 0.15);
		};
	};
	
	case (_item == "ALF_Barile_30"):
	{
		if(!local _vehicle) then
		{
			[_vehicle,(Fuel _vehicle) + 0.15] remoteExec ["ALF_fnc_setFuel",_vehicle];
		}
			else
		{
			_vehicle setFuel ((Fuel _vehicle) + 0.15);
		};
	};
	
	case (_item == "ALF_Barile_40"):
	{
		if(!local _vehicle) then
		{
			[_vehicle,(Fuel _vehicle) + 0.18] remoteExec ["ALF_fnc_setFuel",_vehicle];
		}
			else
		{
			_vehicle setFuel ((Fuel _vehicle) + 0.18);
		};
	};
	
	case (_item == "ALF_Barile_50"):
	{
		if(!local _vehicle) then
		{
			[_vehicle,(Fuel _vehicle) + 0.2] remoteExec ["ALF_fnc_setFuel",_vehicle];
		}
			else
		{
			_vehicle setFuel ((Fuel _vehicle) + 0.2);
		};
	};
	
	case (_item == "ALF_Barile_60"):
	{
		if(!local _vehicle) then
		{
			[_vehicle,(Fuel _vehicle) + 0.2] remoteExec ["ALF_fnc_setFuel",_vehicle];
		}
			else
		{
			_vehicle setFuel ((Fuel _vehicle) + 0.2);
		};
	};
	
	case (_item == "ALF_Barile_70"):
	{
		if(!local _vehicle) then
		{
			[_vehicle,(Fuel _vehicle) + 0.22] remoteExec ["ALF_fnc_setFuel",_vehicle];
		}
			else
		{
			_vehicle setFuel ((Fuel _vehicle) + 0.22);
		};
	};
	
	case (_item == "ALF_Barile_80"):
	{
		if(!local _vehicle) then
		{
			[_vehicle,(Fuel _vehicle) + 0.25] remoteExec ["ALF_fnc_setFuel",_vehicle];
		}
			else
		{
			_vehicle setFuel ((Fuel _vehicle) + 0.25);
		};
	};
	
	case (_item == "ALF_Barile_90"): {
		if(!local _vehicle) then {
			[_vehicle,(Fuel _vehicle) + 0.28] remoteExec ["ALF_fnc_setFuel",_vehicle];
		} else {
			_vehicle setFuel ((Fuel _vehicle) + 0.28);
		};
	};
	
	case (_item == "ALF_Barile_100"): {
		if ((_vehicle isKindOf "AIR") || (_vehicle isKindOf "BOAT")) then {
			if (!local _vehicle) then {
				[_vehicle,1] remoteExec ["ALF_fnc_setFuel",_vehicle];
			} else {
				_vehicle setFuel 1;
			};
		} else {
			if (!local _vehicle) then {
				[_vehicle,((Fuel _vehicle) + 0.3)] remoteExec ["ALF_fnc_setFuel",_vehicle];
			} else {
				_vehicle setFuel ((Fuel _vehicle) + 0.3);
			};
		};
	};
};

detach _jerry;
deletevehicle _jerry;

["Bidon", "Vous avez vidé votre bidon.", "success", false] spawn ALF_fnc_doMsg;
["ALF_Barile_0",true] spawn ALF_fnc_handleItem;
