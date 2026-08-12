// MRPV2_fnc_MRP_Tel_Menu_SMS_Validation_SMS = {
private _menu_SMS_Lecture_Cadre_Ecriture = uiNamespace getVariable ["MRP_menu_SMS_Lecture_Cadre_Ecriture",controlNull];
private _texte_Message = ctrltext _menu_SMS_Lecture_Cadre_Ecriture;

if (trim _texte_Message isEqualTo "") exitwith {};

// On modifie des commandes pouvant etre interprété par le moteur
_texte_Message = _texte_Message regexReplace ["&", "&amp;"];
_texte_Message = _texte_Message regexReplace ["<", "&lt;"];
_texte_Message = _texte_Message regexReplace [">", "&gt;"];
_texte_Message = _texte_Message regexReplace ["ç", "c"];


private _liste_Contact = profileNamespace getvariable ["MRP_Telephone_Liste_Contact",createhashmap];
private _info_Contact = _liste_Contact getOrDefault [MRP_Telephone_Gestion_Numero_Interne,[]];

// Ajout de retour a la ligne dans le code text
_texte_Message = toString (parseSimpleArray (str(toArray _texte_Message) regexReplace ["\<10\>","60,98,114,32,47,62"]));

private _date = systemTimeUTC;
_date set [3,(systemTimeUTC # 3) + UTC_DIFF];

[1,_texte_Message,_date] call MRPV2_fnc_MRP_Tel_Menu_SMS_Crea_Cadre;

private _telephone_Liste_SMS = profileNamespace getvariable ["MRP_Telephone_Liste_SMS",createhashmap];
private _liste_SMS_Contact = _telephone_Liste_SMS getOrDefault [MRP_Telephone_Gestion_Numero_Interne,[]];

if (_liste_SMS_Contact isEqualTo []) then
{
	_telephone_Liste_SMS set [MRP_Telephone_Gestion_Numero_Interne,[[1,_texte_Message,_date]]];
} else
{
	_liste_SMS_Contact pushback [1,_texte_Message,_date];
};

private _numero_Expediteur = player getvariable ["phoneNumber",""];
[_texte_Message,_date,_numero_Expediteur,MRP_Telephone_Gestion_Numero_Interne] call MRPV2_fnc_MRP_Tel_Menu_SMS_Action_Envois;

_menu_SMS_Lecture_Cadre_Ecriture ctrlsettext "";
ctrlsetfocus _menu_SMS_Lecture_Cadre_Ecriture;

[] spawn
{
	private _menu_SMS_Lecture_Conteneur_SMS = uiNamespace getVariable ["MRP_menu_SMS_Lecture_Conteneur_SMS",displayNull];
	sleep 0.01;
	_menu_SMS_Lecture_Conteneur_SMS ctrlSetScrollValues [1,-1];
};

TRUE
// };