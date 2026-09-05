// MRPV2_fnc_MRP_Tel_Menu_FPR_Action_Rechercher = {
private _champ = uiNamespace getVariable ["MRP_Tel_FPR_Champ_Recherche",controlNull];
private _nom = trim (ctrlText _champ);

if (_nom in ["","Nom de la personne"]) exitwith {hint "Le nom est vide.";};

private _longueur = count (toArray _nom);
if (_longueur > 30) exitwith {hint "Vous ne pouvez écrire que 30 caractères max."};

private _autorises = toArray "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz ";
private _caractere_Invalide = (toArray _nom) select {!(_x in _autorises)};
if (_caractere_Invalide isnotequalto []) exitwith {hint "Nom incorrect.";};

private _zone_OuiNon = uiNamespace getVariable ["MRP_Tel_FPR_Zone_OuiNon",controlNull];
_zone_OuiNon ctrlSetStructuredText parseText "<t font='SFUIDisplay_20' shadow='0' color='#cccccc' size='1' align='left'>Recherche en cours...</t>";
private _zone_Motif = uiNamespace getVariable ["MRP_Tel_FPR_Zone_Motif",controlNull];
_zone_Motif ctrlSetStructuredText parseText "";

[_nom,player] remoteExec ["ALF_Server_fnc_selectFipSony",2];

TRUE
// };
