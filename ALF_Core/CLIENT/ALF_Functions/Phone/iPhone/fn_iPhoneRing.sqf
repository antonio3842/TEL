#include "\ALF_Client\script_macros.hpp"
/*
File: fn_iPhoneRing.sqf
Author: ALF Team
Description:

*/
switch (profileNamespace getVariable ["iPhone_Ring",0]) do {
	case 0 : {[player,"iPhoneRing1"] remoteExecCall ["ALF_fnc_say3D",0];};
	case 1 : {[player,"iPhoneRing2"] remoteExecCall ["ALF_fnc_say3D",0];};
	case 2 : {[player,"iPhoneRing3"] remoteExecCall ["ALF_fnc_say3D",0];};
	case 3 : {[player,"iPhoneRing4"] remoteExecCall ["ALF_fnc_say3D",0];};
	case 4 : {[player,"iPhoneRing5"] remoteExecCall ["ALF_fnc_say3D",0];};
};
