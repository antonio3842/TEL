/*
    Client-side: crée un marker local pour 10 minutes
    Usage: [_markerName, _pos] call ALF_fnc_createTempGNMarker;
*/
ALF_fnc_createTempGNMarker = {
    params ["_mName", "_pos"];

    // Nettoie un éventuel marker précédent du même nom
    deleteMarkerLocal _mName;

    private _m = createMarkerLocal [_mName, _pos];
    _m setMarkerTextLocal "📍 Intrusion / Perceuse";
    _m setMarkerTypeLocal "mil_warning";
    _m setMarkerColorLocal "ColorRed";
    _m setMarkerSizeLocal [1.3, 1.3];

    // Auto-suppression après 600s (10 minutes)
    [_mName] spawn {
        params ["_mName"];
        sleep 600;
        deleteMarkerLocal _mName;
    };
};
