// File: fn_Interaction_Derrick.sqf
// Author: NorX Aengell & ARMA 3 Script GPT
// Fonction: MRPV2_fnc_Interaction_Derrick
// Description: Ouvre le menu d'interaction avec le derrick et affiche les options disponibles.
/*
if (!dialog) then { createDialog "interactionSystem"; };

private _affichage = findDisplay 25799;
private _liste_Boutons = [];

for "_i" from 0 to 11 do 
{
    private _bouton = _affichage displayCtrl (25802 + _i);
    _bouton ctrlShow FALSE;
    _liste_Boutons pushBack _bouton;
};

private _bouton_Remplir = _liste_Boutons # 0;
_bouton_Remplir ctrlShow TRUE;
_bouton_Remplir ctrlSetText "Remplir le baril";
_bouton_Remplir ctrlAddEventHandler ["buttonClick", 
{
    closeDialog 2;
    [] call MRPV2_fnc_Petrole_Baril;
}];
*/

// File: fn_Interaction_Derrick.sqf
// Author: NorX Aengell & ARMA 3 Script GPT
// Fonction: MRPV2_fnc_Interaction_Derrick
// Description: Ouvre le menu d'interaction avec le derrick et affiche les options disponibles.

private _obj = param [0,objnull];

if (gestureState player isEqualTo "<none>" OR {_obj distance player > 6}) exitWith {};

life_pInact_curObject = _obj;

private _liste_Actions = createhashmap;
private _liste_Sous_Actions = [];

// Action Remplir le baril
private _texte = "Remplir le baril";
private _texte_tooltype = "Remplir un baril de pétrole";
private _action = 
{
    closeDialog 0;
    [] call MRPV2_fnc_Petrole_Baril;
};

_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
_liste_Actions set ["",_liste_Sous_Actions];

[_liste_Actions] call MRPV2_fnc_Interaction_Menu_Creation;


