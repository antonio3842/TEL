/*
	Chauffeur / entrée la plus proche d'une position.
	[_candidates, _from] — _candidates : joueurs ou [[unit, ...], ...]
	Retour : [élément retenu, distance en m]
*/
params [
	["_candidates", [], [[]]],
	["_from", player, [objNull]]
];

if (_candidates isEqualTo [] || {isNull _from}) exitWith {[objNull, -1]};

private _fromPos = getPosATL _from;
private _bestEntry = _candidates # 0;
private _bestUnit = if (_bestEntry isEqualType objNull) then {_bestEntry} else {_bestEntry # 0};
private _bestDist = _fromPos distance (getPosATL _bestUnit);

{
	private _unit = if (_x isEqualType objNull) then {_x} else {_x # 0};
	if (!isNull _unit && {alive _unit}) then {
		private _d = _fromPos distance (getPosATL _unit);
		if (_d < _bestDist) then {
			_bestDist = _d;
			_bestEntry = _x;
			_bestUnit = _unit;
		};
	};
} forEach _candidates;

[_bestEntry, _bestDist]
