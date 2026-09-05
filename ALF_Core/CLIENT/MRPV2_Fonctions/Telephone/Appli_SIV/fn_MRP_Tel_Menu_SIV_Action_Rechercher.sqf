// MRPV2_fnc_MRP_Tel_Menu_SIV_Action_Rechercher = {
private _champ = uiNamespace getVariable ["MRP_Tel_SIV_Champ_Recherche",controlNull];
private _plaque = toupper (trim (ctrlText _champ));

if (_plaque in ["","AA-123-BB"]) exitwith {hint "La plaque est vide."};

private _lettres = toArray "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
private _chiffres = toArray "0123456789";
private _caracteres = toArray _plaque;

private _format_Valide = (count _caracteres isequalto 9)
 AND {(_caracteres select 0 >= 65 && _caracteres select 0 <= 90)}
 AND {(_caracteres select 1 >= 65 && _caracteres select 1 <= 90)}
 AND {(_caracteres select 2) isequalto (45)}
 AND {(_caracteres select 3 >= 48 && _caracteres select 3 <= 57)}
 AND {(_caracteres select 4 >= 48 && _caracteres select 4 <= 57)}
 AND {(_caracteres select 5 >= 48 && _caracteres select 5 <= 57)}
 AND {(_caracteres select 6) isequalto (45)}
 AND {(_caracteres select 7 >= 65 && _caracteres select 7 <= 90)}
 AND {(_caracteres select 8 >= 65 && _caracteres select 8 <= 90)};

if (!_format_Valide) exitwith {hint "Format de plaque incorrect (ex: AA-123-BB)."};

private _resultat = uiNamespace getVariable ["MRP_Tel_SIV_Zone_Resultat",controlNull];
_resultat ctrlSetStructuredText parseText "<t font='SFUIDisplay_20' shadow='0' color='#cccccc' size='1' align='left'>Recherche en cours...</t>";

[_plaque,player] remoteExec ["ALF_Server_fnc_SonyRecherchePlaque",2];

TRUE
// };
