#include "\ALF_Client\script_macros.hpp"
/*
  File: fn_couperWeed.sqf
  ALF Nanou
*/

private _mode = _this select 0;
switch (_mode) do {
	case 0 : {
		for "_i" from 1 to 5 step 1 do {
			["ALF_Weed",false] spawn ALF_fnc_handleItem;
		};
		["ALF_Weed_P",true] spawn ALF_fnc_handleItem;
	};
	case 1 : {
		for "_i" from 1 to 5 step 1 do {
			["ALF_Weed_2",false] spawn ALF_fnc_handleItem;
		};
		["ALF_Weed_P_2",true] spawn ALF_fnc_handleItem;
	};
	case 2 : {
		for "_i" from 1 to 5 step 1 do {
			["ALF_Weed_3",false] spawn ALF_fnc_handleItem;
		};
		["ALF_Weed_P_3",true] spawn ALF_fnc_handleItem;
	};
};

[3,3] spawn ALF_fnc_addXP;
