// MRPV2_fnc_Interaction_Objets_BRINKS = {
if (!b_6) exitWith {["Brinks", "Vous n'êtes pas convoyeur de fond.", "danger"] spawn ALF_fnc_doMsg;};

private _liste_Actions = createhashmap;
private _liste_Sous_Actions = [];

private _texte = "Prendre une valise";
private _texte_tooltype = "";
private _action =
{
	closeDialog 0;
	[] spawn ALF_fnc_moneyBagHandle;
};

_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
_liste_Actions set ["",_liste_Sous_Actions];

[_liste_Actions] call MRPV2_fnc_Interaction_Menu_Creation;
// };
