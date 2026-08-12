// MRPV2_fnc_MRP_Tel_Init_Fermeture = {
private _MRP_Appel_Etat = player getvariable ["MRP_Appel_Etat",""];
if (_MRP_Appel_Etat in ["Tentative appel destinataire","Tentative appel expéditeur","Appel en cours","Appel CA en cours"]) then
{
	// on supprime la variable de fond comme ca quand il réouvre il réouvre sur le menu principal
	uiNamespace setVariable ["MRP_Telephone_Fond_Menu_En_Attente",nil];
} else
{
	MRP_Telephone_Gestion_Numero_Interne = nil;
	MRP_Telephone_Numero_Appel = nil;
	MRP_Telephone_Appel_Numero_Expediteur = nil;
	MRP_Telephone_Appel_Numero_Destinataire = nil;
	MRP_Telephone_Appel_Id_Destinataire = nil;
	MRP_Telephone_Appel_Id_Expediteur = nil;
	Date_Enregistrer = nil;
	Heure_Enregistrer = nil;
	MRP_Telephone_Anim_En_Cours = nil;

	player setvariable ["MRP_Appel_Etat",nil];

	[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Son;
};

TRUE
// };