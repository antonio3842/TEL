private _MRPV2OBJECT = createSimpleObject ["A3\Weapons_F\Items\Toolkit.p3d",[0,0,0]]; 
_MRPV2OBJECT attachTo [player, [-0.02,0,0], "RightHandMiddle1"];
_MRPV2OBJECT setDir 0;
_MRPV2OBJECT setVectorDirAndUp [[0,0,0],[0,0,0]];
_MRPV2OBJECT setPos (getPos _MRPV2OBJECT);

private _gain = 0;

life_interrupted = false;
life_action_inUse = true;

disableSerialization;
private _display = findDisplay 46;
waitUntil { !isNull _display };

private _barW = 0.3;
private _barH = 0.04;
private _barX = safeZoneX + (safeZoneW - _barW) / 2;
private _barY = safeZoneY + (safeZoneH - _barH) / 2;

private _progressBar = _display ctrlCreate ["RscProgress", -1];
_progressBar ctrlSetPosition [_barX, _barY, _barW, _barH];
_progressBar ctrlSetBackgroundColor [0, 0, 0, 0.5];
_progressBar ctrlCommit 0;
_progressBar progressSetPosition 0;

private _upp = "Réparation de l'objet";
private _text = _display ctrlCreate ["RscStructuredText", -1];
_text ctrlSetPosition [_barX, _barY - 0.05, _barW, 0.04];
_text ctrlSetStructuredText parseText format ["<t align='center' size='1.2'>%1</t>", _upp];
_text ctrlCommit 0;

private _cP = 0;
for "_i" from 0 to 130 do {
    if (!alive player || player != vehicle player || life_interrupted) exitWith {};

    if (animationState player != "Acts_carFixingWheel") then {
        player switchMove "Acts_carFixingWheel";
        player playMoveNow "Acts_carFixingWheel";
    };

    _cP = _i / 130;
    _progressBar progressSetPosition _cP;
    sleep 0.1;
};

if (alive player and vehicle player isEqualTo player and !life_interrupted) then {
    private _objectsToRepair = nearestTerrainObjects [player, [], 10, true] select {
        damage _x > 0 and {(str _x find ": t_") isEqualTo -1}
    };
    {
        _x setDamage 0;
		_gain = _gain + 500;
    } forEach _objectsToRepair;

	_objectsToRepair = nearestObjects [player, [], 10, true] select {
        damage _x > 0 and {(str _x find "Land_O2") isNotEqualTo -1}
    };
    {
        _x setDamage 0;
		_gain = _gain + 500;
    } forEach _objectsToRepair;

    ["Réparation", "Vous avez réparé l'objet.", "success", false] spawn ALF_fnc_doMsg;
};

ctrlDelete _progressBar;
ctrlDelete _text;
life_action_inUse = false;
player playActionNow "stop";
detach _MRPV2OBJECT;    
deleteVehicle _MRPV2OBJECT;
player switchMove "";
if(life_interrupted) exitWith {life_interrupted = false; ["DIR", "Action annulée.", "danger", false] spawn ALF_fnc_doMsg;};

private _building = objNull;
{
  // Rechercher sur le bâtiment principal (Land_ALF_Entreprise) ou les concessionnaires (Land_MRP_Concessionnaire)
  if (((_x getVariable ["business",["","",""]]) select 2) isEqualTo (player getVariable ["isEmployed",""]) && {typeOf _x in ["Land_ALF_Entreprise", "Land_MRP_Concessionnaire"]}) exitWith {
		_building = _x;
	};
} forEach ALF_allBusinesss;

if (isNull _building) exitWith {};

private _var = _building getVariable ["business",[]];
private _capitalstr = _var select 3;
private _siretstr = _var select 2;

// Convertir le capital en nombre si c'est une string
if (typeName _capitalstr == "STRING") then {
	_capitalstr = parseNumber _capitalstr;
};

private _newvalue = floor(_capitalstr + _gain);
_var set[3,_newvalue];

_building setVariable ["business",_var,true];

[_siretstr,_newvalue] remoteExec ["ALF_Server_fnc_capitalBusiness",2];
