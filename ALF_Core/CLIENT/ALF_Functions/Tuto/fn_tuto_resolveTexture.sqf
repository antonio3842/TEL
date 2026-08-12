/*
    Fichier : fn_tuto_resolveTexture.sqf
    Param : chemin relatif mission (ex. textures\tuto\LogoMRP.paa)
    Retourne un chemin utilisable par ctrlSetText sur un RscPicture.
*/
params [["_relPath", "", [""]]];

private _missionPath = getMissionPath _relPath;
if (fileExists _missionPath) exitWith { _missionPath };

private _pboPath = format ["\MRP_Martinique.martinique\%1", _relPath];
if (fileExists _pboPath) exitWith { _pboPath };

_missionPath
