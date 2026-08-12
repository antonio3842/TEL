// MRPV2_fnc_MRP_Tel_Menu_Appel_Gestion_Couleur_Bouton_Ajouter = {
private _cadran_Numero = uiNamespace getVariable ["MRP_Telephone_Menu_Appel_Cadran_Numero",controlNull];
private _ctrlButton = uiNamespace getVariable ["MRP_Telephone_Menu_Appel_Bouton_Ajout_Numero",controlNull];
private _numero = "";

if (isnil {MRP_Telephone_Gestion_Numero_Interne}) then
{
	_numero = (ctrltext _cadran_Numero) regexreplace [" ",""];
}else
{
	_numero = MRP_Telephone_Gestion_Numero_Interne regexreplace [" ",""];
};

private _liste_Contact = profileNamespace getvariable ["MRP_Telephone_Liste_Contact",createhashmap];
private _info_Contact = _liste_Contact getOrDefault [_numero,[]];

private _numero_Expediteur = player getvariable ["phoneNumber",""];

private _liste_Entreprise = profilenamespace getvariable ["MRP_Tel_Liste_Entreprise",[]];
private _numero_est_Service = (_liste_Entreprise select {(_x getOrDefault ["PHONE",""]) isequalto _numero}) isnotequalto [];

if (_numero in ["",_numero_Expediteur] OR {_info_Contact isNotequalto [] OR {count _numero < 10 OR {_numero_est_Service}}}) then
{
	_ctrlButton ctrlSetText "MRP_Telephones\Data\Menu_Appel\Phrase_Ajout_Numero_Gris_dxt5.paa";
} else
{
	_ctrlButton ctrlSetText "MRP_Telephones\Data\Menu_Appel\Phrase_Ajout_Numero_dxt5.paa";
};

TRUE
// };