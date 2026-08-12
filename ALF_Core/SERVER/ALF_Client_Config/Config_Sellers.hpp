/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/
class ItemsVente {

	ALF_ConfigToClient_Patern[] = {
        {"ANY", "CLASS", {
            {"name", "STRING"},
            {"items", "ARRAY"}
        }}
    };

	class vente_mais {
		name = "Revendeur de Mais";
		items[] = {
			{ "ALF_Mais", "" }
		};
	};
	class vente_pierre {
	name = "Revendeur de Pierre";
		items[] = {
		  { "ALF_pierre_small", "" }
		};
	};
	class vente_bois {
		name = "Revendeur de bois";
		items[] = {
			{ "ALF_Buche", "" }
		};
	};
	class vente_planche {
		name = "Revendeur de planche";
		items[] = {
			{ "ALF_Planche_B", "" }
		};
	};
	class vente_cuivre {
		name = "Revendeur de Cuivre";
		items[] = {
		  { "ALF_Cuivre", "" }
		};
	};
	class vente_fer {
		name = "Revendeur de Fer";
		items[] = {
		  { "ALF_Fer", "" }
		};
	};
	class vente_bronze {
		name = "Revendeur de Bronze";
		items[] = {
		  { "ALF_Bronze", "" }
		};
	};
	class vente_argent {
		name = "Revendeur d'Argent";
		items[] = {
		  { "ALF_Argent", "" }
		};
	};
	class vente_or {
		name = "Revendeur d'Or";
		items[] = {
		  { "ALF_Or", "" }
		};
	};
	class vente_dia {
		name = "Revendeur de Diamant";
		items[] = {
		  { "ALF_diamant_taille", "" },
		  { "ALF_diamant_precieux", "" }
		};
	};
	class vente_saphir {
		name = "Revendeur de Saphir";
		items[] = {
		  { "ALF_saphir_taille", "" },
		  { "MRP_saphir_precieux", "" }
		};
	};
	class vente_drogues {
		name = "Dealer de drogues";
		items[] = {
			{ "ALF_Weed", "" },
			{ "ALF_Weed_2", "" },
			{ "ALF_Weed_3", "" },
			{ "ALF_Weed_P", "" },
			{ "ALF_Weed_P_2", "" },
			{ "ALF_Weed_P_3", "" },
			{ "ALF_Relique_1", "" },
			{ "ALF_Relique_2", "" },
			{ "ALF_Relique_3", "" },
			{ "ALF_Cupidon", "" },
			{ "ALF_Cocaine", "" },
			{ "ALF_Cocaine_2", "" },
			{ "ALF_Meth50", "" },
			{ "ALF_Meth90", "" },
			{ "Carapace_Tortue", "" },
			{ "Viande_Tortue", "" },
		    { "ALF_Squale", "" }
		};
	};
	class vente_vin {
		name = "Revendeur Alcool";
		items[] = {
		  { "ALF_Whisky", "" },
		  { "ALF_XxX", "" },
		  { "ALF_Vin", "" },
		  { "ALF_Pinot", "" }
		};
	};
	class vente_fruits {
		name = "Fruits & Légumes";
		items[] = {
		  { "ALF_Banane", "" },
		  { "ALF_Peche", "" },
		  { "ALF_Raisin", "" },
		  { "ALF_Confiture_Pomme", "" },
		  { "ALF_Confiture_Fraise", "" },
		  { "ALF_Fraise", "" },
		  { "ALF_Champignon", "" },
		  { "ALF_Truffe", "" } 
		};
	};
	// class vente_fruits2 {
	// 	name = "Fruits & Légumes";
	// 	items[] = {
	// 	  { "ALF_Fraise", "" },
	// 	  { "ALF_Champignon", "" },
	// 	  { "ALF_Truffe", "" }
	// 	};
	// };
	class vente_huitre {
		name = "Revendeur d'huitre";
		items[] = {
		  { "ALF_Huitre", "" }
		};
	};
	class vente_poisson {
		name = "Revendeur de poisson";
		items[] = {
		  { "ALF_Maquereau_Crue_M", "" },
		  { "ALF_Maquereau_Cuit_M", "" },
		  { "ALF_Sardine", "" },
		  { "ALF_Barbeau", "" },
		  { "ALF_Thon", "" },
		  { "ALF_Saumon", "" },
		  { "ALF_Brochet", "" },
		  { "ALF_Anguille", "" },
		  { "MRP_Sushi_Thon", "" },
		  { "MRP_Sushi_Saumon", "" }

		};
	};
	class vente_jus {
		name = "Revendeur de jus";
		items[] = {
			{ "ALF_Jus_Pomme", "" },
			{ "ALF_Jus_Fraise", "" },
			{ "ALF_Jus_Raisin", "" }
		};
	};
	class vente_petrole {
		name = "Revendeur de petrole";
		items[] = {
		  { "ALF_Barile_P_F", "" },
		  { "ALF_Barile_Station", "" },
		  { "ALF_Caoutchou", "" }
		};
	};
	class vente_tabac {
		name = "Revendeur de Tabac";
		items[] = {
		  { "murshun_cigs_cig0", "" },
		  { "ALF_Tabac_Seche", "" }		  
		};
	};

	class vente_export {
		name = "Exportation";
		items[] = {
		  { "carton_rhum", "" }	,
		  { "bouteille_rhum", "" }	,
		  { "MRP_Palette", "" },
		  { "MRP_Linteau_x6", "" },
		  { "MRP_Carton_Compote", "" },
		  { "Verre_plat", "" },
		  { "MRP_IPN_x6", "" },
		  { "peau_mouton", "" },
		  { "Verre_plat_x10", "" }
		};
	};

	class vente_boucherie {
		name = "Revendeur de viande";
		items[] = {
		  { "MRP_Blanc_Poulet", "" },
		  { "MRP_Cote_agneau", "" },
		  { "MRP_viande_lapin", "" }
		};
	};
};
class InventoryItemsDepositTake {

	ALF_ConfigToClient_Patern[] = {
        {"items_disabled", "ARRAY"}
    };

	//Désactiver le déposer/prendre tout d'un item dans l'inventaire
	items_disabled[] = {
		"ALF_Weed",
		"ALF_Weed_2",
		"ALF_Weed_3",
		"ALF_Weed_P",
		"ALF_Weed_P_2",
		"ALF_Weed_P_3",
		"ALF_Relique_1",
		"ALF_Relique_2",
		"ALF_Relique_3",
		"ALF_Cupidon",
		"ALF_Cocaine",
		"ALF_Cocaine_2",
		"ALF_Meth50",
		"ALF_Meth90"
	};
};
