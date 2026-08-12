/*
	File: fn_actionPointsAdd.sqf
	Author: ALF Team
*/
/*
params [
	["_unit",objNull,[objNull]]
];
disableSerialization;
if !(createDialog "Life_point_give") exitWith {};
if (isNull _unit OR {!isPlayer _unit}) exitWith {};
ctrlSetText[2751,"Ajouter des points"];
life_pInact_curObject = _unit;

private _btn = (findDisplay 2750) displayCtrl 2753;
_btn ctrlSetText "AJOUTER";
_btn buttonSetAction "[life_pInact_curObject] call ALF_fnc_ajouterPoints;";

[name player,getPlayerUID player,"BANK",format["A donné une facture de %1€ à %2.",_amount, name life_pInact_curObject]] remoteExec ["ALF_Server_fnc_logIt",2];
*/


params [
    ["_unit", objNull, [objNull]]
];

disableSerialization;

if (isNull _unit || {!isPlayer _unit}) exitWith {};

if !(createDialog "Life_point_give") exitWith {};

ctrlSetText [2751, "Ajouter des points"];
life_pInact_curObject = _unit;

private _btn = (findDisplay 2750) displayCtrl 2753;
_btn ctrlSetText "AJOUTER";

_btn buttonSetAction "
    disableSerialization;

    private _display = findDisplay 2750;
    if (isNull _display) exitWith {};

    private _pointsStr = ctrlText (_display displayCtrl 2752);

    if !([_pointsStr] call TON_fnc_isnumber) exitWith {
        ['INFO','Montant invalide.','danger'] spawn ALF_fnc_doMsg;
    };

    private _points = parseNumber _pointsStr;
    if (_points <= 0) exitWith {
        ['INFO','Montant invalide.','danger'] spawn ALF_fnc_doMsg;
    };

    private _target = life_pInact_curObject;
    if (isNull _target || {!isPlayer _target}) exitWith {};

    [_target, _points] call ALF_fnc_ajouterPoints;

    [name player, getPlayerUID player, 'POINTS', format['A ajouté %1 points à %2.', _points, name _target]]
        remoteExec ['ALF_Server_fnc_logIt', 2];

    closeDialog 0;
";
