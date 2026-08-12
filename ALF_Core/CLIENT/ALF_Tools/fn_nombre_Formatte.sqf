// File: fn_nombre_Formatte.sqf
// Auteur: NorX Aengell et Arma 3 GPT
// Description: Formate un nombre pour qu'il affiche des espaces tous les trois chiffres (ex: 1000 → 1 000).

params ["_nombre"];

private _nombre_Texte = str _nombre;
private _longueur = count _nombre_Texte;

// Si le nombre a moins de 4 chiffres, pas besoin de le formater
if (_longueur <= 3) exitWith { _nombre_Texte; };

private _nombre_Formatte = "";
private _compteur = 0;

// Boucle de formatage à l'envers pour ajouter les espaces tous les trois chiffres
for [{private _i = _longueur - 1}, {_i >= 0}, {_i = _i - 1}] do 
{
    _compteur = _compteur + 1;
    _nombre_Formatte = (_nombre_Texte select [_i, 1]) + _nombre_Formatte;
    
    if (_compteur mod 3 isequalto 0 AND {_i > 0}) then 
    {
        _nombre_Formatte = " " + _nombre_Formatte;
    };
};

_nombre_Formatte