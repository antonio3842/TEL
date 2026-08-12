/*
    Fichier : fn_busjob_getDepotContext.sqf
    Retourne [PNJ depot, bus de service, bus au depot (bool)] — check a l'ouverture du PNJ.
*/
params [["_pnj", objNull, [objNull]]];

if (isNil "MRP_BusJob_Bus") then { MRP_BusJob_Bus = objNull; };
if (isNil "MRP_BusJob_DepotRayon") then { MRP_BusJob_DepotRayon = 100; };

if (isNull _pnj) then {
    {
        private _nom = toLowerANSI str _x;
        if ("MRPV2_PNJ_Emploi_BusJob" in _nom) exitWith { _pnj = _x; };
    } forEach (allMissionObjects "Man");
};

private _bus = MRP_BusJob_Bus;
if (isNull _bus) then { _bus = player getVariable ["MRP_BusJob_Bus", objNull]; };

if (isNull _bus) then {
    private _uid = getPlayerUID player;
    {
        if (
            (_x getVariable ["MRP_BusJobServiceVehicle", false]) &&
            {((_x getVariable ["vehicle_info_owners", ["", ""]]) select 1) isEqualTo _uid}
        ) exitWith { _bus = _x; };
    } forEach (vehicles select { (player distance _x) < 200 });
};

private _rayon = MRP_BusJob_DepotRayon;
private _atDepot = !isNull _pnj && {!isNull _bus} && {alive _bus} && {(_bus distance _pnj) <= _rayon};

[_pnj, _bus, _atDepot]