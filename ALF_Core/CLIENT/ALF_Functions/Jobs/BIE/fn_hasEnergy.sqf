/*
	File: hasEnergy
	Author: ALF Team
*/
params[
	["_object",objNull,[objNull]],
	["_isHouse",false,[false]]
];
if(isNull _object) exitWith {true};

private _transfo = ObjNull;
private _geneOk = false;
_transfo = (nearestObjects [_object,["Land_ALF_Trafo"],3000]) select 0;
_generatorBig = nearestObjects [_object,["Land_PowerGenerator_F"],250];

{
	_essence = _x getVariable ["generatorEssence", 0];
	if !(_essence <= 0) then {
		_geneOk = true;
	};
} forEach _generatorBig;

if (_object getVariable ["IsBreak", false]) exitWith {false};
if (_object getVariable ["HasCourant", false]) exitWith {true};
if (_geneOk) exitWith {true};

if (isNull _transfo) exitWith {true};

if !((_transfo animationSourcePhase "disable_source") < 0.5) exitWith {false};

true


