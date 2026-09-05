private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
private _ctrlButton_Ok = uiNamespace getVariable ["MRPV2_fnc_MRP_Tel_Menu_Contact_Modif_Crea_Bouton_Ok",controlNull];

private _texte_Prenom = uiNamespace getVariable ["MRPV2_fnc_MRP_Tel_Menu_Contact_Modif_Crea_Champs_Prenom",controlNull];
private _texte_Nom = uiNamespace getVariable ["MRPV2_fnc_MRP_Tel_Menu_Contact_Modif_Crea_Champs_Nom",controlNull];
private _texte_Numero = uiNamespace getVariable ["MRPV2_fnc_MRP_Tel_Menu_Contact_Modif_Crea_Champs_Numero",controlNull];

private _prenom = [ctrlText _texte_Prenom,""] select ((ctrlText _texte_Prenom) in [""," ","Prénom"]);
private _nom = [ctrlText _texte_Nom,""] select ((ctrlText _texte_Nom) in [""," ","Nom"]);
private _numero = [ctrlText _texte_Numero,""] select ((ctrlText _texte_Numero) in [""," ","Numéro de téléphone"]);
_numero = _numero regexReplace [" ",""];

private _prenom_Valide = !(_prenom in [""," ","Prénom"]);
private _nom_Valide = !(_nom in [""," ","Nom"]);
private _tel_Valide = !(_numero in [""," ","Numéro de téléphone"]) AND {_numero isnotEqualTo (player getvariable ["phoneNumber",""])};
private _numero_Longueur_Correct = count (_numero splitstring " " joinString "") isEqualTo 10;

private _hashmap_Contact = profileNamespace getvariable ["MRP_Telephone_Liste_Contact",createhashmap];
private _liste_numeros = keys _hashmap_Contact;
private _numero_Pas_Dans_Contact = !(_numero in str _liste_numeros);
private _meme_numero = _numero isequalto MRP_Telephone_Gestion_Numero_Interne;

private _liste_Entreprise = profilenamespace getvariable ["MRP_Tel_Liste_Entreprise",[]];
private _numero_Pas_Entreprise = !(_numero in str _liste_Entreprise);

if (_tel_Valide AND {_numero_Longueur_Correct AND {_numero_Pas_Dans_Contact OR {_meme_numero OR {_numero_Pas_Entreprise}}}}) then
{
	if !("bleu" in tolowerANSI (ctrltext _ctrlButton_Ok)) then
	{
		_ctrlButton_Ok ctrlSetText "MRP_icone_tel\Data\Menu_Contact\Icone_OK_Bleu_dxt5.paa";
		_ctrlButton_Ok ctrlSetTextColor [0.8,0.8,0.8,1];
	};
} else
{
	if ("bleu" in tolowerANSI (ctrltext _ctrlButton_Ok)) then
	{
		_ctrlButton_Ok ctrlSetText "MRP_icone_tel\Data\Menu_Contact\Icone_OK_dxt5.paa";
	};
};

TRUE