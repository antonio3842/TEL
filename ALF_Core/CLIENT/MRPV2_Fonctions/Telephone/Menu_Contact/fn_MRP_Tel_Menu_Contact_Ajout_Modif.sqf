// MRPV2_fnc_MRP_Tel_Menu_Contact_Ajout_Modif = {
private _prenom = param [0,""];
private _nom = param [1,""];
private _numero = param [2,""];
private _entreprise = param [3,""];
private _mail = param [4,""];
private _notes = param [5,""];
private _est_Bloquer = param [6,""];

_numero = (_numero regexreplace [" ",""]);
private _liste_Contact = profileNamespace getvariable ["MRP_Telephone_Liste_Contact",createhashmap];

if (isnil {MRP_Telephone_Gestion_Numero_Interne}) then
{
	_liste_Contact set [_numero,[_prenom,_nom,_entreprise,_mail,_notes,_est_Bloquer]];
} else
{
	_liste_Contact deleteat MRP_Telephone_Gestion_Numero_Interne;
	_liste_Contact set [_numero,[_prenom,_nom,_entreprise,_mail,_notes,_est_Bloquer]];
};

MRP_Telephone_Gestion_Numero_Interne = _numero;

profileNamespace setvariable ["MRP_Telephone_Liste_Contact",_liste_Contact];

TRUE
// };