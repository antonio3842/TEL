// MRPV2_fnc_Interaction_ShopIllegal
params [
	["_obj", objNull, [objNull]],
	["_shopId", "", [""]],
	["_label", "Magasin", [""]],
	["_tooltip", "", [""]]
];

if (isNull _obj OR {_obj distance player > 5}) exitWith {};

life_pInact_curObject = _obj;

private _liste_Actions = createHashMap;
private _liste_Sous_Actions = [];

private _action = compile format [
	"closeDialog 0; [nil, nil, nil, '%1'] call ALF_fnc_weaponShopMenu;",
	_shopId
];

_liste_Sous_Actions pushBack [_label, _tooltip, _action];
_liste_Actions set ["", _liste_Sous_Actions];

[_liste_Actions] call MRPV2_fnc_Interaction_Menu_Creation;
