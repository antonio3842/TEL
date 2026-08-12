/*
	File: fn_distrib_updateMapMarker.sqf
	Met à jour la couleur du marqueur local d'une machine (distributeurs en service).
*/
params [["_machine", objNull, [objNull]]];

if (isNull _machine || {!MRP_Distrib_EnService}) exitWith {};

private _markerName = _machine getVariable ["MRP_Distrib_MarkerName", ""];
if (_markerName isEqualTo "" || {!(_markerName in allMapMarkers)}) exitWith {};

private _stock = _machine getVariable ["MRP_Distrib_Stock", createHashMap];
if (_stock isEqualType []) then { _stock = createHashMap; };

private _color = [_stock] call ALF_fnc_distrib_getMarkerColor;
_markerName setMarkerColorLocal _color;
