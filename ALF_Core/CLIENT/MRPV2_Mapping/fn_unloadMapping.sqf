/*
    fn_unloadMapping.sqf
    Supprime tous les objets précédemment chargés via fn_loadMapping
*/

if (isNil "MRPV2_Mapping_Objects") exitWith {
    systemChat "[MAPPING] Aucun mapping chargé à décharger.";
};

{
    if (!isNull _x) then {
        deleteVehicle _x;
    };
} forEach MRPV2_Mapping_Objects;

MRPV2_Mapping_Objects = nil;
systemChat "[MAPPING] Mapping déchargé.";
