/*
	File: fn_createRobberyMarkerClient.sqf
	Description: Crée un marqueur local de cambriolage (appelé par le serveur)
	Uniquement pour les gendarmes en service
*/

params[
	["_markerInfo", [], [[]]]
];

if (_markerInfo isEqualTo []) exitWith {};

// Vérifier que le joueur est gendarme en service (uniquement les gendarmes)
private _isGendarme = (life_coplevel > 0);
private _isInService = life_gendarme_service;

if (!_isGendarme || !_isInService) exitWith {};

// Créer le marqueur local
private _mkrName = _markerInfo select 0;
private _marker = createMarkerLocal [_mkrName, _markerInfo select 2];
_marker setMarkerShapeLocal (_markerInfo select 6);
_marker setMarkerBrushLocal (_markerInfo select 7);
_marker setMarkerColorLocal (_markerInfo select 8);
_marker setMarkerSizeLocal (_markerInfo select 4);
_marker setMarkerAlphaLocal (_markerInfo select 9);
_marker setMarkerTextLocal (_markerInfo select 1);

