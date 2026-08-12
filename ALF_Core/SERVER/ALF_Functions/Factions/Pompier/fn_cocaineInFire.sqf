#include "\ALF_Core\SERVER\script_macros.hpp"
/*
	cocaineInFire
*/
private _obj = _this select 0;
if (isNull _obj) exitWith {};
private _hs = nearestObjects [position _obj, ["Land_i_House_Big_01_V1_F", "Land_i_House_Big_01_V2_F", "Land_i_House_Big_01_V3_F", "Land_i_House_Big_01_b_white_F", "Land_i_House_Big_01_b_brown_F", "Land_i_House_Big_01_b_blue_F", "Land_i_House_Big_01_b_whiteblue_F", "Land_i_House_Big_01_b_pink_F", "Land_i_House_Big_02_V1_F", "Land_i_House_Big_02_V2_F", "Land_i_House_Big_02_V3_F", "Land_i_House_Big_02_b_blue_F", "Land_i_House_Big_02_b_white_F", "Land_i_House_Big_02_b_whiteblue_F", "Land_i_House_Big_02_b_yellow_F", "Land_i_House_Big_02_b_brown_F", "Land_i_House_Big_02_b_pink_F", "Land_House_Big_02_F", "Land_House_Big_03_F", "Land_i_House_Small_03_V1_F", "Land_i_House_Small_02_V1_F", "Land_i_House_Small_02_V2_F", "Land_i_House_Small_02_V3_F", "Land_i_House_Small_01_V1_F", "MRP_Wooden_House_03_F", "Land_i_House_Small_01_V2_F", "Land_i_House_Small_01_V3_F", "Land_House_Big_01_F", "Land_i_Stone_HouseSmall_V2_F", "Land_i_Stone_HouseSmall_V3_F", "Land_i_Stone_HouseSmall_V1_F", "Land_House_Small_02_F", "Land_HouseA", "Land_HouseB", "Land_HouseC", "Land_HouseD", "Land_Hotel_02_F"], 50];
if !(_hs isEqualTo []) then {
	private _h = _hs select 0;
	if !(isNil {
		_h getVariable "house_owner"
	}) then {
		[_h] spawn ALF_Server_fnc_burn_building;
		[_h] spawn {
			private _h = _this select 0;
			uiSleep 1500;
			if (_h getVariable ["IsOnfire", false]) then {
				// [_h] remoteExecCall ["ALF_Server_fnc_sellHousemobilier", hc_2];
				[_h] call ALF_Server_fnc_sellHousemobilier;
				_h setDamage 1;
			};
		};
	};
};