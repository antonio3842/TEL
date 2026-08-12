/*
	File: fn_taxi_missionUpdateMarkers.sqf
	Client — marqueurs zone + point (style DIR).
*/
if (isNil "MRP_Taxi_Mission") exitWith {};

private _markerNames = missionNamespace getVariable ["MRP_Taxi_MissionMarkerNames", []];
{
	deleteMarkerLocal _x;
} forEach _markerNames;

MRP_Taxi_Mission params ["_phase", "_pickup", "_dropoff"];

private _pos = if (_phase isEqualTo 0) then { _pickup } else { _dropoff };
private _texte = if (_phase isEqualTo 0) then { "Client en attente" } else { "Déposer le client" };
private _couleur = if (_phase isEqualTo 0) then { "ColorYellow" } else { "ColorGreen" };

private _zone = "MRP_Taxi_Mission_Zone";
private _point = "MRP_Taxi_Mission_Point";

if (_zone in allMapMarkers) then { deleteMarkerLocal _zone; };
if (_point in allMapMarkers) then { deleteMarkerLocal _point; };

createMarkerLocal [_zone, _pos];
_zone setMarkerShapeLocal "Ellipse";
_zone setMarkerSizeLocal [25, 25];
_zone setMarkerColorLocal _couleur;
_zone setMarkerBrushLocal "Border";

createMarkerLocal [_point, _pos];
_point setMarkerTypeLocal "Mil_dot";
_point setMarkerColorLocal _couleur;
_point setMarkerTextLocal _texte;

missionNamespace setVariable ["MRP_Taxi_MissionMarkerNames", [_zone, _point]];
