// MRPV2_fnc_Interaction_Tuto
private _obj = param [0, objNull];

if (gestureState player isEqualTo "<none>" OR {_obj distance player > 5}) exitWith {};

life_pInact_curObject = _obj;

private _liste_Actions = createHashMap;
private _liste_Sous_Actions = [];

private _texte = "Lire";
private _texte_tooltype = "Consulter le guide de l'ile";
private _action = {
	closeDialog 0;
	[] spawn ALF_fnc_tuto_openMenu;
};

_liste_Sous_Actions pushBack [_texte, _texte_tooltype, _action];
_liste_Actions set ["", _liste_Sous_Actions];

[_liste_Actions] call MRPV2_fnc_Interaction_Menu_Creation;
