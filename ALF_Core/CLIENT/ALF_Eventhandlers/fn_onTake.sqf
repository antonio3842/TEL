/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/
params [
    ["_unit",objNull,[objNull]],
    ["_container",objNull,[objNull]],
    ["_item","",[""]]
];

// Déverrouiller automatiquement les GroundWeaponHolder après prise d'un objet
// (sécurité supplémentaire pour éviter qu'ils restent verrouillés)
if (!isNull _container && {(_container isKindOf "GroundWeaponHolder") || {_container isKindOf "WeaponHolderSimulated"}}) then {
    if (lockedInventory _container) then {
        if (local _container) then {
            _container lockInventory false;
        } else {
            [_container, false] remoteExec ["lockInventory", _container];
        };
    };
};

if (_item isEqualTo "ALF_Raisin" && {_container getVariable ["TakeRaisin",false]}) exitWith {
    _count = {(_x select 0) isEqualTo "ALF_Raisin"} count (magazinesAmmo _container);
    if (_count isEqualTo 0) then {
        [0,3] spawn ALF_fnc_addXP;
        closeDialog 0;
        deleteVehicle _container;
    };
};
