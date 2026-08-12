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

//if (isServer) exitWith {};
if !(hasInterface) exitWith {};

private _mapDisplay = uiNamespace getVariable["ALF_SmartMarker_Map", displayNull];
if (isNull _mapDisplay) exitWith {};
private _mapControl = _mapDisplay displayCtrl 51;

private _controlUnderMouse = ctrlMapMouseOver _mapControl;

if (_controlUnderMouse isEqualTo []) exitWith {[] call ALF_SmartMarker_fnc_hideDescription};
if !(_controlUnderMouse#0 isEqualTo "marker") exitWith {[] call ALF_SmartMarker_fnc_hideDescription};

private _marker = _controlUnderMouse#1;

if ((markerAlpha _marker) isEqualTo 0) exitWith {[] call ALF_SmartMarker_fnc_hideDescription};

/* -- Cjeck if is a smartMarker -- */
//private _config = (missionConfigFile >> "ALF_Config_SmartMarker");
/*private _aConfig = configNull;
{
    private _isSpecific = getNumber(_x >> "isSpecific");
    private _configName = configName _x;
    if ((_isSpecific isEqualTo 0) && !((_marker find _configName) isEqualTo -1)) exitWith {
        _aConfig = _x;
    };

    if (_marker isEqualTo _configName) exitWith {
        _aConfig = _x;
    };
}forEach ("true" configClasses _config);*/
private _aConfig = createHashMap;
private _allMarkers = ["CLASSES", ["ALF_Config_SmartMarker"]] call ALF_Config_fnc_getConfig;
{
    private _isSpecific = ["NUMBER", ["isSpecific"], _y] call ALF_Config_fnc_getConfig;
    private _configName = _x;

    if ((_isSpecific isEqualTo 0) && !((_marker find _configName) isEqualTo -1)) exitWith {
        _aConfig = _y;
    };

    if (_marker isEqualTo _configName) exitWith {
        _aConfig = _y;
    };
}forEach _allMarkers;

//if (isNull _aConfig) exitWith {[] call ALF_SmartMarker_fnc_hideDescription};
if (_aConfig isEqualTo createHashMap) exitWith {[] call ALF_SmartMarker_fnc_hideDescription};

private _descriptionShowed = uiNamespace getVariable["ALF_SmartMarker_isShown", false];

if (_descriptionShowed) exitWith {};
uiNamespace setVariable["ALF_SmartMarker_isShown", true];

//private _cursorType = getArray(_config >> "cursorType");
//_mapControl ctrlMapCursor _cursorType;

/* -- Show Tooltip -- */
[_marker, _aConfig] spawn ALF_SmartMarker_fnc_showDescription;