//cooldown de 20 minutes apres la derniere vente
if (time - ((missionNamespace getVariable ["alf_gofast_cooldown",-(15*60)])) < 15*60) exitWith {["Dealer", "Calme toi, j'ai pas assez de came à te faire livrer là, passe plus tard"] spawn BIS_fnc_showSubtitle;};
if !(isNull (missionNamespace getVariable ["alf_gofast",objNull])) exitWith {["Dealer", "Je bosse déjà avec quelqu'un là ! Attends un peu"] spawn BIS_fnc_showSubtitle;};
vehiclesdealer = nearestObjects [player, ["Car"], 15];
if (vehiclesdealer isEqualTo []) exitWith {
	["Dealer", "Reviens avec un véhicule, ça te sera plus utile"] spawn BIS_fnc_showSubtitle;
};
closeDialog 0;
["Dealer", "Tu veux faire les affaires avec quel véhicule ?"] spawn BIS_fnc_showSubtitle;
createDialog "alfgofast_gerant";
_list = (findDisplay 8200) displayCtrl 1000;
lbClear _list;

private _number = 0;
{
	_className = typeOf _x;
    _displayName = getText(configFile >> "CfgVehicles" >> _className >> "displayName");
    _list lbAdd _displayName;
    _list lbSetData [_number,str _number];
    _number = _number + 1;
} forEach vehiclesdealer;