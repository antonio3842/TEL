/*
	serviceIncendie
*/

if (ALF_fireON) then {
	ALF_fireON = false;
	publicVariable "ALF_fireON";
	["INCENDIE","Vous n'êtes plus disponible pour les feux !"] call ALF_Server_fnc_doMedCall;
} else {
	ALF_fireON = true;
	publicVariable "ALF_fireON";
	["INCENDIE","Vous êtes disponible pour les feux !"] call ALF_Server_fnc_doMedCall;
};
