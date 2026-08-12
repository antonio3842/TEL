// MRPV2_fnc_Interaction_PNJ_Cooperative = {
private _liste_Actions = createHashMap;
private _objCurseur = tolowerANSI str cursorObject;


[] call 
{
	private _infos = [];	

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
		if (tolowerANSI "Comm_Plonger" in _objCurseur) exitWith {_infos = ["plonge", "Magasin de plongée"];};	   
		if (tolowerANSI "Comm_Farce_et_Attrape" in _objCurseur) exitWith {_infos = ["farce", "Magasin de Farce et Attrape"];}; 
		if (tolowerANSI "Comm_vente_export" in _objCurseur) exitWith {_infos = ["vente_export", "Exportation"];};
		if (tolowerANSI "Comm_vente_boucherie" in _objCurseur) exitWith {_infos = ["vente_boucherie", "Boucherie"];};
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
			if (tolowerANSI "Comm_Plonger" in _objCurseur) exitWith {_infos = ["plonge", "Magasin de plongée"];};	   
			if (tolowerANSI "Comm_Farce_et_Attrape" in _objCurseur) exitWith {_infos = ["farce", "Magasin de Farce et Attrape"];};	   
			if (tolowerANSI "Comm_Vetement_VIP" in _objCurseur) exitWith {_infos = ["premium", "Vetement de Luxe"];};
			if (tolowerANSI "Comm_vente_export" in _objCurseur) exitWith {_infos = ["vente_export", "Exportation"];};   
			if (tolowerANSI "Comm_vente_boucherie" in _objCurseur) exitWith {_infos = ["vente_boucherie", "Boucherie"];};   
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
			if (_info isEqualTo "vente_export") exitwith {[cursorobject,player,_nom,_info] call ALF_fnc_itemsVenteMenu;};
			if (_info isEqualTo "vente_boucherie") exitwith {[cursorobject,player,_nom,_info] call ALF_fnc_itemsVenteMenu;};
			if (_info isEqualTo "plonge") exitwith {[cursorobject,player,_nom,_info] spawn ALF_fnc_clothingMenu;};
			if (_info isEqualTo "farce") exitwith {[cursorobject,player,_nom,_info] spawn ALF_fnc_clothingMenu;};

			comment "a voir peut etre un marchant donateur (life_donor)";
			if (_info isEqualTo "bijoutier") exitwith {[cursorobject,player,_nom,_info] call ALF_fnc_weaponShopMenu;};
if (_info isEqualTo "plongee") exitwith {[cursorobject,player,_nom,_info] call ALF_fnc_weaponShopMenu;};

		};
	};

	_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];

// Action 1 : EXISTANT — "Magasin de plongée" (clothing)
_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];

// Action 2 : NOUVEAU — "Fourniture plongée" (shop d'achat)
if (_texte isEqualTo "Magasin de plongée") then {
    private _texte2 = "Fourniture plongée";
    private _action2 = {
        closeDialog 0;
        private _nom = "Fourniture plongée";
        private _info = "plongee";
        [cursorObject, player, _nom, _info] call ALF_fnc_weaponShopMenu;
    };
    _liste_Sous_Actions pushback [_texte2, "", _action2];
};

_liste_Actions set ["",_liste_Sous_Actions];
};

_liste_Actions
// };