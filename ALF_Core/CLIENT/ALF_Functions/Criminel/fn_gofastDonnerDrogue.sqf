vehiclesrevendeur = nearestObjects [player, ["Car"], 15];
if (vehiclesrevendeur isEqualTo []) exitWith {
	['Gofast', "Il y a aucun véhicule a proximité !"] spawn BIS_fnc_showSubtitle;
};
closeDialog 0;
createDialog "alfgofast_revendeur";
_list = (findDisplay 8201) displayCtrl 1000;
lbClear _list;

private _number = 0;
{
	_className = typeOf _x;
    _displayName = getText(configFile >> "CfgVehicles" >> _className >> "displayName");
    _list lbAdd _displayName;
    _list lbSetData [_number,str _number];
    _number = _number + 1;
} forEach vehiclesrevendeur;