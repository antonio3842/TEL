// [{
// MRPV2_fnc_Interaction_PNJ_Coop_Vente = {
private _liste_Actions = createHashMap;
private _objCurseur = tolowerANSI str cursorObject;


[] call 
{
	private _infos = [];	

	if ("comm_" in _objCurseur OR {"coop_" in _objCurseur}) exitwith 
	{
		[] call 
		{
			if (tolowerANSI "Coop_cuivre" in _objCurseur) exitWith {_infos = ["vente_cuivre", "Revendeur de Cuivre"];};
			if (tolowerANSI "Coop_fer" in _objCurseur) exitWith {_infos = ["vente_fer", "Revendeur de Fer"];};
			if (tolowerANSI "Coop_diams" in _objCurseur) exitWith {_infos = ["vente_dia", "Revendeur de Diamant"];};
			if (tolowerANSI "Coop_saphir" in _objCurseur) exitWith {_infos = ["vente_saphir", "Revendeur de Saphir"];};
			if (tolowerANSI "Coop_pierre" in _objCurseur) exitWith {_infos = ["vente_pierre", "Revendeur de Pierre"];};
			if (tolowerANSI "Coop_Vente_Fruit_Legume" in _objCurseur) exitWith {_infos = ["vente_fruits", "Revendeur Fruits et légumes"];};
			if (tolowerANSI "Coop_petrole" in _objCurseur) exitWith {_infos = ["vente_petrole", "Revendeur de Pétrole"];};
			if (tolowerANSI "Coop_Tabac" in _objCurseur) exitWith {_infos = ["vente_tabac", "Revendeur de Tabac"];};
			if (tolowerANSI "Comm_Superette_Station" in _objCurseur) exitWith {_infos = ["station", "Magasin de supérette"];};
			if (tolowerANSI "Comm_Magasin_General" in _objCurseur) exitWith {_infos = ["genstore", "Marché général"];};
			if (tolowerANSI "Comm_Vetement" in _objCurseur) exitWith {_infos = ["Bruce", "Vêtements (Homme)"];};
			if (tolowerANSI "Comm_Marche" in _objCurseur) exitWith {_infos = ["market", "Marché"];};
			if (tolowerANSI "Comm_Achat_Baril" in _objCurseur) exitWith {_infos = ["barile", "Achat de baril"];};
			if (tolowerANSI "Comm_Vente_Bois" in _objCurseur) exitWith {_infos = ["vente_bois", "Revendeur de Bois"];};		
			if (tolowerANSI "Comm_Vendeur_Graine" in _objCurseur) exitWith {_infos = ["mais", "Vendeur de graines"];}; 
			if (tolowerANSI "Comm_Tabac_Achat" in _objCurseur) exitWith {_infos = ["tabac", "Vendeur de graines de Tabac"];}; 
			if (tolowerANSI "Comm_Vente_Or" in _objCurseur) exitWith {_infos = ["vente_or", "Revendeur d'or"];};   
			if (tolowerANSI "Comm_Vente_Mais" in _objCurseur) exitWith {_infos = ["vente_mais", "Revendeur de maïs"];};	
			if (tolowerANSI "Comm_Poissonnerie" in _objCurseur) exitWith {_infos = ["vente_poisson", "Revendeur de poisson"];};
			if (tolowerANSI "Comm_Bijoutier" in _objCurseur) exitWith {_infos = ["bijoutier", "Bijoutier"];};	   
		};

		if (_infos isEqualTo []) exitwith {};

		private _texte = (_infos # 1);
		private _texte_tooltype = "";

		private _action = 
		{closeDialog 0;
			private _infos = [];
			private _objCurseur = tolowerANSI str cursorObject;
			[] call 
			{
				if (tolowerANSI "Coop_cuivre" in _objCurseur) exitWith {_infos = ["vente_cuivre", "Revendeur de Cuivre"];};
				if (tolowerANSI "Coop_fer" in _objCurseur) exitWith {_infos = ["vente_fer", "Revendeur de Fer"];};
				if (tolowerANSI "Coop_diams" in _objCurseur) exitWith {_infos = ["vente_dia", "Revendeur de Diamant"];};
				if (tolowerANSI "Coop_saphir" in _objCurseur) exitWith {_infos = ["vente_saphir", "Revendeur de Saphir"];};
				if (tolowerANSI "Coop_pierre" in _objCurseur) exitWith {_infos = ["vente_pierre", "Revendeur de Pierre"];};
				if (tolowerANSI "Coop_Vente_Fruit_Legume" in _objCurseur) exitWith {_infos = ["vente_fruits", "Revendeur Fruits et légumes"];};
				if (tolowerANSI "Coop_petrole" in _objCurseur) exitWith {_infos = ["vente_petrole", "Revendeur de Pétrole"];};
				if (tolowerANSI "Coop_Tabac" in _objCurseur) exitWith {_infos = ["vente_tabac", "Revendeur de Tabac"];};
				if (tolowerANSI "Comm_Superette_Station" in _objCurseur) exitWith {_infos = ["station", "Magasin de supérette"];};
				if (tolowerANSI "Comm_Magasin_General" in _objCurseur) exitWith {_infos = ["genstore", "Marché général"];};
				if (tolowerANSI "Comm_Vetement" in _objCurseur) exitWith {_infos = ["Bruce", "Vêtements (Homme)"];};
				if (tolowerANSI "Comm_Marche" in _objCurseur) exitWith {_infos = ["market", "Marché"];};
				if (tolowerANSI "Comm_Achat_Baril" in _objCurseur) exitWith {_infos = ["barile", "Achat de baril"];};
				if (tolowerANSI "Comm_Vente_Bois" in _objCurseur) exitWith {_infos = ["vente_bois", "Revendeur de Bois"];};		
				if (tolowerANSI "Comm_Vendeur_Graine" in _objCurseur) exitWith {_infos = ["mais", "Vendeur de graines"];}; 
				if (tolowerANSI "Comm_Tabac_Achat" in _objCurseur) exitWith {_infos = ["tabac", "Vendeur de graines de Tabac"];}; 
				if (tolowerANSI "Comm_Vente_Or" in _objCurseur) exitWith {_infos = ["vente_or", "Revendeur d'or"];};   
				if (tolowerANSI "Comm_Vente_Mais" in _objCurseur) exitWith {_infos = ["vente_mais", "Revendeur de maïs"];};	
				if (tolowerANSI "Comm_Poissonnerie" in _objCurseur) exitWith {_infos = ["vente_poisson", "Revendeur de poisson"];};
				if (tolowerANSI "Comm_Bijoutier" in _objCurseur) exitWith {_infos = ["bijoutier", "Bijoutier"];};	   
			};

			private _info = _infos # 0;
			private _nom = _infos # 1;

			[] call 
			{
				if (_info isEqualTo "vente_cuivre") exitwith {[cursorobject,player,_nom,_info] call ALF_fnc_itemsVenteMenu;};
				if (_info isEqualTo "vente_fer") exitwith {[cursorobject,player,_nom,_info] call ALF_fnc_itemsVenteMenu;};
				if (_info isEqualTo "vente_dia") exitwith {[cursorobject,player,_nom,_info] call ALF_fnc_itemsVenteMenu;};
				if (_info isEqualTo "vente_saphir") exitwith {[cursorobject,player,_nom,_info] call ALF_fnc_itemsVenteMenu;};
				if (_info isEqualTo "vente_pierre") exitwith {[cursorobject,player,_nom,_info] call ALF_fnc_itemsVenteMenu;};
				if (_info isEqualTo "vente_fruits") exitwith {[cursorobject,player,_nom,_info] call ALF_fnc_itemsVenteMenu;};
				if (_info isEqualTo "vente_petrole") exitwith {[cursorobject,player,_nom,_info] call ALF_fnc_itemsVenteMenu;};
				if (_info isEqualTo "vente_tabac") exitwith {[cursorobject,player,_nom,_info] call ALF_fnc_itemsVenteMenu;};
				if (_info isEqualTo "station") exitwith {[cursorobject,player,_nom,_info] call ALF_fnc_weaponShopMenu;};
				if (_info isEqualTo "genstore") exitwith {[cursorobject,player,_nom,_info] call ALF_fnc_weaponShopMenu;};
				if (_info isEqualTo "Bruce") exitwith {[cursorobject,player,_nom,_info] spawn ALF_fnc_clothingMenu;};
				if (_info isEqualTo "market") exitwith {[cursorobject,player,_nom,_info] call ALF_fnc_weaponShopMenu;};
				if (_info isEqualTo "barile") exitwith {[cursorobject,player,_nom,_info] call ALF_fnc_weaponShopMenu;};
				if (_info isEqualTo "vente_bois") exitwith {[cursorobject,player,_nom,_info] call ALF_fnc_itemsVenteMenu;};
				if (_info isEqualTo "mais") exitwith {[cursorobject,player,_nom,_info] call ALF_fnc_weaponShopMenu;};
				if (_info isEqualTo "tabac") exitwith {[cursorobject,player,_nom,_info] call ALF_fnc_weaponShopMenu;};
				if (_info isEqualTo "vente_or") exitwith {[cursorobject,player,_nom,_info] call ALF_fnc_itemsVenteMenu;};
				if (_info isEqualTo "vente_mais") exitwith {[cursorobject,player,_nom,_info] call ALF_fnc_itemsVenteMenu;};		
				if (_info isEqualTo "vente_poisson") exitwith {[cursorobject,player,_nom,_info] call ALF_fnc_itemsVenteMenu;};

				comment "a voir peut etre un marchant donateur (life_donor)";
				if (_info isEqualTo "bijoutier") exitwith {[cursorobject,player,_nom,_info] call ALF_fnc_weaponShopMenu;};
			};
		};

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];
	};

	if (tolowerANSI "Comm_Vetement" in _objCurseur) exitwith
	{

		if (!isnil {License_Femme}) then 
		{
			private _texte = "Vêtements (Femme)";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				[nil,nil,nil,"Women"] spawn ALF_fnc_clothingMenu;
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions];
		};	

		private _texte = "Vêtements (Chasseur)";
		private _texte_tooltype = "";
		private _action = 
		{closeDialog 0;
			[nil,nil,nil,"Chasseur"] spawn ALF_fnc_clothingMenu;
		};

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];
	};

	if (tolowerANSI "station" in _objCurseur) exitwith
	{
		private _est_armer = currentWeapon player isnotequalto "";
		private _a_Bonne_Arme = !(currentWeapon player in 
		[
			"ALF_Peinture_Black","ALF_Peinture_Green","ALF_Pancarte_Dormir","ALF_Pancarte_Amour","ALF_Pancarte_Manje","ALF_Pancarte_Incompetants",
			"ALF_Pancarte_NikLaGN","ALF_Pancarte_Banque","ALF_Pancarte_Climat","ALF_Pancarte_Corruption","ALF_Pancarte_Impots","ALF_Pancarte_Vener",
			"ALF_sifflet","ALF_Batte","ALF_Hache","ALF_Faux","ALF_Camera","ALF_Flash_Light"
		]);

		if (_est_armer AND {_a_Bonne_Arme}) then
		{
			private _texte = "Braquage de supérette";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				[cursorObject] spawn ALF_fnc_braquageStation;
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions];		
		};
	};

	if (tolowerANSI "MRPV2_PNJ_Plonger" in _objCurseur) exitwith
	{
		private _texte = "Magasin de plongée";
		private _texte_tooltype = "";
		private _action = 
		{closeDialog 0;
			[nil,nil,nil,"plonge"] spawn ALF_fnc_clothingMenu;
		};

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];
	};

	if (tolowerANSI "MRPV2_PNJ_Shop_Farce_et_Attrape" in _objCurseur) exitwith
	{
		private _texte = "Magasin de Farce et Attrape";
		private _texte_tooltype = "";
		private _action = 
		{closeDialog 0;
			[nil,nil,nil,"farce"] spawn ALF_fnc_clothingMenu;
		};

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];
	};

	if (tolowerANSI "MRPV2_PNJ_Ikea" in _objCurseur) exitwith
	{
		private _texte = "Magasin Ikea";
		private _texte_tooltype = "";
		private _action = 
		{closeDialog 0;
			[cursorobject,player,"Magasin Ikea","ikea"] call ALF_fnc_weaponShopMenu;
		};

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];

		private _texte = "Revendeur de planche";
		private _texte_tooltype = "";
		private _action = 
		{closeDialog 0;
			[nil,nil,nil,"vente_planche"] call ALF_fnc_itemsVenteMenu;
		};

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];
	};

	if (tolowerANSI "MRPV2_PNJ_Orange" in _objCurseur) exitwith
	{
		private _texte = "Forfait";
		private _texte_tooltype = "";
		private _action = 
		{closeDialog 0;
			["Orange","Connexion avec le service client d'Orange.","warning", false] spawn ALF_fnc_doMsg;
			[] call ALF_fnc_menuForfait;
		};

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];

		private _texte = "Magasin";
		private _texte_tooltype = "";
		private _action = 
		{closeDialog 0;
			[nil,nil,nil,"orange"] call ALF_fnc_weaponShopMenu;
		};

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];
	};
};

_liste_Actions
// };
// }] remoteExec ['call',0,true];