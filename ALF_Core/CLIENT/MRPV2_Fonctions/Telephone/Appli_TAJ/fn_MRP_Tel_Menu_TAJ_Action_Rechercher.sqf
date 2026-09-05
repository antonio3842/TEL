// MRPV2_fnc_MRP_Tel_Menu_TAJ_Action_Rechercher = {
private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
private _champ = uiNamespace getVariable ["MRP_Tel_TAJ_Champ_Recherche",controlNull];
private _nom = trim (ctrlText _champ);

if (_nom in ["","Nom de la personne"]) exitwith {hint "Le nom est vide.";};

private _longueur = count (toArray _nom);
if (_longueur > 30) exitwith {hint "Vous ne pouvez écrire que 30 caractères max."};

private _autorises = toArray "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz ";
private _caractere_Invalide = (toArray _nom) select {!(_x in _autorises)};
if (_caractere_Invalide isnotequalto []) exitwith {hint "Nom incorrect.";};

MRP_Tel_TAJ_Dernier_Nom_Recherche = _nom;

[_nom,player] remoteExec ["ALF_Server_fnc_selectTajSony",2];

TRUE
// };
