#include "\ALF_Client\script_macros.hpp"
/*
  File: fn_interactMeth.sqf
  ALF Team
*/
params[
	["_obj",objNull,[objNull]],
	["_mode",0,[0]],
	["_arg","",[""]]
];

switch (_mode) do {
	case 0 : {
		[_obj,player,_arg] remoteExecCall ["ALF_Server_fnc_addElement",2];
	};
	case 1 : {
		[_obj,player] remoteExec ["ALF_Server_fnc_startSynthese",2];
	};
	case 2 : {
		[_obj,player] remoteExec ["ALF_Server_fnc_startPillon",2];
	};
	case 3 : {
		[_obj,player] remoteExec ["ALF_Server_fnc_startCrystalise",2];
	};
	case 4 : {
		[_obj,player] remoteExecCall ["ALF_Server_fnc_recupMeth",2];
	};
};