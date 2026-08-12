// MRPV2_fnc_MRP_Tel_Menu_Nouveau_SMS_Action_Validation_SMS = {
private _champ_SMS = uiNamespace getVariable ["MRPV2_fnc_MRP_Tel_Menu_Nouveau_SMS_Crea_Champs_Message",controlNull];
private _texte_Message = ctrltext _champ_SMS;
private _champ_Recherche = uiNamespace getVariable ["MRPV2_fnc_MRP_Tel_Menu_Nouveau_SMS_Crea_Champs_Recherche",controlNull];
private _texte_Champ_Recherche = ctrltext _champ_Recherche;

if (trim _texte_Message isEqualTo "" OR {trim _texte_Champ_Recherche in ["Destinataire",""]}) exitwith {};

private _date = systemTimeUTC;
_date set [3,(systemTimeUTC # 3) + UTC_DIFF];

private _liste_Contact = profileNamespace getvariable ["MRP_Telephone_Liste_Contact",createhashmap];
private _telephone_Liste_SMS = profileNamespace getvariable ["MRP_Telephone_Liste_SMS",createhashmap];
private _numero_Destinataire = "";

if (isnil {MRP_Telephone_Gestion_Numero_Interne}) then
{
	_numero_Destinataire = trim _texte_Champ_Recherche;
	_telephone_Liste_SMS set [_numero_Destinataire,[[1,_texte_Message,_date]]];
	MRP_Telephone_Gestion_Numero_Interne = _numero_Destinataire;
} else
{
	private _info_Contact = _liste_Contact getOrDefault [MRP_Telephone_Gestion_Numero_Interne,[]];
	_numero_Destinataire = MRP_Telephone_Gestion_Numero_Interne;

	private _liste_SMS_Contact = _telephone_Liste_SMS getOrDefault [MRP_Telephone_Gestion_Numero_Interne,[]];

	if (_liste_SMS_Contact isEqualTo []) then
	{
		_telephone_Liste_SMS set [MRP_Telephone_Gestion_Numero_Interne,[[1,_texte_Message,_date]]];
	} else
	{
		_liste_SMS_Contact pushback [1,_texte_Message,_date];
	};

	profileNamespace setvariable ["MRP_Telephone_Liste_SMS",_telephone_Liste_SMS];
};

private _numero_Expediteur = player getvariable ["phoneNumber",""];

// Ajout de retour a la ligne dans le code text
_texte_Message = toString (parseSimpleArray (str(toArray _texte_Message) regexReplace ["\<10\>","60,98,114,32,47,62"]));

[_texte_Message,_date,_numero_Expediteur,_numero_Destinataire] call MRPV2_fnc_MRP_Tel_Menu_SMS_Action_Envois;

[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Ecran;
[] call MRPV2_fnc_MRP_Tel_Menu_SMS_Lecture;

TRUE
// };