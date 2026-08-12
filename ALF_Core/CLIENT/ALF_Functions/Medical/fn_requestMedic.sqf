#include "\ALF_Client\script_macros.hpp"
/*
	File: fn_requestMedic.sqf
*/
["SOS","DEPART VSAV !"] remoteExecCall ["ALF_Server_fnc_doMedCall",2];

player setVariable ["requestMedic",true,true];

[] spawn  {
	((findDisplay 7300) displayCtrl 7303) ctrlEnable false;
	sleep (2 * 60);
	((findDisplay 7300) displayCtrl 7303) ctrlEnable true;
};
