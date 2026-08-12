/*
    File: fn_saveGear.sqf
    Author: ALF TEAM
    Desc: Version serveur pour sauvegarder le gear d'une unité lors de la déconnexion
*/
params[
    ["_unit",objNull,[objNull]],
    ["_id",0,[0]],
    ["_uid","",[""]],
    ["_name","",[""]]
];

// Vérification null pour éviter les erreurs
if (isNull _unit) exitWith {[]};

private _return = getUnitLoadout _unit;

// Vérification de l'item radio TFAR (index 9 = assigned items, index 2 = radio)
private _item = ((_return # 9) # 2);

if (!isNil "_item" && {_item isEqualType "" && {_item != ""}}) then {
    if (_item call TFAR_fnc_isRadio) then 
    {
        private _array = (_return # 9);
        private _nom_tel = (_item splitString "_");
        private _nombre_syllabes = count _nom_tel;

        _nom_tel resize (_nombre_syllabes - 1);
        _nom_tel = _nom_tel joinString "_";

        _array set [2,_nom_tel];
        _return set [9,_array];
    };
};

_return
