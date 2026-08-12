/*
	File: fn_distrib_showMapMarkers.sqf
	Scanne la mission et affiche un marqueur local par distributeur.
*/
[] call ALF_fnc_distrib_clearMapMarkers;

private _machines = (allMissionObjects "All") select { [_x] call ALF_fnc_distrib_isMachine };
private _markerNames = [];

{
	private _markerName = format ["MRP_Distrib_%1", _forEachIndex];
	private _pos = getPosATL _x;

	createMarkerLocal [_markerName, _pos];
	_markerName setMarkerTypeLocal "Mil_dot";
	_markerName setMarkerTextLocal "Distributeur";

	_x setVariable ["MRP_Distrib_MarkerName", _markerName, false];

	private _stock = _x getVariable ["MRP_Distrib_Stock", createHashMap];
	if (_stock isEqualType []) then { _stock = createHashMap; };

	_markerName setMarkerColorLocal ([_stock] call ALF_fnc_distrib_getMarkerColor);

	_markerNames pushBack _markerName;
} forEach _machines;

MRP_Distrib_MarkerNames = _markerNames;
