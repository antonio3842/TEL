// MRPV2_fnc_MRP_Tel_Divers_Gestion_Etat_Joueur_En_Appel = {
private _joueur = param [0,objnull];

private _liste_Entreprise = profilenamespace getvariable ["MRP_Tel_Liste_Entreprise",[]];
private _est_Un_Numero_Special = MRP_Telephone_Numero_Appel in str _liste_Entreprise;

[
	{params ["_args", "_pfID"];
		_args params ["_joueur","_heure_Depart","_est_Un_Numero_Special"];

		private _MRP_Appel_Etat = player getvariable ["MRP_Appel_Etat",""];
		if !(_MRP_Appel_Etat in ["Appel en cours","Appel CA en cours"]) then {[_joueur,_heure_Depart,_est_Un_Numero_Special] call MRPV2_fnc_MRP_Tel_Divers_Action_Sonnerie;};

		private _est_Sous_Leau = !isAbleToBreathe _joueur;
		private _joueur_Mort_Ou_A_Terre = (lifeState _joueur in ["INCAPACITATED","DEAD"]);
		private _pas_De_Telephone = assignedItems _joueur select {"MRP_Item_Iphone_12" in _x OR {"MRP_Item_Neogend" in _x}} isEqualto [];
		private _arret_Appel = _MRP_Appel_Etat in ["Arret appel en cours","Arret tentative","Pause appel CA"];
		private _tel_CA_Info_Ope = _joueur getvariable ["MRP_Tel_CA_Info_Operateur",createhashmap];

		// Je sais plus pk jai fais ca mais surement pour un cas de merde,
		// Juste un fix pour que ca ne se déclenche pas pendant un appel normal
		private _CA_En_Appel_Fantome = count (_tel_CA_Info_Ope) isequalto 1 AND {!(_MRP_Appel_Etat in ["Appel en cours","Tentative appel expéditeur"])};

		// Si on arrete l'appel parce que plus de tel on laisse lautre en com cest normal, il doit de lui meme couper
		// On quitte la boucle de gestion de l'état joueur, soit par arret de tel, soit parce que a terre ou respawns, soit par enlevage du tel de lemplacement radio
		if (_arret_Appel OR {_joueur_Mort_Ou_A_Terre OR {_pas_De_Telephone OR {_est_Sous_Leau OR {_CA_En_Appel_Fantome}}}}) then
		{
			[_pfID] call CBA_fnc_removePerFrameHandler;

			[] call
			{
				if (_joueur_Mort_Ou_A_Terre OR {_pas_De_Telephone OR {_MRP_Appel_Etat in ["Pause appel CA"] OR {_est_Sous_Leau}}}) then
				{
					if (_MRP_Appel_Etat isequalto "Pause appel CA") exitwith {};

					// Animation par defaut et suppr du tel si l'unité EST un appel sans avoir le menu tel et qu'il respawn ou est au sol
					[] call
					{
						// Concerne l'opérateur
						private _tel_CA_Info_Ope_Mon_Appel = _tel_CA_Info_Ope getorDefault ["Mon appel",[]];
						private _numero = _tel_CA_Info_Ope_Mon_Appel # 0;
						private _mon_Numero = player getvariable ["phoneNumber",""];

						//  Pour la condition du dessus, je ne sais plus pk jai mis que le num devais etre le mien, ca na aps de sens pour lappel car c'est focement celui de lappelant
						if (_tel_CA_Info_Ope_Mon_Appel isNotequalto []) exitwith
						{
							[_numero] call MRPV2_fnc_MRP_Tel_Menu_CA_Action_Pause_Variables;

							private _info_Appel_CA_Ope = _tel_CA_Info_Ope get _numero;
							private _liste_id_Appelants = _info_Appel_CA_Ope # 2;

							// S'il y a juste un appellant et un opérateur en ligne
							if (count _liste_id_Appelants isequalto 2) then
							{
								private _liste_Unites_En_Service = (allplayers select {([_x] call MRPV2_fnc_MRP_NB_Service_Vers_TXT)isEquaLTo ([] call MRPV2_fnc_MRP_NB_Service_Vers_TXT)});
								[_numero,"Pause"] remoteExec ["MRPV2_fnc_MRP_Tel_Menu_CA_Gestion_Couleur_Cadre",_liste_Unites_En_Service];
							};
						};

						// Concerne l'appelant
						private _en_Appel_CA_App = _joueur getvariable ["MRP_Tel_CA_Info_Appelant",[]] isnotequalto [];
						if (_en_Appel_CA_App) then
						{
							private _tel_CA_Info_Appelant = _joueur getvariable ["MRP_Tel_CA_Info_Appelant",[]];
							private _numero = _tel_CA_Info_Appelant # 0;
							private _liste_id_Appelants = _tel_CA_Info_Appelant # 3;

							if (count _liste_id_Appelants > 1) then
							{
								[_numero,"Arret opé",clientowner] remoteExec ["MRPV2_fnc_MRP_Tel_Menu_CA_Gestion_Etat",_liste_id_Appelants];
							} else
							{
								private _id_Entreprise = _tel_CA_Info_Appelant # 5;
								private _siret = _info_Appel_CA_Appelant # 5;
								private _building = objNull;
								{
								  // Rechercher sur le bâtiment principal (Land_ALF_Entreprise) ou les concessionnaires (Land_MRP_Concessionnaire)
								  if (((_x getVariable ["business",["","",""]]) select 2) isEqualTo _siret) exitWith {
										_building = _x;
									};
								} forEach ALF_allBusinesss;

								if (isNull _building) exitWith {};

								private _var = _building getVariable ["business",[]];
								private _name = _var select 1;
								_groupe = ((groups civilian) select {groupId _x isEqualto _name}) # 0;
								_liste_unites_Receptrices = (units _groupe);
								[_numero,"Arret opé",clientowner,_id_Entreprise] remoteExec ["MRPV2_fnc_MRP_Tel_Menu_CA_Gestion_Etat",_liste_unites_Receptrices];
							};

							player setvariable ["MRP_Tel_CA_Info_Appelant",nil];
						};
					};

					/// a verif si ca fonctionne bien avec les enlever de tel ou mort
					// [2] call MRPV2_fnc_MRP_Tel_Menu_Historique_Gestion_Histo;
					[] call MRPV2_fnc_MRP_Tel_Divers_Crea_Liste_Nombre_Appel;
					[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Son;

					if (!(isnil {MRP_Telephone_Appel_Id_Destinataire}) OR {_pas_De_Telephone AND {!(isnil {MRP_Telephone_Appel_Id_Destinataire})}}) then
					{
						private _joueur_Destinataire = (allplayers select {_x getvariable ["phoneNumber",""] isEqualTo (MRP_Telephone_Numero_Appel)}) # 0;

						_joueur_Destinataire setvariable ["MRP_Appel_Etat","Arret appel en cours",MRP_Telephone_Appel_Id_Destinataire];
						[] remoteexec ["MRPV2_fnc_MRP_Tel_Divers_Fin_Appel_TFAR",_joueur_Destinataire];
						player call TFAR_fnc_releaseAllTangents;
						["Déconnexion"] spawn MRPV2_fnc_MRP_Tel_Divers_Connexion_TFAR;
					};

					if !(isnil {MRP_Telephone_Appel_Id_Expediteur}) then
					{
						private _joueur_Expediteur = (allplayers select {_x getvariable ["phoneNumber",""] isEqualTo (MRP_Telephone_Numero_Appel)}) # 0;
						_joueur_Expediteur setvariable ["MRP_Appel_Etat","Arret appel en cours",MRP_Telephone_Appel_Id_Expediteur];
						player call TFAR_fnc_releaseAllTangents;
						["Déconnexion"] spawn MRPV2_fnc_MRP_Tel_Divers_Connexion_TFAR;
					};

					if (_est_Sous_Leau) then
					{
						_MRP_Appel_Etat = player getvariable ["MRP_Appel_Etat",""];

						[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Son;
						[] remoteExec ["MRPV2_fnc_MRP_Tel_Divers_Fin_Appel_TFAR",MRP_Telephone_Appel_Id_Expediteur];
						[] remoteExec ["MRPV2_fnc_MRP_Tel_Divers_Son_Arret_Appel",MRP_Telephone_Appel_Id_Expediteur];
						[] remoteExec ["MRPV2_fnc_MRP_Tel_Divers_Suppr_Surcouche_Appel",MRP_Telephone_Appel_Id_Expediteur];
						
						if (isnil {MRP_Telephone_Appel_Id_Expediteur}) then
						{
							private _joueur_Destinataire = (allplayers select {_x getvariable ["phoneNumber",""] isEqualTo (MRP_Telephone_Numero_Appel)}) # 0;
							_joueur_Destinataire setvariable ["MRP_Appel_Etat","Arret appel en cours",MRP_Telephone_Appel_Id_Destinataire];							
						};
					};
				};

				if (_MRP_Appel_Etat in ["Arret tentative","Arret appel en cours"]) then
				{
					[] call MRPV2_fnc_MRP_Tel_Divers_Son_Arret_Appel;
					[] spawn MRPV2_fnc_MRP_Tel_Divers_Suppr_Surcouche_Appel;
					player call TFAR_fnc_releaseAllTangents;
					["Déconnexion"] spawn MRPV2_fnc_MRP_Tel_Divers_Connexion_TFAR;
				};
			};

			_joueur setvariable ["MRP_Appel_Etat",""];

			// Si le joueur est réapparus et téléphone était affiché on ferme le telephone voir si géré par le respawn de base du serv, si oui on transfert la bas
			private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
			if (_Telephone_Base isNotequalto displayNull AND {_joueur isnotEqualTo player}) then {closedialog 2;};

			// Cas exe quand on entre dans veh avec tel et que l'on coupe l'appelle deans ca suppr le tel
			if (_MRP_Appel_Etat in ["","Arret appel en cours"] AND {_Telephone_Base isequalto displayNull AND {!isnil {MRP_Telephone}}}) then {deleteVehicle MRP_Telephone; MRP_Telephone = nil;};
			
			MRP_Telephone_Appel_Numero_Expediteur = nil;
			MRP_Telephone_Appel_Numero_Destinataire = nil;
			MRP_Compteur_Tonaliter = nil;
			MRP_Telephone_Numero_Appel = nil;
			MRP_Telephone_Joueur_Destinataire = nil;
			MRP_Telephone_Haut_Parleur = nil;
			MRP_Telephone_Est_Muter = nil;
			MRP_Telephone_Duree_Appel = nil;
			MRP_Telephone_Appel_Id_Destinataire = nil;
			MRP_Telephone_Appel_Id_Expediteur = nil;
		};
		
		if (_CA_En_Appel_Fantome) then 
		{
			_tel_CA_Info_Ope deleteat "Mon appel";
			_joueur setvariable ["MRP_Tel_CA_Info_Operateur",_tel_CA_Info_Ope];
		};

		// Gestion de l'animation et de l'affichage du tel pendant un appel
		[] call MRPV2_fnc_MRP_Tel_Init_Gestion_Anim_Affichage;		
	},
	0.05,
	[_joueur,time,_est_Un_Numero_Special]
] call CBA_fnc_addPerFrameHandler;

TRUE
// };