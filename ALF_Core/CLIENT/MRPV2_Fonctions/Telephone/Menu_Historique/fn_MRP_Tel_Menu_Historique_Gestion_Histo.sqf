// MRPV2_fnc_MRP_Tel_Menu_Historique_Gestion_Histo = {
private _type = param [0,0];
private _numero = param [1,""];


if (_numero isequalto "") then {_numero = MRP_Telephone_Numero_Appel;};

private _liste_Entreprise = profilenamespace getvariable ["MRP_Tel_Liste_Entreprise",[]];
private _est_Pas_Numero_Speciale = !(_numero in str _liste_Entreprise);
private _joueur_Expediteur = objnull;
private _numero_Masquer = FALSE;

if (_est_Pas_Numero_Speciale) then
{
	_numero = _numero regexReplace [" ",""];
	_joueur_Expediteur = (allplayers select {_x getvariable ["phoneNumber",""] isEqualTo (_numero)}) # 0;
	_numero_Masquer = _joueur_Expediteur getvariable ["MRP_Telephone_Numero_Cacher",FALSE];
};

if (isnil {_numero}) then {_numero = MRP_Telephone_Appel_Numero_Expediteur;};
if (_numero_Masquer) then {_numero = "Numéro masqué";};

private _date = systemTimeUTC;
private _heure = (systemTimeUTC # 3) + UTC_DIFF;
if (_heure >= 24) then
{
	_heure = ([_heure - 24] apply {if (_x < 10) then {"0" + str _x} else {str _x }}) # 0;
} else
{
	_heure = ([_heure] apply {if (_x < 10) then {"0" + str _x} else {str _x }}) # 0;
};

_date set [3,parsenumber _heure];

private _Telephone_Liste_Historique = profileNamespace getvariable ["MRP_Telephone_Liste_Historique",[]];
_Telephone_Liste_Historique pushback [_date,_numero,_type];
profileNamespace setvariable ["MRP_Telephone_Liste_Historique",_Telephone_Liste_Historique];

TRUE
// };