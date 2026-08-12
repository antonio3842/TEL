/*
    Fichier : fn_busjob_getArretsCoords.sqf
    Params  : [_idLigne]
    Retour  : array de positions [[x,y,z], ...]
*/
params [["_idLigne", "", [""]]];

[] call ALF_fnc_busjob_ensureConfig;

private _coords = [];
{
    if ((_x select 0) isEqualTo _idLigne) exitWith {
        _coords = +(_x select 1);
    };
} forEach MRP_BusJob_ArretsGPS;

_coords
