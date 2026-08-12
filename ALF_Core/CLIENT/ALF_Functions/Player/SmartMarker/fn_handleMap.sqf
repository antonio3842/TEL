/*
    GET YOUR PATH
    Code written by Association law 1901 "GET YOUR PATH" (RNA W252007073)
    Statement from the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403
    @Copyright GET YOUR PATH (https://www.getyourpath.fr)
    YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
    More informations : https://www.bistudio.com/community/game-content-usage-rules
    Contact : kainnon@getyourpath.fr

	Return : New item className
*/

if (isServer) exitWith {};
if !(hasInterface) exitWith {};

params[
    ["_isMapOpened", false]
];

if !(_isMapOpened) exitWith {
    [] call ALF_SmartMarker_fnc_hideDescription;
};

private _mapDisplay = findDisplay 12;
private _mapControls = _mapDisplay displayCtrl 51;

if (isNull _mapControls) exitWith {};

[] call ALF_SmartMarker_fnc_hideDescription;
uiNamespace setVariable["ALF_SmartMarker_Map", _mapDisplay];
uiNamespace setVariable["ALF_SmartMarker_isShown", false];

/* -- Setup EH -- */

private _mouseMoving = _mapControls ctrlAddEventHandler["MouseMoving", {_this call ALF_SmartMarker_fnc_onMoving}];

waitUntil {!(visibleMap)};

_mapControls ctrlRemoveEventHandler["MouseMoving", _mouseMoving];