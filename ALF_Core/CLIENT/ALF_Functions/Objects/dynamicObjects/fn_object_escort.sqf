_object = [_this,0,objNull,[objNull]] call BIS_fnc_param;

if (isNull _object) exitWith {};

alf_object = _object;
private _attachToC = ["ARRAY", ["ALF_OBJECTS", typeOf(_object), "attachTo"]] call ALFTools_Client_Config_fnc_getConfig;
_object attachTo [player,_attachToC];

private _action1 = player addAction ["Placer",{
	detach alf_object;
	if !(alf_object isKindOf "Lamps_base_F") then {alf_object enableSimulation false;};
	{_x disableCollisionWith alf_object;} forEach (nearestObjects [getPos alf_object,["Car","Air","Ship"],5]);
},"",9999,true,true,"",'!isNull alf_object'];

waitUntil {((isNull _object) || (isNull (attachedTo _object)))};

alf_object = objNull;
player removeAction _action1;