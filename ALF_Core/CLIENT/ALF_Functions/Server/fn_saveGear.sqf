// /*
//     File: fn_saveGear.sqf
//     Author: ALF TEAM
// */
// ALF_fnc_saveGear = {
params[
	["_unit",objNull,[objNull]],
	["_id",0,[0]],
	["_uid","",[""]],
	["_name","",[""]]
];
private _return = getUnitLoadout _unit;
private _item = ((_return # 9) # 2);

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

_return
// };