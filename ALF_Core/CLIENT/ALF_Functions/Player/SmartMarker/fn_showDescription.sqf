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

private _v = params [
    ["_marker", "", [""]],
    ["_config", createHashMap, [createHashMap]]
];

if !(_v) exitWith {};

private _mapDisplay = uiNamespace getVariable["ALF_SmartMarker_Map", displayNull];
if (isNull _mapDisplay) exitWith {};

private _mapControl = _mapDisplay displayCtrl 51;

/* -- is Small -- */
private _isSmall = ["NUMBER", ["isSmallPopup"], _config] call ALFTools_Client_Config_fnc_getConfig;
private _popupClass = ["STRING", ["ALF_Config_SmartMarker", "bigPopup"]] call ALFTools_Client_Config_fnc_getConfig;
if (_isSmall isEqualTo 1) then {
    _popupClass = ["STRING", ["ALF_Config_SmartMarker", "smallPopup"]] call ALFTools_Client_Config_fnc_getConfig;
};

private _popup = _mapDisplay ctrlCreate [_popupClass, 01];
uiNamespace setVariable ["ALF_SmartMarker_activeDescription", _popup];

/* -- Modify values -- */

private _color = ["ARRAY", ["color"], _config] call ALFTools_Client_Config_fnc_getConfig;
private _title = ["STRING", ["title"], _config] call ALFTools_Client_Config_fnc_getConfig;
private _type = ["STRING", ["type"], _config] call ALFTools_Client_Config_fnc_getConfig;
private _hours = ["STRING", ["hours"], _config] call ALFTools_Client_Config_fnc_getConfig;

(_popup controlsGroupCtrl 10) ctrlSetTextColor _color;
(_popup controlsGroupCtrl 2) ctrlSetStructuredText parseText format["<t font='RobotoCondensedBold' color='#1E1E1E' size='1' >%1</t>",_title];
(_popup controlsGroupCtrl 5) ctrlSetStructuredText parseText format["<t font='RobotoCondensedLight' align='left' color='#000000' size='0.6' >%1</t>",_type];
(_popup controlsGroupCtrl 7) ctrlSetStructuredText parseText format["<t font='RobotoCondensedLight' align='right' color='#000000' size='0.6' >%1</t>",_hours];


if (_isSmall isEqualTo 0) then {
    private _description = ["STRING", ["description"], _config] call ALFTools_Client_Config_fnc_getConfig;
    private _masterType = ["STRING", ["masterType"], _config] call ALFTools_Client_Config_fnc_getConfig;
    private _owner = ["STRING", ["owner"], _config] call ALFTools_Client_Config_fnc_getConfig;

    (_popup controlsGroupCtrl 3) ctrlSetStructuredText parseText format["<t font='RobotoCondensedLight' shadow='1' color='#000000' size='0.8' >%1</t>",_description];
    (_popup controlsGroupCtrl 4) ctrlSetStructuredText parseText format["<t font='RobotoCondensedLight' align='left' color='#000000' size='0.6' >%1</t>",_masterType];
    (_popup controlsGroupCtrl 6) ctrlSetStructuredText parseText format["<t font='RobotoCondensedLight' align='right' color='#000000' size='0.6' >%1</t>",_owner];

    /* -- Master type icon -- */
    private _masterTypeIcon = ["STRING", ["mastertypeIcon"], _config] call ALFTools_Client_Config_fnc_getConfig;
    private _dataPath = ["STRING", ["ALF_Config_SmartMarker", "dataPath"]] call ALFTools_Client_Config_fnc_getConfig;
    private _finalPath = format["%1\%2",_dataPath,_masterTypeIcon];

    (_popup controlsGroupCtrl 11) ctrlSetText _finalPath;

    /* -- TODO Buisness -- */
     (_popup controlsGroupCtrl 12) ctrlShow false;
};

while {(uiNamespace getVariable["ALF_SmartMarker_isShown", false])} do {
    private _position = (_mapControl posWorldToScreen (getMarkerPos [_marker, true]));
    private _xPos = _position#0 + (safeZoneW * -0.017);
    if (_isSmall isEqualTo 1) then {
        _xPos = _xPos + (safeZoneW * -0.003);
    };
    _popup ctrlSetPosition [_xPos,_position#1];
    _popup ctrlCommit 0;
};