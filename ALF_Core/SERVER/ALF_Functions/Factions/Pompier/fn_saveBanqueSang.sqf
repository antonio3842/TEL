#include "\ALF_Core\SERVER\script_macros.hpp"
/*
	SaveBanqueSang
*/
private _coffre = _this select 0;
if(isNull _coffre) exitWith {};

//On récupère le stuff dans le coffre
private _vehItems = getItemCargo _coffre;
private _vehMags = getMagazineCargo _coffre;
private _vehWeapons = getWeaponCargo _coffre;
private _vehBackpacks = getBackpackCargo _coffre;
private _cargo = [_vehItems,_vehMags,_vehWeapons,_vehBackpacks];

{
	private _activeArr = _x;
	{
		// className = _x
		private _arrayRet = [_x, false] call ALFTools_Server_MD_T_fnc_packData;
		if (_arrayRet isEqualTo "") then {continue};
		_activeArr#0 set[_forEachIndex,_arrayRet];
	}forEach _x#0;

	_cargo set[_forEachIndex,_activeArr];
}forEach _cargo;

private _newCargo = [_cargo] call ALF_Server_fnc_mresArray;

[format["UPDATE banquesang SET gear = '%1' WHERE id=1",_newCargo],1] call ALF_Server_fnc_asyncCall;