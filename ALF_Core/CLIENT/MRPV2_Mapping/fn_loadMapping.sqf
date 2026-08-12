/*
    fn_loadMapping.sqf
    Permet de charger dynamiquement un mapping par nom
    Usage: ["kolanta"] call MRPV2_fnc_loadMapping;
*/

params [["_mappingName", "", [""]]];

if (_mappingName isEqualTo "") exitWith {
    systemChat "[MAPPING] Nom du mapping vide.";
};

private _path = format ["\ALF_Core\CLIENT\MRPV2_Mapping\%1.sqf", _mappingName];

if !(fileExists _path) exitWith {
    systemChat format ["[ERROR] Le mapping '%1' est introuvable.", _mappingName];
};

[] execVM _path;
systemChat format ["[MAPPING] '%1' chargé avec succès.", _mappingName];
