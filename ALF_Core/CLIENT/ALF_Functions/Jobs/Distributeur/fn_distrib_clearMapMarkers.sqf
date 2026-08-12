/*
	File: fn_distrib_clearMapMarkers.sqf
	Supprime tous les marqueurs carte du métier distributeur.
*/
private _markerNames = missionNamespace getVariable ["MRP_Distrib_MarkerNames", []];

{
	deleteMarkerLocal _x;
} forEach _markerNames;

{
	if (!isNull _x) then {
		_x setVariable ["MRP_Distrib_MarkerName", nil, false];
	};
} forEach ((allMissionObjects "All") select { [_x] call ALF_fnc_distrib_isMachine });

MRP_Distrib_MarkerNames = [];
