#include "\ALF_Client\script_macros.hpp"
/*
Author: transfertScanner
*/
private _fauteuil_Roulant = _this # 0;

private _scanner = nearestObject [position _fauteuil_Roulant,"Land_ALF_IRM"];
if(isNull _scanner OR {isNil "_scanner"}) exitWith {["INFO", "Il n'y a pas de Scanner à proximité.", "warning"] spawn ALF_fnc_doMsg;};
if((_scanner distance _fauteuil_Roulant) > 5) exitWith {["INFO", "Il n'y a pas de Scanner à proximité.", "warning"] spawn ALF_fnc_doMsg;};
if(_scanner getVariable ["wip",false]) exitWith {["INFO", "Le Scanner est déjà utilisé.", "warning"] spawn ALF_fnc_doMsg;};

{
	if(count (_x getVariable ["MedicalStats",[]]) > 0 AND {alive _x}) exitWith 
	{
		[_scanner,player] remoteExec ["ALF_fnc_scannerSystem",_x];
	};
} forEach (crew _fauteuil_Roulant);