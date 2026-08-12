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

private _mapDisplay = uiNamespace getVariable["ALF_SmartMarker_Map", displayNull];
if (isNull _mapDisplay) exitWith {};
private _mapControl = _mapDisplay displayCtrl 51;

private _defaultCursorType = ["ARRAY", ["ALF_Config_SmartMarker", "defaultCursorType"]] call ALFTools_Client_Config_fnc_getConfig;

//_mapControl ctrlMapCursor _defaultCursorType;
private _isShown = uiNamespace getVariable["ALF_SmartMarker_isShown", false];

if (_isShown) then {
    uiNamespace setVariable["ALF_SmartMarker_isShown", false];
    private _aDescription = uiNamespace getVariable["ALF_SmartMarker_activeDescription", controlNull];
    ctrlDelete _aDescription;
};