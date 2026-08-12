// MRPV2_fnc_MRP_Tel_Divers_Gestion_Filtrage_Lettres = {
private _displayOrControl = param [0,""];
private _key = param [1,""];
private _liste_Perso = param [2,"0123456789 "];


private _liste_Touches_Ignorer = [14,203,205,211,199,207];
// Pour laisser le backspace tranquille
if (_key in _liste_Touches_Ignorer) exitWith {};

private _liste_Charactere_Autoriser = toarray _liste_Perso;
private _texte = toArray (ctrlText _displayOrControl);
private _texte_Filtrer = _texte select {_x in _liste_Charactere_Autoriser};
_displayOrControl ctrlSetText tostring _texte_Filtrer;

TRUE
// };