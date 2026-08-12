/*
	SYSTÈME ENDURANCE DÉSACTIVÉ - Variable alf_niv_endurance non initialisée
	Pour réactiver : supprimer le exitWith et réactiver fn_addXP.sqf
*/

// SYSTÈME ENDURANCE DÉSACTIVÉ
exitWith {};

switch (alf_niv_endurance) do {
	case 0: { player setAnimSpeedCoef 1; };
	case 1: { player setAnimSpeedCoef 1.02; };
	case 2: { player setAnimSpeedCoef 1.04; };
	case 3: { player setAnimSpeedCoef 1.06; };
	case 4: { player setAnimSpeedCoef 1.08; };
	case 5: { player setAnimSpeedCoef 1.10; };
};
