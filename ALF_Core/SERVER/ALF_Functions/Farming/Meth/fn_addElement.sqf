/*
	File: fn_addElement.sqf
	Author: ALF TEAM
*/
params [
	["_obj", objNull, [objNull]],
	["_unit",objNull,[objNull]],
	["_element", "", [""]]
];

private _c = {_x getVariable ["CopService",false]} count playableUnits;
if(_c <= 4) exitWith {["INFO", "Il n'y a pas assez de Gendarme en service.", "warning"] remoteExec ["ALF_fnc_doMsg",_unit];};//4

if(isNull _obj || _element isEqualTo "") exitWith {};
if(_obj getVariable[_element, false]) exitWith {["Meth", "Il est déjà rempli.", "warning"] remoteExec ["ALF_fnc_doMsg",_unit];};
if(!(_element in magazines _unit)) exitWith {["Meth", "Vous n'avez pas ceci sur vous.", "warning"] remoteExec ["ALF_fnc_doMsg",_unit];};
if((_element isEqualTo "ALF_Cuivre") && (_obj getVariable["ALF_Sulfate", false])) exitWith {["Meth", "Il y a déjà du Sulfate.", "warning"] remoteExec ["ALF_fnc_doMsg",_unit];};

[_element,false] remoteExec ["ALF_fnc_handleItem",_unit];

[_unit, "AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon"] remoteExec ["playMove", _unit];

if (_element isEqualTo "ALF_Pseudoephedrine") then {
	_obj animate["Liquide_1", 1];
};

if (_element isEqualTo "ALF_Cuivre") then {
	_obj setVariable["ALF_Cuivre", true];
	_obj animate["Cuivre", 1];
};
