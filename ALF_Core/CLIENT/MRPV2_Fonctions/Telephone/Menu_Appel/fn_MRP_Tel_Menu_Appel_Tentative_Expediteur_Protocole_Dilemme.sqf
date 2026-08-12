// MRPV2_fnc_MRP_Tel_Menu_Appel_Tentative_Expediteur_Protocole_Dilemme = {
private _joueur_Destinataire = param [0,objnull];


[{
	player getvariable ["MRP_Appel_Etat",""] isequalto "" OR
	{!isnil {MRP_Appel_Reponse_Dilemme} AND {!isnil {MRP_Telephone_Appel_Id_Destinataire}}}
},
{params ["_joueur_Destinataire"];
	private _MRP_Appel_Etat = player getvariable ["MRP_Appel_Etat",""];
	if (_MRP_Appel_Etat isequalto "") exitwith {};

	private _ID_Destinataire = MRP_Telephone_Appel_Id_Destinataire;

	private _destinataire_A_Decliner = MRP_Appel_Reponse_Dilemme isequalto "Appel refusé";
	if (_destinataire_A_Decliner) then
	{
		_joueur_Destinataire setvariable ["MRP_Appel_Etat","Arret tentative",_ID_Destinataire];
		player setvariable ["MRP_Appel_Etat","Arret tentative"];

		// Instructions pour expediteur
		[2] call MRPV2_fnc_MRP_Tel_Menu_Historique_Gestion_Histo;
		[] call MRPV2_fnc_MRP_Tel_Divers_Crea_Liste_Nombre_Appel;
	};

	private _destinataire_A_Decrocher = MRP_Appel_Reponse_Dilemme isequalto "Appel accepté";
	if (_destinataire_A_Decrocher) then
	{
		_joueur_Destinataire setvariable ["MRP_Appel_Etat","Appel en cours",_ID_Destinataire];
		player setvariable ["MRP_Appel_Etat","Appel en cours"];

		// Instructions pour expediteur
		[] call MRPV2_fnc_MRP_Tel_Menu_Appel_En_Cours_Crea;
		[MRP_Telephone_Numero_Appel] call MRPV2_fnc_MRP_Tel_Divers_Debut_Appel_TFAR;
		[3] call MRPV2_fnc_MRP_Tel_Menu_Historique_Gestion_Histo;
		[] call MRPV2_fnc_MRP_Tel_Divers_Crea_Liste_Nombre_Appel;

		// Instructions pour destinataire
		[] remoteexec ["MRPV2_fnc_MRP_Tel_Menu_Appel_En_Cours_Crea",_ID_Destinataire];
		[MRP_Telephone_Numero_Appel] remoteExec ["MRPV2_fnc_MRP_Tel_Divers_Debut_Appel_TFAR",_ID_Destinataire];
		[1] remoteExec ["MRPV2_fnc_MRP_Tel_Menu_Historique_Gestion_Histo",_ID_Destinataire];
		[] remoteExec ["MRPV2_fnc_MRP_Tel_Divers_Crea_Liste_Nombre_Appel",_ID_Destinataire];
	};

	MRP_Appel_Reponse_Dilemme = nil;
	_ID_Destinataire publicVariableClient "MRP_Appel_Reponse_Dilemme";
},[_joueur_Destinataire],
20,
{
	player setvariable ["MRP_Appel_Etat","Arret tentative"];
}] call CBA_fnc_waitUntilAndExecute;

TRUE
// };