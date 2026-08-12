/*
	File: fn_Interaction_Distributeur.sqf
	Menu molette — distributeur automatique (achat + réappro si en service).
*/
private _obj = param [0, objNull, [objNull]];

if (isNull _obj OR {_obj distance player > 3}) exitWith {};

life_pInact_curObject = _obj;

private _liste_Actions = createHashMap;
private _liste_Sous_Actions = [];

_liste_Sous_Actions pushBack [
	"Acheter",
		"Acheter Snickers, boissons et nourriture",
	{
		closeDialog 0;
		[life_pInact_curObject] call ALF_fnc_distrib_shopOpen;
	}
];

if (MRP_Distrib_EnService) then {
	_liste_Sous_Actions pushBack [
		"Réapprovisionner la machine",
		"Remettre du stock dans le distributeur",
		{
			uiNamespace setVariable ["MRP_Distrib_RestockMachine", life_pInact_curObject];
			closeDialog 0;
			[] spawn {
				sleep 0.15;
				[] call ALF_fnc_distrib_restockMenu;
			};
		}
	];
};

_liste_Actions set ["", _liste_Sous_Actions];
[_liste_Actions] call MRPV2_fnc_Interaction_Menu_Creation;
