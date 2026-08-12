// MRPV2_fnc_Interaction_PNJ_PM = {
private _objCurseur = toloweransi str cursorObject;
private _liste_Actions = createHashMap;

[] call 
{
	if (toloweransi "MRPV2_PNJ_PM_Prise_Service" in _objCurseur) exitWith
	{
		if (life_penit > 0) then 
		{
			if !(life_penit_service) then 
			{
				private _texte = "Prise de service";
				private _texte_tooltype = "";
				private _action = 
				{closeDialog 0;
					[cursorObject, player, "Prise de service", "priseservice_PM_2"] call ALF_fnc_PenitService;
				};

				_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
				_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
				_liste_Actions set ["",_liste_Sous_Actions];  
			};

			if (life_penit_service) then 
			{
				private _texte = "Fin de service";
				private _texte_tooltype = "";
				private _action = 
				{closeDialog 0;
					[cursorObject, player, "Fin de service"] call ALF_fnc_PenitService;
				};

				_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
				_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
				_liste_Actions set ["",_liste_Sous_Actions]; 		          
			};

			private _texte = "Magasin de vêtements pm";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				[nil, nil, nil, "policemunicipale"] spawn ALF_fnc_clothingMenu;
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions]; 

			private _texte = "Magasin de vêtements penit";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				[nil, nil, nil, "prisonpro"] spawn ALF_fnc_clothingMenu;
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions]; 

			private _texte = "Armurerie";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				[nil, nil, nil, "pmweapon"] spawn ALF_fnc_weaponShopMenu;
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions]; 

			private _texte = "Marché général";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				[nil, nil, nil, "pmgeneral"] call ALF_fnc_weaponShopMenu;
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions]; 
		} else 
		{
			["Police Municipale", "Vous ne faites pas partie de la PM. Si il y a un problème, voyez avec vos supérieurs.", "warning"] spawn ALF_fnc_doMsg;
		};		
	};

	if (toloweransi "MRPV2_PNJ_PM_Garage" in _objCurseur) exitWith
	{
		if (life_penit > 0) then 
		{
			private _texte = "Magasin véhicule Police Municipale";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				["policemunicipale", "Magasin véhicule Police Municipale"] call ALF_fnc_vehicleShopMenuV2;
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions]; 

			private _texte = "Garage Police Municipale";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				["vehicles_penit","Car",player] remoteExecCall ["MRPV2_Server_fnc_Vehicule_Garage_Exporter_BDD",2];
				createDialog "Life_impound_menuCopSP";
				disableSerialization;
				ctrlSetText [2802, "Chargement..."];
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions]; 

			private _texte = "Ranger véhicule Police Municipale";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				["Car","policemunicipale"] call MRPV2_fnc_Vehicule_Garage_Ranger;
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions]; 

			private _texte = "Mon garage civil";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				["vehicles", "Car", player] remoteExecCall ["MRPV2_Server_fnc_Vehicule_Garage_Exporter_BDD",2];
				createDialog "Life_impound_menu";
				disableSerialization;
				ctrlSetText [2802, "Chargement..."];
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions]; 

			private _texte = "Ranger mon véhicule civil";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				["Car","Civil"] call MRPV2_fnc_Vehicule_Garage_Ranger;
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions];  
		} else 
		{
			["police municipale", "Vous ne faites pas partie de la police municipale. Si il y a un problème, voyez avec vos supérieurs.", "warning"] spawn ALF_fnc_doMsg;
		};
	};
};

_liste_Actions
// };