//MRPV2_fnc_Interaction_Batiments = {
private _type = param [0,""];

private _liste_Actions = createHashMap;
private _objet = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;

if (isnil {_objet}) exitwith {};

[] call 
{
	if (toloweransi _type isEqualTo toloweransi "Land_ALF_Pompe") exitwith 
	{
		private _joueur_A_Pistolet = attachedObjects player select {_x isKindOf "ALF_Pistolet_Essence"} isNotequalto [];
		if (!ALF_ActivePrisePistolet AND {!_joueur_A_Pistolet AND {(_objet animationSourcePhase 'pistolet_1_source' isequalto 0)}}) exitwith 
		{
			private _texte = "Prendre le pistolet";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				private _pompe = nearestObjects [player, ["Land_ALF_Pompe"], 5] # 0;
				if (isnil {_pompe}) exitwith {};
				if !([_pompe] call ALF_fnc_hasEnergy) exitWith {["Pompe", "La pompe n'a pas d'électricité.", "danger"] spawn ALF_fnc_doMsg;};
				private _cote_Droite = _pompe getRelDir player < 180;

				if ((_pompe animationSourcePhase "pistolet_2_source" isequalto 0) AND {_cote_Droite}) exitwith 
				{
					[0,_pompe,"pistolet_2"] spawn ALF_fnc_pistoletEssence;
				}; 
				if ((_pompe animationSourcePhase "pistolet_1_source" isequalto 0) AND {!_cote_Droite}) then 
				{
					[0,_pompe,"pistolet_1"] spawn ALF_fnc_pistoletEssence;
				}; 
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions];
		};

		if (ALF_ActivePrisePistolet AND {_joueur_A_Pistolet}) then 
		{
			private _texte = "Poser le pistolet";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				private _pompe = nearestObjects [player, ["Land_ALF_Pompe"], 5] # 0;
				if (isnil {_pompe}) exitwith {};
				private _cote_Droite = _pompe getRelDir player < 180;

				if ((_pompe animationSourcePhase "pistolet_2_source" isequalto 1) AND {_cote_Droite}) exitwith 
				{
					[1,_pompe,"pistolet_2"] spawn ALF_fnc_pistoletEssence;
				}; 
				if ((_pompe animationSourcePhase "pistolet_1_source" isequalto 1) AND {!_cote_Droite}) then 
				{
					[1,_pompe,"pistolet_1"] spawn ALF_fnc_pistoletEssence;
				}; 
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions];			
		};
	};

	if ((toloweransi _type) isEqualTo toloweransi "Land_ALF_CREM") exitWith 
	{
		private _pos_accueil = (cursorObject getrelpos [6,-90]);
		private _joueur_Proche_Acceuil = player distance _pos_accueil < 2; 
		if !(_joueur_Proche_Acceuil) exitwith {};

		private _texte = "Acheter une carte bancaire";
		private _texte_tooltype = "";
		private _action = 
		{closeDialog 0;
			[nil,nil,nil,"bankstore"] call ALF_fnc_weaponShopMenu;
		};

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];

		private _texte = "Consulter mon compte";
		private _texte_tooltype = "";
		private _action = 
		{closeDialog 0;
			[] call ALF_fnc_menuCompteBancaire;
		};

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];
	};

 	if ((toloweransi _type) isEqualTo toloweransi "land_alf_trafo") exitWith 
	{
			if (license_TIC) then {
			private _texte = "Relever les traces ADN";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				[_objet] spawn ALF_fnc_adnBarbele;
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions];
		};
	};

	if ((toloweransi _type) isEqualTo toloweransi "Land_ALF_ATM") exitWith 
	{
		private _dab = nearestObjects [player, ["Land_ALF_ATM"], 3] # 0;
		if (isnil {_dab}) exitwith {};

		if !([_dab] call ALF_fnc_hasEnergy) exitWith {["Distributeur", "Le distributeur n'a pas d'électricité.", "danger"] spawn ALF_fnc_doMsg;};
		if !(isNull (player getVariable ["wallet_obj", objNull])) exitWith {closeDialog 0; [_dab] spawn ALF_fnc_bag_deposit; closeDialog 0;};
		
		if(["ALF_CB_Bronze","ALF_CB_Gold","ALF_CB_Black"] select {_x in magazines player} isNotequalto []) then 
		{
			private _texte = "Retirer/déposer du liquide";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				private _dab = nearestObjects [player, ["Land_ALF_ATM"], 3] # 0;
				if (isnil {_dab}) exitwith {};
				//['_dab ' + str(_dab)] remoteExec ['systemchat',0];
				[_dab] call ALF_fnc_menuDab;
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions];
		} else 
		{
			["Distributeur", "Vous n'avez pas de carte bancaire sur vous.", "danger"] spawn ALF_fnc_doMsg;
		};
	};

	if (toloweransi _type isEqualTo toloweransi "Land_MRP_Concessionnaire") exitwith 
	{
		private _ent = nearestObjects [player, ["Land_MRP_Concessionnaire"], 20] # 0;
		if (isnil {_ent} OR {!b_33}) exitwith {};

		private _info_Ent = _ent getVariable ["business",[]];
		private _joueur_Pas_Dans_Ent = !(getPlayerUID player in str _info_Ent);	
		if (_joueur_Pas_Dans_Ent) exitwith {};

		private _ent_Verrouiller = _ent getVariable ['ALF_PorteFermer',FALSE];
		if !(_ent_Verrouiller) then 
		{
			private _texte = "Verrouiller l'entreprise";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				private _ent = nearestObjects [player, ["Land_MRP_Concessionnaire"], 20] # 0;
				_ent setVariable ['ALF_PorteFermer',TRUE,TRUE];
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["Aucun",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["Aucun",_liste_Sous_Actions];
		};

		if (_ent_Verrouiller) then 
		{
			private _texte = "Déverrouiller l'entreprise";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				private _ent = nearestObjects [player, ["Land_MRP_Concessionnaire"], 20] # 0;
				_ent setVariable ['ALF_PorteFermer',FALSE,TRUE];
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions];
		};

		private _joueur_A_Porter_Garage = player distance (_ent getrelpos [16.5,75]) < 6;
		if (_joueur_A_Porter_Garage) then 
		{
			private _joueur_Est_Gerant = ((_info_Ent # 5) select {getPlayerUID player isequalto (_x # 1) AND {4 isequalto (_x # 2)}}) isNotequalto [];	
			if (_joueur_Est_Gerant) then 
			{
				private _texte = "Achat de véhicule";
				private _texte_tooltype = "";
				private _action = 
				{closeDialog 0;
					private _ent = nearestObjects [player, ["Land_MRP_Concessionnaire"], 20] # 0;
					[_ent] spawn ALF_fnc_BusinessCarShop;
				};

				_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
				_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
				_liste_Actions set ["",_liste_Sous_Actions];		
			};		

			private _texte = "Garage de l'entreprise";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				private _ent = nearestObjects [player, ["Land_MRP_Concessionnaire"], 20] # 0;
				[_ent] spawn ALF_fnc_BusinessGarage;
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions];

			private _texte = "Ranger le véhicule proche";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				private _ent = nearestObjects [player, ["Land_MRP_Concessionnaire"], 20] # 0;
				[_ent] call ALF_fnc_BusinessRangerGarage;
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions];
		};
	};

	if (toloweransi _type isEqualTo toloweransi "Land_ALF_Entreprise") exitwith 
	{
		//systemChat "[DEBUG] Interaction_Batiments: Création menu entreprise (MRPV2_fnc_Interaction_Menu_Creation - V2)";
		// Utiliser l'objet détecté directement au lieu de nearestObjects
		private _ent = _objet;
		if (isnil {_ent} OR {isNull _ent}) exitwith {
			//systemChat "[DEBUG] Interaction_Batiments: Entreprise est null ou nil";
		};
		
		private _info_Ent = _ent getVariable ["business",[]];
		
		// Bouton Créer une entreprise (si pas d'entreprise créée)
		if (_info_Ent isEqualTo []) then 
		{
			private _texte = "Créer une entreprise";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				private _ent = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
				if (isnil {_ent} OR {isNull _ent}) exitwith {};
				if !([_ent] call ALF_fnc_hasEnergy) exitWith {["BIE", "L'entreprise n'a pas d'éléctricité.", "danger"] spawn ALF_fnc_doMsg;};
				[_ent] spawn alf_fnc_menuBusiness;
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions];
		};

		private _joueur_Pas_Dans_Ent = !(getPlayerUID player in str _info_Ent);	
		if (_joueur_Pas_Dans_Ent) exitwith {};

		// Bouton Verrouiller/Déverrouiller
		private _ent_Verrouiller = _ent getVariable ['ALF_PorteFermer',FALSE];
		if !(_ent_Verrouiller) then 
		{
			private _texte = "Verrouiller l'entreprise";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				private _ent = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
				if (isnil {_ent} OR {isNull _ent}) exitwith {};
				_ent setVariable ['ALF_PorteFermer',TRUE,TRUE];
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions];
		} else 
		{
			private _texte = "Déverrouiller l'entreprise";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				private _ent = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
				if (isnil {_ent} OR {isNull _ent}) exitwith {};
				_ent setVariable ['ALF_PorteFermer',FALSE,TRUE];
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions];
		};

		// Zone de gestion
		private _joueur_A_Porter_Gestion = player distance (_ent getrelpos [9,125]) < 2;
		if (_joueur_A_Porter_Gestion) then 
		{
			//systemChat format ["DEBUG → Employés = %1", _info_Ent # 5];
			private _uid = getPlayerUID player;
			private _joueur_Est_Gerant = ((_info_Ent # 5) select {
				(_x # 1) isEqualTo _uid AND {(_x # 2) in [3,4]}
			}) isNotEqualTo [];

			// Gestion de l'entreprise (si gérant)
			if (_joueur_Est_Gerant) then 
			{
				private _texte = "Gestion de l'entreprise";
				private _texte_tooltype = "";
				private _action = 
				{closeDialog 0;
					private _ent = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
					if (isnil {_ent} OR {isNull _ent}) exitwith {};
					if !([_ent] call ALF_fnc_hasEnergy) exitWith {["BIE", "L'entreprise n'a pas d'éléctricité.", "danger"] spawn ALF_fnc_doMsg;};
					[_ent] spawn alf_fnc_menuBusiness;
				};

				_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
				_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
				_liste_Actions set ["",_liste_Sous_Actions];
			};
						
			// Prendre/Terminer son service
			private _nom_Ent = _info_Ent # 1;
			private _groupe_Ent_Existe = (groupId group player) isEqualTo _nom_Ent;
			if (_groupe_Ent_Existe) then
			{
				private _texte = "Terminer son service";
				private _texte_tooltype = "";
				private _action =
				{closeDialog 0;
					private _nom_Ent = groupId group player;
					private _collegues = (units group player) - [player];
					[player] joinSilent (createGroup civilian);
					b_enService = false;
					if (b_Depanneur) then {b_Depanneur = false;player setVariable ["CasseService",false,true];};
					if (b_18) then {player setVariable ["CasseService",false,true];player setVariable ["b_18",false,true];};
					["Entreprise", format["Vous avez terminé votre service de %1.", _nom_Ent], "info"] spawn ALF_fnc_doMsg;
					{["Entreprise", format["%1 a terminé son service.", name player], "info"] remoteExec ["ALF_fnc_doMsg", _x]} forEach _collegues;
					[false] call CLIENT_fnc_MRP_Tel_Divers_Prise_Service_CA;
				};

				_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
				_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
				_liste_Actions set ["",_liste_Sous_Actions];
			} else 
			{
				private _texte = "Prendre son service";
				private _texte_tooltype = "";
				private _action =
				{closeDialog 0;
					private _ent = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
					private _info_Ent = _ent getVariable ["business",[]];
					private _nom_Ent = _info_Ent # 1;
					private _groupe_Ent_Existe = ((groups civilian) select {groupId _x isEqualto _nom_Ent}) isnotequalto [];
					private _groupe = "";
					if (_groupe_Ent_Existe) then
					{
						_groupe = ((groups civilian) select {groupId _x isEqualto _nom_Ent}) # 0;
						[player] joinSilent _groupe;
					} else 
					{
						_groupe = createGroup civilian;
						_groupe setGroupIdGlobal [_nom_Ent];
						[player] joinSilent _groupe;
					};
					b_enService = true;
					if (toloweransi "HORIZON" in (toloweransi groupid _groupe) OR {toloweransi "DEPANNAGE" in (toloweransi groupid _groupe)}) then
					{
						b_Depanneur = true;
						player setVariable ["CasseService",true,true];
						player setVariable ["b_Depanneur",true,true];
					};
					if (toloweransi "DIR MARTINIQUE" in (toloweransi groupid _groupe)) then
					{
						player setVariable ["CasseService",true,true];
						player setVariable ["b_18",true,true];
					};

					private _collegues = (units group player) - [player];
					["Entreprise", format["Vous avez pris votre service de %1.", _nom_Ent], "info"] spawn ALF_fnc_doMsg;
					{["Entreprise", format["%1 a pris son service.", name player], "info"] remoteExec ["ALF_fnc_doMsg", _x]} forEach _collegues;
					player setVariable ["entreprise",_nom_Ent,true];
					player setVariable ["batEnt",_ent,true];
					[true] call CLIENT_fnc_MRP_Tel_Divers_Prise_Service_CA;
				};

				_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
				_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
				_liste_Actions set ["",_liste_Sous_Actions];
			};

			// Ouvrir / Fermer entreprise
			private _open = _info_Ent # 12;
			if (_open) then
			{
				private _texte = "Fermer l'entreprise";
				private _texte_tooltype = "";
				private _action =
				{closeDialog 0;
				private _ent = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
				private _info_Ent = _ent getVariable ["business",[]];
				private _nom_Ent = _info_Ent select 1;
				private _open = _info_Ent select 12;

				private _newvalue = false;
				private _var = _ent getVariable ["business",[]];
				_var set[12,_newvalue];

				_ent setVariable ["business",_var,true];
				};

				_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
				_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
				_liste_Actions set ["",_liste_Sous_Actions];
			} else 
			{
				private _texte = "Ouvrir l'entreprise";
				private _texte_tooltype = "";
				private _action =
				{closeDialog 0;
				private _ent = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
				private _info_Ent = _ent getVariable ["business",[]];
				private _nom_Ent = _info_Ent select 1;
				private _open = _info_Ent select 12;

				private _newvalue = true;
				private _var = _ent getVariable ["business",[]];
				_var set[12,_newvalue];

				_ent setVariable ["business",_var,true];
				};

				_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
				_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
				_liste_Actions set ["",_liste_Sous_Actions];
			};

			// Menu FISC (si license_fisc)
			if (license_fisc) then 
			{
				private _texte = "Menu FISC";
				private _texte_tooltype = "";
				private _action = 
				{closeDialog 0;
					private _ent = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
					if (isnil {_ent} OR {isNull _ent}) exitwith {};
					private _info_Ent = _ent getVariable ["business",[]];
					if ((count _info_Ent) > 2) then {
						[0, _info_Ent select 2] call ALF_fnc_dialogFisc;
					};
				};

				_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
				_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
				_liste_Actions set ["",_liste_Sous_Actions];
			};

			// Achat de fourn. de base
			private _texte = "Achat de fourn. de base";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				[nil,nil,nil,"b_0"] call ALF_fnc_weaponShopMenu;
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions];

			// Achat de fourn. d'entreprise
			private _texte = "Achat de fourn. d'entreprise";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				private _ent = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
				if (isnil {_ent} OR {isNull _ent}) exitwith {};
				private _info_Ent = _ent getVariable ["business",[]];
				if ((count _info_Ent) > 4) then {
					private _type_Ent = _info_Ent # 4;
					if (isnil {_type_Ent}) exitwith 
					{
						["Entreprise","Vous n'avez pas été correctement approvisionné, contactez votre fournisseur.", "danger", false] spawn ALF_fnc_doMsg;
					};
					[nil,nil,nil,format ["b_%1",_type_Ent]] call ALF_fnc_weaponShopMenu;
				};
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions];

			// Achat de vêtements
			private _texte = "Achat de vêtements";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				private _ent = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
				if (isnil {_ent} OR {isNull _ent}) exitwith {};
				private _info_Ent = _ent getVariable ["business",[]];
				if ((count _info_Ent) > 4) then {
					private _type_Ent = _info_Ent # 4;
					if (isnil {_type_Ent}) exitwith 
					{
						["Entreprise","Vous n'avez pas été correctement approvisionné, contactez votre fournisseur.", "danger", false] spawn ALF_fnc_doMsg;
					};
					[nil,nil,nil,format ["b_%1",_type_Ent]] spawn ALF_fnc_clothingMenu;
				};
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions];
		};

		// Zone garage
		private _joueur_A_Porter_Garage = player distance (_ent getrelpos [8,-70]) < 6;
		if (_joueur_A_Porter_Garage) then 
		{
			private _uid = getPlayerUID player;
			private _joueur_Est_Gerant = ((_info_Ent # 5) select {
				(_x # 1) isEqualTo _uid AND {(_x # 2) in [3,4]}
			}) isNotEqualTo [];				
			
			// Achat de véhicule (si gérant)
			if (_joueur_Est_Gerant) then 
			{
				private _texte = "Achat de véhicule";
				private _texte_tooltype = "";
				private _action = 
				{closeDialog 0;
					private _ent = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
					if (isnil {_ent} OR {isNull _ent}) exitwith {};
					[_ent] spawn ALF_fnc_BusinessCarShop;
				};

				_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
				_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
				_liste_Actions set ["",_liste_Sous_Actions];
			};

			// Garage de l'entreprise
			private _texte = "Garage de l'entreprise";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				private _ent = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
				if (isnil {_ent} OR {isNull _ent}) exitwith {};
				[_ent] spawn ALF_fnc_BusinessGarage;
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions];

			// Ranger le véhicule proche
			private _texte = "Ranger le véhicule proche";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				private _ent = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
				if (isnil {_ent} OR {isNull _ent}) exitwith {};
				[_ent] call ALF_fnc_BusinessRangerGarage;
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions];
		};
	};

	if (toloweransi _type in [toloweransi "Land_TouristShelter_01_F", toLowerANSI "plp_up_dogkennellight.p3d"]) exitwith 
	{
		if (license_CYNO) then
		{
			private _dog = player getVariable ["ALF_Dog", objNull];
			if (isnull _dog) then 
			{
				private _texte = "Sortir le chien";
				private _texte_tooltype = "";
				private _action = 
				{closeDialog 0;
					[] call ALF_fnc_getDog;
				};

				_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
				_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
				_liste_Actions set ["",_liste_Sous_Actions];
			} else 
			{
				private _texte = "Rentrer le chien";
				private _texte_tooltype = "";
				private _action = 
				{closeDialog 0;
					[] call ALF_fnc_deleteDog;
				};

				_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
				_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
				_liste_Actions set ["",_liste_Sous_Actions];
			};						
		};
	};

	// Interaction Hangar Entreprise
	if (toloweransi _type in [toloweransi "Land_i_Shed_Ind_F", toloweransi "Land_SM_01_shed_F", tolowerANSI "Land_Hangar2", tolowerANSI "Land_entreprise1"]) exitWith 
	{
		//systemChat "[DEBUG] Interaction_Batiments: Création menu hangar (MRPV2_fnc_Interaction_Menu_Creation - V2)";
		// Utiliser l'objet détecté directement au lieu de nearestObjects
		private _hangar = _objet;
		if (isnil {_hangar} OR {isNull _hangar}) exitwith {
			//systemChat "[DEBUG] Interaction_Batiments: Hangar est null ou nil";
		};
		
		private _info_Hangar = _hangar getVariable ["business",[]];
		
		// Vérifier si le hangar a une variable business (acheté pour une entreprise)
		if ((count _info_Hangar) > 0) then 
		{
			private _siret_Hangar = _info_Hangar select 2;
			private _siret_Joueur = player getVariable ["isEmployed",""];
			
			// Vérifier si le joueur est membre de l'entreprise
			if (_siret_Joueur isNotEqualTo "" AND {_siret_Hangar isEqualTo _siret_Joueur}) then 
			{
				// Vérifier s'il y a un bâtiment entreprise (ALF_Entreprise) ou un concessionnaire (Land_MRP_Concessionnaire) à moins de 150m
				private _batiments_Entreprise = nearestObjects [_hangar, ["Land_ALF_Entreprise", "Land_MRP_Concessionnaire"], 150];
				
				private _batiment_Entreprise = objNull;
				{
					private _siret_Ent = (_x getVariable ["business",["","",""]]) select 2;
					if (_siret_Ent isEqualTo _siret_Hangar) exitWith {
						_batiment_Entreprise = _x;
					};
				} forEach _batiments_Entreprise;
				
				// Si un bâtiment entreprise ou concessionnaire est trouvé à moins de 150m
				if (!isNull _batiment_Entreprise) then 
				{
					private _hangar_Verrouiller = _hangar getVariable ['ALF_PorteFermer',FALSE];
					
					// Bouton Verrouiller/Déverrouiller
					if !(_hangar_Verrouiller) then 
					{
						private _texte = "Verrouiller le hangar";
						private _texte_tooltype = "";
						private _action = 
						{closeDialog 0;
							private _hangar = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
							if (isnil {_hangar} OR {isNull _hangar}) exitwith {};
							_hangar setVariable ['ALF_PorteFermer',TRUE,TRUE];
						};

						_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
						_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
						_liste_Actions set ["",_liste_Sous_Actions];
					} else 
					{
						private _texte = "Déverrouiller le hangar";
						private _texte_tooltype = "";
						private _action = 
						{closeDialog 0;
							private _hangar = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
							if (isnil {_hangar} OR {isNull _hangar}) exitwith {};
							_hangar setVariable ['ALF_PorteFermer',FALSE,TRUE];
						};

						_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
						_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
						_liste_Actions set ["",_liste_Sous_Actions];
					};
					
					// Bouton Allumer/Éteindre les lumières
					if (isNull (_hangar getVariable ['lightSource',objNull])) then 
					{
						private _texte = "Allumer les lumières";
						private _texte_tooltype = "";
						private _action = 
						{closeDialog 0;
							private _hangar = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
							if (isnil {_hangar} OR {isNull _hangar}) exitwith {};
							[_hangar] call ALF_fnc_lightHouseAction;
						};

						_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
						_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
						_liste_Actions set ["",_liste_Sous_Actions];
					} else 
					{
						private _texte = "Éteindre les lumières";
						private _texte_tooltype = "";
						private _action = 
						{closeDialog 0;
							private _hangar = (lineIntersectsSurfaces [AGLToASL positionCameraToWorld [0,0,0],AGLToASL positionCameraToWorld [0,0,10],player,objnull,true,1,"GEOM","NONE"]) # 0 # 2;
							if (isnil {_hangar} OR {isNull _hangar}) exitwith {};
							[_hangar] call ALF_fnc_lightHouseAction;
						};

						_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
						_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
						_liste_Actions set ["",_liste_Sous_Actions];
					};
					
					// Bouton Garage (si le hangar est configuré comme garage)
					if ([['ALF_GARAGES', (typeOf _hangar)]] call ALFTools_Client_Config_fnc_isClass) then 
					{
						private _texte = "Accéder au garage";
						private _texte_tooltype = "";
						private _action = 
						{closeDialog 0;
							['vehicles','Car',player] remoteExecCall ['MRPV2_Server_fnc_Vehicule_Garage_Exporter_BDD', 2];
							createDialog 'Life_impound_menu'; 
							disableSerialization; 
							ctrlSetText[2802,'Chargement...'];
						};

						_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
						_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
						_liste_Actions set ["",_liste_Sous_Actions];
						
						private _texte2 = "Ranger le véhicule proche";
						private _texte_tooltype2 = "";
						private _action2 = 
						{closeDialog 0;
							['Car','Civil'] call MRPV2_fnc_Vehicule_Garage_Ranger;
						};

						_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
						_liste_Sous_Actions pushback [_texte2,_texte_tooltype2,_action2];
						_liste_Actions set ["",_liste_Sous_Actions];
					};
				};
			};
		};
		
		[_liste_Actions] call MRPV2_fnc_Interaction_Menu_Creation;
	};
};

// Appel du menu seulement pour les types qui n'ont pas utilisé exitWith (qui créent le menu dans leur bloc)
if (!(_type in [tolowerANSI "Land_i_Shed_Ind_F", tolowerANSI "Land_SM_01_shed_F", tolowerANSI "Land_Hangar2", tolowerANSI "Land_entreprise1"])) then {
	[_liste_Actions] call MRPV2_fnc_Interaction_Menu_Creation;
};
//};
