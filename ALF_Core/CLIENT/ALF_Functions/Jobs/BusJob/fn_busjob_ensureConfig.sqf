/*
    Fichier : fn_busjob_ensureConfig.sqf
    Desc    : Charge MRP_BusJob_Config + MRP_BusJob_ArretsGPS (tableau, pas HashMap)
*/

// Toujours re-appliquer (evite cache client obsolete apres mise a jour PBO)
MRP_BusJob_Config = [
    ["fdf_marin",            "Fort-de-France - Le Marin",       1440, 600, "#F5B800"],
    ["trinite_fdf",          "La Trinite - Fort-de-France",     1440, 600, "#1A8FE3"],
    ["fdf_trinite",          "Fort-de-France - La Trinite",     190, 650, "#28C45A"],
    ["trinite_grandriviere", "La Trinite - Grand-Riviere",      220, 800, "#E87010"],
    ["trinite_vauclin",      "La Trinite - Le Vauclin",         170, 500, "#D42020"],
    ["trinite_marin",        "La Trinite - Le Marin",              0,   0, "#555555"]
];

private _idxMarin = MRP_BusJob_Config findIf { (_x select 0) isEqualTo "fdf_marin" };
if (_idxMarin >= 0) then {
    (MRP_BusJob_Config select _idxMarin) set [2, 1440];
};

// Coordonnees embarquees (secours si compile fichier echoue ou PBO arrets pas a jour)
private _arretsMarin = [
    [3811.74, 4676.18, 0], [4285.15, 4286.80, 0], [4206.48, 4558.87, 0], [4175.98, 4655.65, 0],
    [4822.46, 4821.82, 0], [4523.58, 5399.04, 0], [5246.24, 4716.59, 0], [5855.59, 4207.09, 0], [5302.38, 4070.46, 0],
    [5071.44, 3134.80, 0], [4472.21, 3238.78, 0], [3623.68, 2487.28, 0], [3170.31, 3010.71, 0],
    [5266.62, 1745.87, 0], [7317.26, 1872.26, 0], [8512.69, 1442.69, 0]
];
private _arretsTriniteFdf = [
    [6583.51, 7215.37, 0],
    [6303.19, 7268.18, 0],
    [5290.26, 8541.84, 0],
    [4747.44, 8958.91, 0],
    [3818.90, 9231.95, 0],
    [3516.24, 9280.02, 0],
    [2554.01, 8601.54, 0],
    [2347.58, 7940.19, 0],
    [1326.11, 7383.85, 0],
    [1155.77, 7219.64, 0],
    [1232.26, 6720.85, 0],
    [1623.75, 5985.99, 0],
    [2220.25, 5533.88, 0],
    [2960.16, 4935.19, 0],
    [3811.57, 4676.74, 0],
    [4176.65, 4656.45, 0],
    [4810.77, 4822.51, 0],
    [4523.39, 5398.12, 0]
];

// Charger depuis le fichier (source principale)
[] call compile preprocessFileLineNumbers "\ALF_Core\CLIENT\ALF_Functions\Jobs\BusJob\fn_busjob_configArrets.sqf";

if (isNil "MRP_BusJob_ArretsGPS" || {! (MRP_BusJob_ArretsGPS isEqualType [])}) then {
    MRP_BusJob_ArretsGPS = [];
};

// Fusionne / corrige une ligne si absente ou vide (ne remplace plus tout le tableau)
private _fnc_busjob_mergeArrets = {
    params ["_id", "_coords"];
    if (_coords isEqualTo []) exitWith {};

    private _idx = MRP_BusJob_ArretsGPS findIf { (_x select 0) isEqualTo _id };
    if (_idx < 0) then {
        MRP_BusJob_ArretsGPS pushBack [_id, +_coords];
    } else {
        if (count (MRP_BusJob_ArretsGPS select _idx select 1) isEqualTo 0) then {
            (MRP_BusJob_ArretsGPS select _idx) set [1, +_coords];
        };
    };
};

["fdf_marin", _arretsMarin] call _fnc_busjob_mergeArrets;
["trinite_fdf", _arretsTriniteFdf] call _fnc_busjob_mergeArrets;

private _countTriniteFdf = 0;
{
    if ((_x select 0) isEqualTo "trinite_fdf") exitWith {
        _countTriniteFdf = count (_x select 1);
    };
} forEach MRP_BusJob_ArretsGPS;

diag_log format [
    "[MRP_BUSJOB] ensureConfig OK — trinite_fdf:%1 arrets — config:%2 lignes",
    _countTriniteFdf,
    count MRP_BusJob_Config
];

true
