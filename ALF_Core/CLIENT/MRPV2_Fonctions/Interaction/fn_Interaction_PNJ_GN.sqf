// [{
// MRPV2_fnc_Interaction_PNJ_GN = {
private _objCurseur = toloweransi str cursorObject;
private _liste_Actions = createHashMap;

[] call 
{
	if (toloweransi "MRPV2_PNJ_GN_Garage_Aerien" in _objCurseur) exitWith
	{
		if (life_coplevel > 1) then 
		{
			private _texte = "Magasin aérien gendarmerie";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				["cop_heli","Aérien Gendarmerie"] call ALF_fnc_vehicleShopMenuV2;
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions];  

			private _texte = "Garage aérien gendarmerie";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				["vehicles_cop", "Air", player] remoteExecCall ["MRPV2_Server_fnc_Vehicule_Garage_Exporter_BDD", 2];
				createDialog "Life_impound_menuCopSP";
				disableSerialization;
				ctrlSetText [2802, "Chargement..."];
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions];  

			private _texte = "Ranger l'hélicoptère";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				["Air","Gendarmerie"] call MRPV2_fnc_Vehicule_Garage_Ranger;
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions];  
		} else 
		{
			["GENDARMERIE", "Vous ne faites pas partie de la gendarmerie. Si il y a un problème, voyez avec vos supérieurs.", "warning"] spawn ALF_fnc_doMsg;
		};
	};

		if (toloweransi "MRPV2_PNJ_GN_Garage_Maritime" in _objCurseur) exitWith
	{
		if (life_coplevel > 1) then 
		{
			private _texte = "Magasin Maritime gendarmerie";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				["cop_mari","Maritime Gendarmerie"] call ALF_fnc_vehicleShopMenuV2;
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions];  

			private _texte = "Garage Maritime gendarmerie";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				["vehicles_cop", "Ship", player] remoteExecCall ["MRPV2_Server_fnc_Vehicule_Garage_Exporter_BDD", 2];
				createDialog "Life_impound_menuCopSP";
				disableSerialization;
				ctrlSetText [2802, "Chargement..."];
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions];  

			private _texte = "Ranger l'embarcation";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				["Ship","Gendarmerie"] call MRPV2_fnc_Vehicule_Garage_Ranger;
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions];  
		} else 
		{
			["GENDARMERIE", "Vous ne faites pas partie de la gendarmerie. Si il y a un problème, voyez avec vos supérieurs.", "warning"] spawn ALF_fnc_doMsg;
		};
	};

	if (toloweransi "MRPV2_PNJ_GN_Prise_Service" in _objCurseur) exitWith
	{
		if (life_coplevel > 0) then 
		{
			if !(life_gendarme_service) then 
			{
				private _texte = "Prise de service";
				private _texte_tooltype = "";
				private _action = 
				{closeDialog 0;
					[cursorObject, player, "Prise de service", "priseservice_GN_2"] call ALF_fnc_CopService;
				};

				_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
				_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
				_liste_Actions set ["",_liste_Sous_Actions];  
			};

			if (life_gendarme_service) then 
			{
				private _texte = "Fin de service";
				private _texte_tooltype = "";
				private _action = 
				{closeDialog 0;
					[cursorObject, player, "Fin de service"] call ALF_fnc_CopService;
				};

				_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
				_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
				_liste_Actions set ["",_liste_Sous_Actions]; 

				private _texte = "Armurerie";
				private _texte_tooltype = "";
				private _action = 
				{closeDialog 0;
					[nil, nil, nil, "copw"] call ALF_fnc_weaponShopMenu;
				};

				_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
				_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
				_liste_Actions set ["",_liste_Sous_Actions];		          
			};

			if (life_coplevel > 8) then 
			{
				private _texte = "Carte banque";
				private _texte_tooltype = "";
				private _action = 
				{closeDialog 0;
					[nil, nil, nil, "cop_bank"] call ALF_fnc_weaponShopMenu;
				};

				_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
				_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
				_liste_Actions set ["",_liste_Sous_Actions];		          
			};

			private _texte = "Magasin de vêtements";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				[nil, nil, nil, "cop"] spawn ALF_fnc_clothingMenu;
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions]; 

			private _texte = "Magasin de plongé";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				[nil, nil, nil, "plongeg"] spawn ALF_fnc_clothingMenu;
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions]; 

			private _texte = "Marché général";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				[nil, nil, nil, "cop"] call ALF_fnc_weaponShopMenu;
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions]; 
		} else 
		{
			["GENDARMERIE", "Vous ne faites pas partie de la gendarmerie. Si il y a un problème, voyez avec vos supérieurs.", "warning"] spawn ALF_fnc_doMsg;
		};		
	};

	if (toloweransi "MRPV2_PNJ_GN_Garage" in _objCurseur) exitWith
	{
		if (life_coplevel > 0) then 
		{
			private _texte = "Magasin véhicule gendarmerie";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				["cop", "Magasin véhicule gendarmerie"] call ALF_fnc_vehicleShopMenuV2;
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions]; 

			private _texte = "Garage gendarmerie";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				["vehicles_cop","Car",player] remoteExecCall ["MRPV2_Server_fnc_Vehicule_Garage_Exporter_BDD",2];
				createDialog "Life_impound_menuCopSP";
				disableSerialization;
				ctrlSetText [2802, "Chargement..."];
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions]; 

			private _texte = "Ranger véhicule gendarmerie";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				["Car","Gendarmerie"] call MRPV2_fnc_Vehicule_Garage_Ranger;
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
			["GENDARMERIE", "Vous ne faites pas partie de la gendarmerie. Si il y a un problème, voyez avec vos supérieurs.", "warning"] spawn ALF_fnc_doMsg;
		};
	};
};

_liste_Actions
// };
// }] remoteExec ['call',0,true];