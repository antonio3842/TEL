/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.


*    Format:
*        level: ARRAY (This is for limiting items to certain things)
*            0: Variable to read from
*            1: Variable Value Type (SCALAR / BOOL / EQUAL)
*            2: What to compare to (-1, "" = Check Disabled)
*            3: Custom exit message (Optional)
*
*    items: { Classname, Itemname, BuyPrice, SellPrice }
*
*    Itemname only needs to be filled if you want to rename the original object name.
*
*    Weapon classnames can be found here: https://community.bistudio.com/wiki/Arma_3_CfgWeapons_Weapons
*    Item classnames can be found here: https://community.bistudio.com/wiki/Arma_3_CfgWeapons_Items
*
*/
class WeaponShops {

	ALF_ConfigToClient_Patern[] = {
        {"ANY", "CLASS", {
            {"name", "STRING"},
			{"license", "STRING"},
            {"items", "ARRAY"}
        }}
    };

	/////////////////////////////////////////////////////
	class b_0 {
        name = "Magasin de base";
        license = "";
        items[] = {
			{ "ALF_Conteneur_Ent_boite", "", 30000, -1, "" },
			{ "ALF_Roue", "", 45, -1, "" },
			{ "ALF_Boiteaoutils", "", 35, -1, "" },
			{ "ALF_Pioche", "", 150, -1, "" },
			//{ "MRP_Pelle", "", 150, -1, "" },
			{ "ALF_Hache", "", 200, -1, "" },
			{ "ALF_Banane", "", 15, -1, "" },
			{ "ALF_BaconT", "", 9, -1, "" },
			{ "ALF_WaterB_P", "", 3, -1, "" },
			{ "ALF_WaterB_G", "", 6, -1, "" },
			{ "ALF_coca", "", 2, -1, "" }
        };
    };
	class b_2 {
        name = "Magasin 2";
        license = "";
        items[] = {
			{ "ALF_Conteneur_Ent_boite", "", 30000, -1, "" },
			{ "ALF_Banane", "", 15, -1, "" },
			{ "ALF_Pain", "", 1, -1, "" },
			{ "ALF_Kebab", "", 7, -1, "" },
			{ "ALF_snickers", "", 3, -1, "" },
			{ "ALF_BakedBeans", "", 6, -1, "" },
			{ "ALF_BaconT", "", 9, -1, "" },
			{ "ALF_WaterB_P", "", 3, -1, "" },
			{ "ALF_WaterB_G", "", 6, -1, "" },
			{ "ALF_coca", "", 2, -1, "" },
			{ "ALF_Jus", "", 2, -1, "" },
			{ "ALF_1664", "", 8, -1, "" },
			{ "ALF_Vodka", "", 15, -1, "" },
			{ "ALF_Rome", "", 25, -1, "" },
			{ "ALF_Malibu", "", 25, -1, "" },
			{ "ALF_Luxe2", "", 25, -1, "" },
			{ "ALF_Luxe1", "", 25, -1, "" },
			{ "ALF_Jock", "", 25, -1, "" },
			{ "ALF_Jager", "", 25, -1, "" },
			{ "ALF_Horse", "", 25, -1, "" },
			{ "ALF_51", "", 25, -1, "" },
			{ "ALF_Sky", "", 25, -1, "" },
			{ "ALF_Vazisi", "", 25, -1, "" },
			{ "ALF_Smirnoff", "", 25, -1, "" },
			{ "ALF_Saucisse_Crue_M", "", 10, -1, "" },
			{ "ALF_Bacon_Crue_M", "", 10, -1, "" },
			{ "ALF_CotePorc_Crue_M", "", 25, -1, "" },
			{ "ALF_Poulet_Crue_M", "", 10, -1, "" }
        };
    };
    class b_4 {
        name = "Magasin DÃ©panneur HDM";
        license = "";
        items[] = {
			{ "ALF_Conteneur_Ent_boite", "", 30000, -1, "" },
			{ "ALF_Roue", "", 45, -1, "" },
			{ "ALF_Boiteaoutils", "", 35, -1, "" },
			{ "O2_Signal_Item_Trav_dang", "", 35, -1, "" },
			{ "ALF_Triangle_Item", "", 35, -1, "" },
			{ "ALF_KitMecatechnic", "", 25, -1, "" },
			{ "ALF_Reservoir", "", 5, -1, "" },
			{ "ALF_Vitre", "", 5, -1, "" },
			{ "ALF_Caross", "", 5, -1, "" },
			{ "ALF_Moteur", "", 5, -1, "" },
			{ "ALF_Banane", "", 15, -1, "" },
			{ "ALF_BaconT", "", 9, -1, "" },
			{ "ALF_WaterB_P", "", 3, -1, "" },
			{ "ALF_WaterB_G", "", 6, -1, "" },
			{ "O2_Signal_Item_Cone", "", 35, -1, "" },
			{ "ALF_coca", "", 2, -1, "" },
			{ "ItemGPS", "", 35, -1, "" },
			{ "ItemMap", "", 50, -1, "" },
			{ "ItemCompass", "", 15, -1, "" },
			{ "ItemWatch", "", 39, -1, "" }
        };
    };
	//Secu + Brinks
    class b_6 {
        name = "Magasin 6";
        license = "";
        items[] = {
			{ "ALF_Conteneur_Ent_boite", "", 30000, -1, "" },
			//{ "MRP_X26", "", 500, -1, "" },
			//{ "MRP_Taser_laser", "", 500, -1, "" },
			//{ "MRP_Taser_Mag", "", 100, -1, "" },
			{ "ALF_KA_Glock_17_Single", "", 10000, -1, "" },
			{ "ALF_KA_17Rnd_9x19_Mag", "", 170, -1, "" },
        	//{ "M_ALF_Security_boite", "", 800, -1, "" },
			//{ "ALF_Brassard_Secu", "", 75, -1, "" },
        	{ "ALF_Safe_1_boite", "", 4000, -1, "" },
			{ "ALF_Roue", "", 45, -1, "" },
			{ "ALF_Boiteaoutils", "", 35, -1, "" },
			{ "ALF_KitMecatechnic", "", 25, -1, "" },
			{ "ALF_Banane", "", 15, -1, "" },
			{ "ALF_BaconT", "", 9, -1, "" },
			{ "ALF_WaterB_P", "", 3, -1, "" },
			{ "ALF_WaterB_G", "", 6, -1, "" },
			{ "ALF_coca", "", 2, -1, "" },
			{ "ItemGPS", "", 35, -1, "" },
			{ "ItemMap", "", 50, -1, "" },
			{ "ItemCompass", "", 15, -1, "" },
			{ "ItemWatch", "", 39, -1, "" }
        };
    };

	// Armurerie
	class b_7 {
        name = "Armurerie";
        license = "";
        items[] = {
			{ "ALF_Conteneur_Ent_boite", "", 30000, -1, "" },
			{ "ALF_Banane", "", 15, -1, "" },
			{ "ALF_BaconT", "", 9, -1, "" },
			{ "ALF_WaterB_P", "", 3, -1, "" },
			{ "ALF_WaterB_G", "", 6, -1, "" },
			{ "ALF_coca", "", 2, -1, "" },

			{ "optic_Aco", "", 100, -1, "" },
			{ "optic_Holosight", "", 100, -1, "" },
			
			{ "KA_crossbow_black", "", 499, -1, "" },
			{ "KA_crossbow_wood", "", 499, -1, "" },
			{ "KA_arrow_mag", "", 5, -1, "" },
			
			{ "AEK_919K", "", 4000, -1, "" },
			{ "20Rnd_9x18_Mag", "", 80, -1, "" },
			
			{ "ALF_bnae_saa_virtual", "", 4000, -1, "" },
			{ "ALF_6Rnd_357M_Magazine", "", 80, -1, "" },
			
			{ "KA_Mk23_silver", "", 4000, -1, "" },
			{ "KA_12Rnd_45ACP_FMJ_Mag", "", 80, -1, "" },
			
			{ "ALF_Desert_Eagle", "", 5000, -1, "" },
			{ "ALF_7Rnd_50_AE", "", 80, -1, "" },
			
			{ "KA_SilverBaller_L", "", 5000, -1, "" },
			{ "KA_8Rnd_45ACP_Mag", "", 80, -1, "" },
			
			//{ "ALF_W_AKS", "", 6000, -1, "" },
			//{ "ALF_30Rnd_545x39_Mag_Tracer_F", "", 80, -1, "" },
			
			{ "R3F_M4S90", "", 6000, -1, "" },
			{ "R3F_7Rnd_M4S90", "", 80, -1, "" },
			
			{ "KA_RO991", "", 6000, -1, "" },
			{ "KA_32Rnd_9x19_FMJ_Mag", "", 80, -1, "" },
			
			{ "ALF_bnae_mk1_virtual", "", 6000, -1, "" },
			{ "ALF_10Rnd_303_Magazine", "", 80, -1, "" },

			{ "KA_SG_552", "", 6000, -1, "" },
			{ "KA_SIG_30rnd_Mk318_SOST_mag", "", 80, -1, "" },

			{ "ALF_arifle_KA_SKS_F", "", 6000, -1, "" },
			{ "ALF_10Rnd_M43_762x39_Ball", "", 80, -1, "" },

			{ "ALF_bnae_spr220_virtual", "", 6000, -1, "" },
			{ "ALF_2Rnd_00_Buckshot_Magazine", "", 80, -1, "" },
			
			//{ "ALF_bnae_r1_virtual", "", 2000, -1, "" },
			//{ "ALF_bnae_r1_c_virtual", "", 2000, -1, "" },
			//{ "ALF_bnae_r1_e_virtual", "", 2000, -1, "" },
			//{ "ALF_bnae_r1_m_virtual", "", 2000, -1, "" },
			//{ "ALF_bnae_r1_t_virtual", "", 2000, -1, "" },
			//{ "ALF_8Rnd_45GAP_Magazine", "", 5, -1, "" },
			
			//{ "ALF_RH_kimber", "", 2000, -1, "" },
			//{ "ALF_RH_kimber_nw", "", 2000, -1, "" },
			//{ "ALF_RH_7Rnd_45cal_m1911", "", 5, -1, "" },
			
			//{ "ALF_RH_cz75", "", 2000, -1, "" },
			//{ "ALF_RH_16Rnd_9x19_CZ", "", 5, -1, "" },
			
			//{ "ALF_RH_vp70", "", 2000, -1, "" },
			//{ "ALF_RH_18Rnd_9x19_VP", "", 5, -1, "" },
			
			{ "ALF_KA_Glock_17_Single", "", 2000, -1, "" },
			{ "ALF_KA_17Rnd_9x19_Mag", "", 80, -1, "" },
			
			{ "ALF_bnae_m97_virtual", "", 6000, -1, "" },
			{ "ALF_2Rnd_00_Buckshot_Magazine", "", 80, -1, "" },
			
			//{ "HITMAN_47_Hidden_Vest", "", 2000, -1, "" }

			// Armes legale (a decommenter)
			// Voir prix

			// {"KA_Mk23_silver", "", 3000, -1, "" },
			// {"KA_12Rnd_45ACP_FMJ_Mag", "", 100, -1, ""},

			{"KA_FNP45", "", 7000, -1, "" },
			{"KA_15Rnd_45ACP_Mag", "", 100, -1, ""},

			// {"KA_SilverBaller", "", 2500, -1, "" },
			// {"KA_8Rnd_45ACP_Mag", "", 100, -1, ""},

			{"MRP_1911", "", 7000, -1, "" },
			{"MRP_1911_7Rnd_45ACP_Mag", "", 100, -1, ""},

			// {"MRP_USP45", "", 2000, -1, "" },
			// {"MRP_USP45_12Rnd_45ACP_Mag", "", 100, -1, ""},

			{"MRP_Jericho", "", 7000, -1, "" },
			{"MRP_Jericho_16Rnd_9x19_FMJ_Mag", "", 150, -1, ""}

			// {"MRP_PPKS", "", 550, -1, "" },
			// {"MRP_PPKS_7Rnd_9x17g", "", 150, -1, ""},

			// {"MRP_PPKS_White", "", 600, -1, "" },
			// {"MRP_PPKS_7Rnd_9x17g", "", 150, -1, ""}

        };
    };
    class b_8 {
        name = "Magasin 8";
        license = "";
        items[] = {
			{ "ALF_Conteneur_Ent_boite", "", 30000, -1, "" },
			{ "ALF_Info_Cam", "", 1499, -1, "" },
			{ "XZ_CamRecorder_2", "", 2500, -1, "" },
			{ "XZ_CamRecorder_Mag", "", 150, -1, "" },
			{ "Xnooz_micro2", "", 600, -1, "" },
			{ "ALF_Roue", "", 45, -1, "" },
			{ "ALF_Boiteaoutils", "", 35, -1, "" },
			{ "ALF_KitMecatechnic", "", 25, -1, "" },
			{ "ALF_Banane", "", 15, -1, "" },
			{ "ALF_BaconT", "", 9, -1, "" },
			{ "ALF_WaterB_P", "", 3, -1, "" },
			{ "ALF_WaterB_G", "", 6, -1, "" },
			{ "ALF_coca", "", 2, -1, "" },
			{ "ItemGPS", "", 35, -1, "" },
			{ "ItemMap", "", 50, -1, "" },
			{ "ItemCompass", "", 15, -1, "" },
			{ "ItemWatch", "", 39, -1, "" }
        };
    };
	class b_10 {
        name = "Magasin 10";
        license = "";
        items[] = {
			{ "ALF_Conteneur_Ent_boite", "", 30000, -1, "" },
			{ "ALF_Hache", "", 100, -1, "" },
			{ "MRP_Seau_Colle", "", 45, -1, "" },
			{ "ALF_Banane", "", 15, -1, "" },
			{ "ALF_BaconT", "", 9, -1, "" },
			{ "ALF_WaterB_P", "", 3, -1, "" },
			{ "ALF_WaterB_G", "", 6, -1, "" },
			{ "ALF_coca", "", 2, -1, "" },
			{ "ItemGPS", "", 35, -1, "" },
			{ "ItemMap", "", 50, -1, "" },
			{ "ItemCompass", "", 15, -1, "" },
			{ "ItemWatch", "", 39, -1, "" }
        };
    };

	class b_12 {
        name = "Magasin 12";
        license = "";
        items[] = {
			{ "ALF_Conteneur_Ent_boite", "", 30000, -1, "" },
			{ "ALF_Hache", "", 100, -1, "" },
			{ "ALF_Banane", "", 15, -1, "" },
			{ "ALF_BaconT", "", 9, -1, "" },
			{ "ALF_WaterB_P", "", 3, -1, "" },
			{ "ALF_WaterB_G", "", 6, -1, "" },
			{ "ALF_coca", "", 2, -1, "" },
			{ "ItemGPS", "", 35, -1, "" },
			{ "ItemMap", "", 50, -1, "" },
			{ "ItemCompass", "", 15, -1, "" },
			{ "ALF_Barile_P_E", "", 15, -1, "" },
			{ "ItemWatch", "", 39, -1, "" }
        };
    };

    class b_lux {
        name = "Magasin Boite";
        license = "";
        items[] = {
			{ "ALF_Conteneur_Ent_boite", "", 30000, -1, "" },
			{ "ALF_Roue", "", 45, -1, "" },
			{ "ALF_Boiteaoutils", "", 35, -1, "" },
			{ "ALF_KitMecatechnic", "", 25, -1, "" },
			{ "ALF_Banane", "", 15, -1, "" },
			{ "ALF_BaconT", "", 9, -1, "" },
			{ "ALF_WaterB_P", "", 3, -1, "" },
			{ "ALF_WaterB_G", "", 6, -1, "" },
			{ "ALF_coca", "", 2, -1, "" },
			{ "ItemGPS", "", 35, -1, "" },
			{ "ItemMap", "", 50, -1, "" },
			{ "ItemCompass", "", 15, -1, "" },
			{ "ItemWatch", "", 39, -1, "" },
			{ "ALF_Jus", "", 2, -1, "" },
			{ "ALF_51", "", 35, -1, "" },
			{ "ALF_Horse", "", 45, -1, "" },
			{ "ALF_Jager", "", 55, -1, "" },
			{ "ALF_Luxe1", "", 14500, -1, "" },
			{ "ALF_Luxe2", "", 84500, -1, "" },
			{ "ALF_Malibu", "", 75, -1, "" },
			{ "ALF_Jock", "", 850, -1, "" },
			{ "ALF_Rome", "", 450, -1, "" },
			{ "ALF_Vazisi", "", 7500, -1, "" },
			{ "ALF_Vodka", "", 95, -1, "" }
        };
    };
	class b_18 {
        name = "Magasin DIR";
        license = "";
        items[] = {
			{ "ALF_Conteneur_Ent_boite", "", 30000, -1, "" },
			{ "ALF_Utility_Box_8_boite", "", 499, -1, "" },
        	{ "ALF_Utility_Box_3_boite", "", 1499, -1, "" },
			{ "mrp_rubalise", "", 20, -1, "" },
			{ "toolkit", "", 50, -1, "" },
			{ "O2_Signal_Item_Trav", "", 35, -1, "" },
			{ "O2_Signal_Item_Trav_dang", "", 35, -1, "" },
			{ "O2_Signal_Item_Trav_dang_gliss", "", 35, -1, "" },
			{ "O2_Signal_Item_Trav_dang_retre", "", 35, -1, "" },
			{ "O2_Signal_Item_Trav_dang_accid", "", 35, -1, "" },
			{ "O2_Signal_Item_Trav_dang_grav", "", 35, -1, "" },
			{ "O2_Signal_Item_Trav_Dev_Dr", "", 35, -1, "" },
			{ "O2_Signal_Item_Trav_Dev_Ga", "", 35, -1, "" },
			{ "O2_Signal_Item_Trav_Dev_Dr_Pl", "", 35, -1, "" },
			{ "O2_Signal_Item_Trav_Dev_Ga_Pl", "", 35, -1, "" },
			{ "O2_Signal_Item_Trav_Ron", "", 35, -1, "" },
			{ "O2_Signal_Item_Trav_30", "", 35, -1, "" },
			{ "O2_Signal_Item_Trav_70", "", 35, -1, "" },
			{ "O2_Signal_Item_Trav_110", "", 35, -1, "" },
			{ "O2_Signal_Item_Trav_Limit_Fin", "", 35, -1, "" },
			{ "O2_Signal_Item_Trav_Int_Sta", "", 35, -1, "" },
			{ "O2_Signal_Item_Trav_Int_Arr", "", 35, -1, "" },
			{ "O2_Signal_Item_Trav_Int_Depass", "", 35, -1, "" },
			{ "O2_Signal_Item_Trav_Int_Depass_Fin", "", 35, -1, "" },
			{ "O2_Signal_Item_Trav_Obl_Dr", "", 35, -1, "" },
			{ "O2_Signal_Item_Trav_Obl_Ga", "", 35, -1, "" },
			{ "O2_Signal_Item_Trav_Flech_Dr", "", 35, -1, "" },
			{ "O2_Signal_Item_Trav_Flech_Ga", "", 35, -1, "" },
			{ "O2_Signal_Item_Trav_Rect", "", 35, -1, "" },
			{ "O2_Signal_Item_Trav_Bar_50", "", 35, -1, "" },
			{ "O2_Signal_Item_Trav_Bar_100", "", 35, -1, "" },
			{ "O2_Signal_Item_Trav_Balise_K5", "", 110, -1, "" },
			{ "O2_Signal_Item_Trav_Bloc_Rg", "", 190, -1, "" },
			{ "O2_Signal_Item_Trav_Bloc_Bl", "", 190, -1, "" },
			{ "O2_Signal_Item_Cone", "", 35, -1, "" },
			{ "O2_Signal_Item_Cone_DIR", "", 45, -1, "" },
			{ "O2_Signal_Item_Cone_Flash", "", 95, -1, "" },
			{ "O2_Signal_Item_Triflash", "", 130, -1, "" },
			{ "O2_Signal_Item_Triflash_Dang", "", 130, -1, "" },
			{ "O2_Signal_Item_Triflash_Accid", "", 130, -1, "" },
			{ "ALF_Triangle_Item", "", 35, -1, "" },
			{ "ALF_Barricades_Item", "", 50, -1, "" },
			{ "ALF_laptop_dir", "", 15, -1, ""}, 
			{ "BOXED_land_MRP_Petit_Generateur", "", 500, -1, ""},
			{ "BOXED_land_MRP_Grand_Generateur", "", 1500, -1, ""},
			{ "ALF_Roue", "", 45, -1, "" },
			{ "ALF_Boiteaoutils", "", 35, -1, "" },
			{ "ALF_Peinture_Black", "", 65, -1, "" },
			{ "ALF_Hache", "", 100, -1, "" },
			{ "ALF_Banane", "", 15, -1, "" },
			{ "ALF_BaconT", "", 9, -1, "" },
			{ "ALF_WaterB_P", "", 3, -1, "" },
			{ "ALF_WaterB_G", "", 6, -1, "" },
			{ "ALF_coca", "", 2, -1, "" },
			{ "ItemGPS", "", 35, -1, "" },
			{ "ItemMap", "", 50, -1, "" },
			{ "ItemCompass", "", 15, -1, "" },
			{ "ItemWatch", "", 39, -1, "" }
			
        };
    };
    class b_19 {
        name = "Magasin 19";
        license = "";
        items[] = {
			{ "ALF_Conteneur_Ent_boite", "", 30000, -1, "" },
        	{ "ALF_Utility_Box_8_boite", "", 499, -1, "" },
        	{ "ALF_Utility_Box_3_boite", "", 1499, -1, "" },
			{ "ALF_Roue", "", 45, -1, "" },
			{ "ALF_Boiteaoutils", "", 35, -1, "" },
			{ "ALF_KitMecatechnic", "", 25, -1, "" },
			{ "ALF_Banane", "", 15, -1, "" },
			{ "ALF_BaconT", "", 9, -1, "" },
			{ "ALF_WaterB_P", "", 3, -1, "" },
			{ "ALF_WaterB_G", "", 6, -1, "" },
			{ "ALF_coca", "", 2, -1, "" },
			{ "ItemGPS", "", 35, -1, "" },
			{ "ItemMap", "", 50, -1, "" },
			{ "ItemCompass", "", 15, -1, "" },
			{ "ItemWatch", "", 39, -1, "" }
        };
    };
    class b_20 {
        name = "Magasin Boite de nuit";
        license = "";
        items[] = {
			{ "ALF_Kebab", "", 7, -1, "" },
			{ "ALF_snickers", "", 3, -1, "" },
			{ "ALF_BakedBeans", "", 6, -1, "" },
			{ "ALF_BaconT", "", 9, -1, "" },
			{ "ALF_WaterB_P", "", 3, -1, "" },
			{ "ALF_WaterB_G", "", 6, -1, "" },
			{ "ALF_coca", "", 2, -1, "" },
			{ "ALF_Jus", "", 2, -1, "" },
			{ "ALF_1664", "", 8, -1, "" },
			{ "ALF_Vodka", "", 15, -1, "" },
			{ "ALF_Rome", "", 25, -1, "" },
			{ "ALF_Malibu", "", 25, -1, "" },
			{ "ALF_Luxe2", "", 25, -1, "" },
			{ "ALF_Luxe1", "", 25, -1, "" },
			{ "ALF_Jock", "", 25, -1, "" },
			{ "ALF_Jager", "", 25, -1, "" },
			{ "ALF_Horse", "", 25, -1, "" },
			{ "ALF_51", "", 25, -1, "" },
			{ "ALF_Sky", "", 25, -1, "" },
			{ "ALF_Vazisi", "", 25, -1, "" },
			{ "ALF_Smirnoff", "", 25, -1, "" }
        };
    };
	class b_21 {
        name = "Magasin Tabac";
        license = "";
        items[] = {
			{ "ALF_Conteneur_Ent_boite", "", 30000, -1, "" },
			{ "ALF_Graine_T", "", 3, -1, "" },
			{ "ALF_Roue", "", 45, -1, "" },
			{ "ALF_Boiteaoutils", "", 35, -1, "" },
			{ "ALF_Banane", "", 15, -1, "" },
			{ "ALF_BaconT", "", 9, -1, "" },
			{ "ALF_WaterB_P", "", 3, -1, "" },
			{ "ALF_WaterB_G", "", 6, -1, "" },
			{ "ALF_coca", "", 2, -1, "" },
			{ "ItemGPS", "", 35, -1, "" },
			{ "ItemMap", "", 50, -1, "" },
			{ "ItemCompass", "", 15, -1, "" },
			{ "ItemWatch", "", 39, -1, "" }
        };
    };
	class b_22 {
        name = "Magasin Petit Palais";
        license = "";
        items[] = {
			{ "ALF_Conteneur_Ent_boite", "", 30000, -1, "" },
			{ "ALF_Roue", "", 45, -1, "" },
			{ "ALF_Boiteaoutils", "", 35, -1, "" },
			{ "ALF_KitMecatechnic", "", 25, -1, "" },
			{ "ALF_Banane", "", 15, -1, "" },
			{ "ALF_BaconT", "", 9, -1, "" },
			{ "ALF_WaterB_P", "", 3, -1, "" },
			{ "ALF_WaterB_G", "", 6, -1, "" },
			{ "ALF_coca", "", 2, -1, "" },
			{ "ItemGPS", "", 35, -1, "" },
			{ "ItemMap", "", 50, -1, "" },
			{ "ItemCompass", "", 15, -1, "" },
			{ "ItemWatch", "", 39, -1, "" }
        };
    };

	class b_24 {
        name = "Magasin";
        license = "";
        items[] = {
			{ "ALF_Conteneur_Ent_boite", "", 30000, -1, "" },
			{ "ALF_Roue", "", 45, -1, "" },
			{ "ALF_Boiteaoutils", "", 35, -1, "" },
			{ "ALF_KitMecatechnic", "", 25, -1, "" },
			{ "ALF_Banane", "", 15, -1, "" },
			{ "ALF_BaconT", "", 9, -1, "" },
			{ "ALF_WaterB_P", "", 3, -1, "" },
			{ "ALF_WaterB_G", "", 6, -1, "" },
			{ "ALF_coca", "", 2, -1, "" },
			{ "ItemGPS", "", 35, -1, "" },
			{ "ItemMap", "", 50, -1, "" },
			{ "ItemCompass", "", 15, -1, "" },
			{ "ItemWatch", "", 39, -1, "" }
        };
    };

	class b_25 {
        name = "Magasin Patisserie";
        license = "";
        items[] = {
			{ "ALF_Conteneur_Ent_boite", "", 30000, -1, "" },
			{ "ALF_Roue", "", 45, -1, "" },
			{ "ALF_Boiteaoutils", "", 35, -1, "" },
			{ "ALF_KitMecatechnic", "", 25, -1, "" },
			{ "ALF_Banane", "", 15, -1, "" },
			{ "ALF_BaconT", "", 9, -1, "" },
			{ "ALF_WaterB_P", "", 3, -1, "" },
			{ "ALF_WaterB_G", "", 6, -1, "" },
			{ "ALF_coca", "", 2, -1, "" },
			{ "ItemGPS", "", 35, -1, "" },
			{ "ItemMap", "", 50, -1, "" },
			{ "ItemCompass", "", 15, -1, "" },
			{ "carton_plat", "", 20, -1, "" },
			{ "ItemWatch", "", 39, -1, "" }
        };
    };
	class b_26 {
        name = "Magasin Rhum";
        license = "";
        items[] = {
			{ "ALF_Conteneur_Ent_boite", "", 30000, -1, "" },
			{ "ALF_Roue", "", 45, -1, "" },
			{ "ALF_Boiteaoutils", "", 35, -1, "" },
			{ "ALF_KitMecatechnic", "", 25, -1, "" },
			{ "ALF_Banane", "", 15, -1, "" },
			{ "ALF_BaconT", "", 9, -1, "" },
			{ "ALF_WaterB_P", "", 3, -1, "" },
			{ "ALF_WaterB_G", "", 6, -1, "" },
			{ "ALF_coca", "", 2, -1, "" },
			{ "ItemGPS", "", 35, -1, "" },
			{ "ItemMap", "", 50, -1, "" },
			{ "ItemCompass", "", 15, -1, "" },
			{ "ItemWatch", "", 39, -1, "" },
			{ "Graine_canne_sucre", "", 2, -1, "" },
			{ "bouteille_vide", "", 15, -1, "" },
			{ "Bidon_Vide", "", 2, -1, "" },
			{ "carton_plat", "", 20, -1, "" }
        };
    };
	class b_32 {
        name = "Magasin CafÃ©";
        license = "";
        items[] = {			
			{ "ALF_Conteneur_Ent_boite", "", 30000, -1, "" },
			{ "ALF_Roue", "", 45, -1, "" },
			{ "ALF_Boiteaoutils", "", 35, -1, "" },
			{ "ALF_KitMecatechnic", "", 25, -1, "" },
			{ "ALF_Banane", "", 15, -1, "" },
			{ "ALF_BaconT", "", 9, -1, "" },
			{ "ALF_WaterB_P", "", 3, -1, "" },
			{ "ALF_WaterB_G", "", 6, -1, "" },
			{ "ALF_coca", "", 2, -1, "" },
			{ "ItemGPS", "", 35, -1, "" },
			{ "ItemMap", "", 50, -1, "" },
			{ "ItemCompass", "", 15, -1, "" },
			{ "ItemWatch", "", 39, -1, "" },
			{ "ALF_Expresso", "", 0, -1, "" },
			{ "ALF_Macchiato", "", 0, -1, "" }	
        };
    };

	class b_35 {
        name = "Magasin Maison Medical";
        license = "";
        items[] = {			
			{ "ALF_Conteneur_Ent_boite", "", 30000, -1, "" },
			{ "ALF_Roue", "", 45, -1, "" },
			{ "ALF_Boiteaoutils", "", 35, -1, "" },
			{ "ALF_KitMecatechnic", "", 25, -1, "" },
			{ "ALF_Banane", "", 15, -1, "" },
			{ "ALF_BaconT", "", 9, -1, "" },
			{ "ALF_WaterB_P", "", 3, -1, "" },
			{ "ALF_WaterB_G", "", 6, -1, "" },
			{ "ALF_coca", "", 2, -1, "" },
			{ "ItemGPS", "", 35, -1, "" },
			{ "ItemMap", "", 50, -1, "" },
			{ "ItemCompass", "", 15, -1, "" },
			{ "ItemWatch", "", 39, -1, "" },
			{ "ALF_Expresso", "", 0, -1, "" },
			{ "ALF_Macchiato", "", 0, -1, "" },	
			{ "ALF_Sthetoscope", "", 0, -1, "" },
			{ "ALF_Bandage", "", 3, -1, "" },
			{ "ALF_Adrenaline", "", 7, -1, "" },
			{ "ALF_Atropine", "", 8, -1, "" },
			{ "ALF_Morphine", "", 9, -1, "" },
			{ "ALF_Saline", "", 14, -1, "" },
			{ "ALF_Medoc_rhume", "", 18, -1, "" },
			{ "ALF_Medoc_toux", "", 25, -1, "" },
			{ "ALF_Guardian", "", 349, -1, "" },
			{ "ALF_M_Oxy9L", "", 45, -1, "" },
			{ "ALF_Defibrilateur", "", 15, -1, "" }	
        };
    };
	
	/////////////////////////////////////////////////////
    class bijoutier {
        name = "Bijouterie";
        license = "";
        items[] = {
			{ "ALF_Bague_Homme", "", 538, -1, "" },
			// { "V12_MILES", "", 2500, -1, "" },
			// { "V12_BREITLING2", "", 1500, -1, "" },
			// { "V12_APPLES8B", "", 750, -1, "" },
			{ "ALF_Bague_Femme", "", 542, -1, "meuf" }
        };
    };
	
	class bie {
        name = "Magasin Enedis";
        license = "";
        items[] = {
			{ "BOXED_land_MRP_Petit_Generateur", "", 500, -1, ""},
			{ "BOXED_land_MRP_Grand_Generateur", "", 1500, -1, ""},
			{ "toolkit", "", 50, -1, "" }
        };
    };
	/////////////////////////////////////////////////////
    class bankstore {
        name = "CrÃ©dit Mutuel";
        license = "";
        items[] = {
			{ "ALF_CB_Bronze", "", 15, -1, "" },
			{ "ALF_CB_Gold", "", 99, -1, "" },
			{ "ALF_CB_Black", "", 199, -1, "" }
        };
    };

    class orange {
        name = "Orange";
        license = "";
        items[] = {
			{ "ALF_3310", "", 149, -1, "" },
			{ "ALF_iPhone", "", 699, -1, "" }
        };
    };

    /////////////////////////////////////////////////////

    class ikea {
        name = "IKEA";
        license = "home";
        items[] = {
        	//{ "ALF_Barrel_boite", "", 499, -1, "" },
			{ "ALF_TV_2_boite", "", 1499, -1, "" },
			{ "ALF_TV_1_boite", "", 1599, -1, "" },
			{ "ALF_Table_B_2_boite", "", 89, -1, "" },
			{ "ALF_Table_B_1_boite", "", 99, -1, "" },
			{ "ALF_Table_2_boite", "", 549, -1, "" },
			{ "ALF_Table_1_boite", "", 749, -1, "" },
			{ "ALF_stock_2_boite", "", 975, -1, "" },
			{ "ALF_stock_1_boite", "", 1199, -1, "" },
			{ "ALF_lit_2_Ver_boite", "", 2499, -1, "" },
			{ "ALF_lit_2_Ble_boite", "", 2499, -1, "" },
			{ "ALF_lit_2_Bla_boite", "", 2499, -1, "" },
			{ "ALF_lit_2_R_boite", "", 2499, -1, "" },
			{ "ALF_lit_2_N_boite", "", 2499, -1, "" },
			{ "ALF_lit_1_Ver_boite", "", 2299, -1, "" },
			{ "ALF_lit_1_Ble_boite", "", 2299, -1, "" },
			{ "ALF_lit_1_Bla_boite", "", 2299, -1, "" },
			{ "ALF_lit_1_R_boite", "", 2299, -1, "" },
			{ "ALF_lit_1_N_boite", "", 2299, -1, "" },
			{ "ALF_chaise_2_ver_boite", "", 99, -1, "" },
			{ "ALF_chaise_2_Ble_boite", "", 99, -1, "" },
			{ "ALF_chaise_2_Bla_boite", "", 99, -1, "" },
			{ "ALF_chaise_2_N_boite", "", 99, -1, "" },
			{ "ALF_chaise_2_R_boite", "", 99, -1, "" },
			{ "ALF_chaise_1_ver_boite", "", 119, -1, "" },
			{ "ALF_chaise_1_Ble_boite", "", 119, -1, "" },
			{ "ALF_chaise_1_Bla_boite", "", 119, -1, "" },
			{ "ALF_chaise_1_N_boite", "", 119, -1, "" },
			{ "ALF_chaise_1_R_boite", "", 119, -1, "" },
			{ "ALF_canap_2_boite", "", 3499, -1, "" },
			{ "ALF_canap_ver_boite", "", 3599, -1, "" },
			{ "ALF_canap_Ble_boite", "", 3599, -1, "" },
			{ "ALF_canap_Bla_boite", "", 3599, -1, "" },
			{ "ALF_canap_N_boite", "", 4515, -1, "" },
			{ "ALF_canap_R_boite", "", 4515, -1, "" },
			{ "ALF_Frigo_boite", "", 1499, -1, "" },
			{ "ALF_Frigo_basique_boite", "", 1499, -1, "" },
			{ "ALF_Gros_Frigo_boite", "", 3568, -1, "" },
			{ "ALF_Camping_Chair_Item", "", 45, -1, "" },
			{ "ALF_bbq_M", "", 600, -1, "" },
			{ "ALF_Tente_1_Item", "", 75, -1, "" },
			{ "ALF_Batterie_boite", "", 1850, -1, "" },
			{ "ALF_Sonnette4G", "", 349, -1, "" },
			{ "ALF_ZipTies", "", 3000, -1, "" },
			{ "ALF_Lockpick", "", 5000, -1, "" },
			{ "ALF_Safe_1_boite", "", 18500, -1, "" }
        };
    };

    /////////////////////////////////////////////////////
    class mais {
        name = "Vendeur de graines";
        license = "";
        items[] = {
			{ "ALF_Graine_M", "", 2, -1, "" },
			{ "Graine_canne_sucre", "", 2, -1, "" },
			{ "ALF_Graine_T", "", 2, -1, "" }
        };
    };
	
	/////////////////////////////////////////////////////
	
    class Pharmacie {
        name = "Pharmacie";
        license = "";
        items[] = {
			{ "ALF_Medoc_rhume", "", 18, -1, "" },
			{ "ALF_Medoc_toux", "", 25, -1, "" }
        };
    };
	
	/////////////////////////////////////////////////////
    class farce {
        name = "Farce et Attrape";
        license = "";
        items[] = {
			{ "ALF_Peinture_Black", "", 65, -1, "" },
			{ "ALF_Peinture_Green", "", 65, -1, "" },
			{ "ALF_Pancarte_Dormir", "", 250, -1, "" },
			{ "ALF_Pancarte_Amour", "", 250, -1, "" },
			{ "ALF_Pancarte_Manje", "", 250, -1, "" },
			{ "ALF_Pancarte_Incompetants", "", 250, -1, "" },
			{ "ALF_Pancarte_NikLaGN", "", 250, -1, "" },
			{ "ALF_Pancarte_Banque", "", 250, -1, "" },
			{ "ALF_Pancarte_Climat", "", 250, -1, "" },
			{ "ALF_Pancarte_Corruption", "", 250, -1, "" },
			{ "ALF_Pancarte_Impots", "", 250, -1, "" },
			{ "ALF_Pancarte_Vener", "", 250, -1, "" },
			{ "GrenadePetard", "", 1000, -1, "" }
        };
    };

    /////////////////////////////////////////////////////
	class cop {
		name = "Gendarmerie";
		license = "cop";
		items[] = {
			{ "ALF_laptop_unfolded_f", "", 349, -1, "TIC" },
			{ "Malette_TIC", "", 349, -1, "TIC" },
			{ "ALF_Charge_C2_M", "", 499, -1, "PSIG_Sabre" },
			{ "ALF_Perceuse_GDM_M", "", 549, -1, "PSIG_Sabre" },
			{ "MRP_Rubalise_gn", "", 10, -1, "" },
			{ "mrp_rubalise", "", 10, -1, "" },
			{ "alf_neogend", "", 499, -1, "" },
			{ "ALF_Menottes", "", 9, -1, "" },
			{ "ALF_cle_M", "", 4, -1, "" },
			{ "ALF_TestStup", "", 25, -1, "" },
			{ "ALF_Alcootest", "", 68, -1, "" },
			{ "ALF_sifflet", "", 4, -1, "" },
			{ "ALF_Peinture_Blue", "", 65, -1, "" },
			{ "O2_Item_Stop_Stick_x2", "", 35, -1, "" },
			{ "ALF_Radar_m_i", "", 135, -1, "" },
			{ "O2_Signal_Item_Halt_Gn", "", 15, -1, "" },
			{ "O2_Signal_Item_Trav_Dev_Dr", "", 15, -1, "" },
			{ "O2_Signal_Item_Trav_Dev_Ga", "", 15, -1, "" },
			{ "ALF_Bracelet", "", 489, -1, "" },
			{ "ALF_Camera", "", 49, -1, "" },
			{ "ALF_Rangefinder", "", 49, -1, "" },
			{ "ALF_Banane", "", 15, -1, "" },
			{ "ALF_BaconT", "", 9, -1, "" },
			{ "ALF_WaterB_P", "", 3, -1, "" },
			{ "ALF_WaterB_G", "", 6, -1, "" },
			{ "ALF_Flash_Light", "", 15, -1, "" },
			{ "O2_Signal_Item_Triflash_Dang", "", 130, -1, "" },
			{ "ALF_Triangle_Item", "", 35, -1, "" },
			{ "O2_Signal_Item_Cone", "", 35, -1, "" },
			{ "ALF_Roue", "", 45, -1, "" },
			{ "ALF_Boiteaoutils", "", 35, -1, "" },
			{ "ALF_KitMecatechnic", "", 25, -1, "" },
			{ "ALF_EarPiece", "", 49, -1, "" },
			{ "Binocular", "", 49, -1, "" },
			{ "ItemGPS", "", 35, -1, "" },
			{ "ItemMap", "", 50, -1, "" },
			{ "ItemCompass", "", 15, -1, "" },
			{ "MRP_Ancre", "", 100, -1, "" },
			{ "ItemWatch", "", 39, -1, "" },
			{ "recharge", "", 39, -1, "" },
			{ "MRP_Cible_precision", "", 1, -1, "PSIG" },
			{ "MRP_Cible_precision2", "", 1, -1, "PSIG" },
			{ "MRP_Cible", "", 1, -1, "PSIG" },
			{ "KA_M7290", "", 1, -1, "PSIG" },
			{ "GrenadePLMP7C", "", 1, -1, "PSIG" },
			{ "KA_M84", "", 1, -1, "PSIG" },
			{ "GrenadePLMP7B", "", 1, -1, "PSIG" },
			{ "KA_MCU", "", 1, -1, "PSIG" },
			{ "ALF_Brassard_GND", "", 80, -1, "" }
		};
	};
	class cop_SR {
		name = "Gendarmerie";
		license = "SR";
		items[] = {
			{ "ALF_laptop_unfolded_f", "", 349, -1, "SR" },
			{ "ALF_Tracker_i", "", 249, -1, "SR" },
			{ "alf_neogend", "", 100, -1, "" },
			{ "ALF_Menottes", "", 9, -1, "" },
			{ "ALF_cle_M", "", 4, -1, "" },
			{ "ALF_TestStup", "", 25, -1, "" },
			{ "ALF_Alcootest", "", 68, -1, "" },
			{ "ALF_Bracelet", "", 489, -1, "" },
			{ "ALF_Camera", "", 49, -1, "" },
			{ "ALF_Rangefinder", "", 49, -1, "" },
			{ "ALF_Banane", "", 15, -1, "" },
			{ "ALF_WaterB_P", "", 3, -1, "" },
			{ "ALF_WaterB_G", "", 6, -1, "" },
			{ "ALF_EarPiece", "", 49, -1, "" },
			{ "Binocular", "", 49, -1, "" },
			{ "ItemGPS", "", 35, -1, "" },
			{ "ItemMap", "", 50, -1, "" },
			{ "ItemCompass", "", 15, -1, "" },
			{ "ItemWatch", "", 39, -1, "" }
		};
	};
	class copw_SR {
		name = "Armurerie SR";
		license = "SR";
		items[] = {

			{ "ALF_Brassard_GND", "", 80, -1, "" }
		};
	};
	class copw {
		name = "Armurerie";
		license = "cop";
		items[] = {

			{ "NVGoggles_OPFOR", "", 80, -1, "" },

			{ "MRP_X26", "", 1500, -1, "" },
			{ "MRP_Taser_Mag", "", 150, -1, "" },
			{ "MRP_Taser_laser", "", 500, -1, "" },

			{ "MRP_P2022", "", 2000, -1, "" },
			{ "MRP_P2022_15Rnd_9x19_FMJ_Mag", "", 150, -1, "" },

			{ "MRP_SurefireX300U", "", 5, -1, "" },
						
			{ "KA_UMP9", "", 5000, -1, "" },
			{ "KA_30Rnd_9x19_FMJ_Mag", "", 150, -1, "" },
			{ "KA_UMP45_Flashlight_single", "", 5, -1, "" },			

			{ "hlc_rifle_G36C", "", 7500, -1, "" },
			{ "hlc_30rnd_556x45_EPR_G36", "", 150, -1, "" },

			{ "acc_flashlight", "", 5, -1, "" },
			{ "optic_Holosight_blk_F", "", 60, -1, "" },
			{ "optic_Holosight_smg_blk_F", "", 60, -1, "" },
			{ "optic_aco", "", 60, -1, "" },

			{ "MRP_LBD40", "", 1500, -1, "" },
			{ "LBD_40mm_lacrymo", "", 250, -1, "" },
			{ "LBD_40mm_Balle", "", 250, -1, "" },			
			{ "MRP_Gazeuse", "", 1500, -1, "" },										

			{ "ALF_Brassard_GND", "", 1000, -1, "" },
			{ "Tonfa_swing", "", 500, -1, "" },
			{ "MRP_Bouclier_side", "", 500, -1, "" },
			{ "MRP_Bouclier2", "", 500, -1, "" },

			//PSIG
			{ "MRP_P2022_bouclier", "", 100, -1, "PSIG_Sabre" },
			{ "R3F_HK416M_HG", "", 100, -1, "PSIG_Sabre" },
			{ "acc_pointer_IR", "", 100, -1, "PSIG_Sabre" },
			{ "R3F_BIPIED_HK417", "", 100, -1, "PSIG_Sabre" },
			{ "R3F_30Rnd_556x45_HK416", "", 100, -1, "PSIG_Sabre" },
			{ "MRP_SP2022_Shield", "", 5, -1, "PSIG_Sabre" },
			{ "KA_FNP45_Shield", "", 5, -1, "PSIG_Sabre" },
			{ "MRP_P2022_15Rnd_9x19_FMJ_Mag", "", 100, -1, "PSIG_Sabre" },
			{ "KA_Glock_17", "", 100, -1, "PSIG_Sabre" },
			{ "KA_17Rnd_9x19_Mag", "", 5, -1, "PSIG_Sabre" },
			{ "HLC_optic_DocterR", "", 5, -1, "PSIG_Sabre" },
			{ "Rail_Public_Flashlight", "", 5, -1, "PSIG_Sabre" },
			{ "optic_Yorris", "", 5, -1, "PSIG_Sabre" },
			{ "hlc_smg_mp5a4", "", 5, -1, "PSIG_Sabre" },
			{ "CompAimpoint", "", 5, -1, "PSIG_Sabre" },
			{ "hlc_30Rnd_9x19_B_MP5", "", 5, -1, "PSIG_Sabre" },
			{ "optic_Holosight_blk_F", "", 5, -1, "PSIG_Sabre" },
			{ "hlc_rifle_G36KV_grip", "", 5, -1, "PSIG_Sabre" },
			{ "hlc_muzzle_KX3_comp", "", 5, -1, "PSIG_Sabre" },
			{ "hlc_30rnd_556x45_EPR_G36", "", 5, -1, "PSIG_Sabre" },


			{ "hlc_grip_PMVFG_Black", "", 5, -1, "PSIG_Sabre" },			
			{ "NVG_Tdc_gd", "", 5, -1, "PSIG_Sabre" },

			{ "ALF_KA_M1014", "", 150, -1, "PSIG_Sabre" },
            { "ALF_6Rnd_M1014_buck", "", 7, -1, "PSIG_Sabre" },
            { "ALF_6Rnd_M1014_PPA", "", 7, -1, "PSIG_Sabre" },
            { "ALF_6Rnd_M1014_slug", "", 7, -1, "PSIG_Sabre" }
		};
	};
	class cop_bank {
		name = "Carte acces banque";
		license = "cop";
		items[] = {
			{ "ALF_Badge_B", "", 500, -1, "" }
		};
	};

	//////////////////////////POLICE MUNICIPALE///////////////////////////
	class pmgeneral {
		name = "Police Municipale";
		license = "";
		items[] = {			
			{ "alf_sonypm", "", 699, -1, "" },
			{ "MRP_Rubalise_pm", "", 10, -1, "" },
			{ "ALF_Banane", "", 15, -1, "" },
			{ "ALF_BaconT", "", 9, -1, "" },
			{ "ALF_WaterB_P", "", 3, -1, "" },
			{ "ALF_WaterB_G", "", 6, -1, "" },
			{ "ALF_Menottes", "", 9, -1, "" },
			{ "ALF_cle_M", "", 4, -1, "" },
			{ "O2_Item_Stop_Stick_x2", "", 35, -1, "" },
			{ "ALF_Rangefinder", "", 49, -1, "" },
			{ "ALF_TestStup", "", 25, -1, "" },
			{ "ALF_Alcootest", "", 68, -1, "" },
			{ "ALF_Roue", "", 55, -1, "" },
			{ "ALF_Boiteaoutils", "", 75, -1, "" },
			{ "ALF_KitMecatechnic", "", 35, -1, "" },
			{ "ALF_Camera", "", 230, -1, "" },
			{ "ALF_GoPro", "", 349, -1, "" },
			{ "ALF_Triangle_Item", "", 15, -1, "" },
			{ "ALF_Flash_Light", "", 90, -1, "" },
			{ "murshun_cigs_lighter", "", 130, -1, "" },
			// { "ALF_GPS", "", 453, -1, "" },
			{ "Binocular", "", 49, -1, "" },
			{ "ALF_Bracelet", "", 489, -1, "" },
			{ "ItemGPS", "", 35, -1, "" },
			{ "ItemMap", "", 50, -1, "" },
			{ "ItemCompass", "", 15, -1, "" },
			{ "O2_Signal_Item_Halt_Pm", "", 15, -1, "" },
			{ "O2_Signal_Item_Trav_Dev_Dr", "", 15, -1, "" },
			{ "O2_Signal_Item_Trav_Dev_Ga", "", 15, -1, "" },
			{ "O2_Signal_Item_Triflash_Dang", "", 35, -1, "" },
			{ "ALF_Triangle_Item", "", 35, -1, "" },
			{ "O2_Signal_Item_Cone", "", 35, -1, "" },
			{ "ItemWatch", "", 39, -1, "" }
		};
	};
	
	class pmweapon {
		name = "Police Municipale";
		license = "";
		items[] = {
			{ "MRP_X26", "", 15, -1, "" },
			{ "MRP_Taser_Mag", "", 3, -1, "" },
			{ "MRP_Taser_laser", "", 500, -1, "" },
			
			{ "KA_P226_Black", "", 80, -1, "" },
			{ "KA_P226_15Rnd_9x19_FMJ_Mag", "", 5, -1, "" },

			{ "hlc_smg_mp5k_PDW", "", 80, -1, "" },
			{ "optic_Holosight_blk_F", "", 80, -1, "" },							
			{ "hlc_30Rnd_9x19_B_MP5", "", 80, -1, "" },	
	

			{ "R3F_M4S90", "", 80, -1, "" },
			{ "R3F_7Rnd_M4S90", "", 5, -1, "" },
			{ "acc_flashlight", "", 5, -1, "" }
		};
	};
	///////////////////////////MEDIC//////////////////////////
	class med {
		name = "Pompiers";
		license = "med";
		items[] = {
			{ "alf_SonyPo", "", 500, -1, "" },
			{ "MRP_Rubalise_sp", "", 50, -1, "" },
			{ "ALF_Bandage", "", 25, -1, "" },
			{ "ALF_Guardian", "", 50, -1, "" },
			{ "ALF_M_Oxy9L", "", 500, -1, "" },
			{ "ALF_Defibrilateur", "", 500, -1, "" },
			// { "ALF_Drap_Cadavre_Item", "", 0, -1, "" },
			{ "ALF_Hache", "", 200, -1, "" },
			{ "ALF_Flash_Light", "", 25, -1, "" },

			{ "ALF_Banane", "", 2, -1, "" },
			{ "ALF_snickers", "", 3, -1, "" },
			{ "ALF_BakedBeans", "", 6, -1, "" },
			{ "ALF_BaconT", "", 9, -1, "" },
			{ "ALF_WaterB_G", "", 6, -1, "" },
			{ "ALF_coca", "", 2, -1, "" },
			{ "ALF_Jus", "", 2, -1, "" },
			{ "ALF_Camera", "", 49, -1, "" },
			{ "ALF_Peinture_Red", "", 5, -1, "" },
			{ "ALF_Roue", "", 25, -1, "" },
			{ "ALF_Boiteaoutils", "", 25, -1, "" },
			{ "ALF_KitMecatechnic", "", 25, -1, "" },
			{ "ALF_Adrenaline", "", 3, -1, "SAMU" },
			{ "ALF_Atropine", "", 3, -1, "SAMU" },
			{ "ALF_Morphine", "", 3, -1, "SAMU" },
			{ "ALF_Saline", "", 5, -1, "SAMU" },
			// { "ALF_Sthetoscope", "", 0, -1, "SAMU" },
			{ "ALF_Medoc_rhume", "", 3, -1, "SAMU" },
			{ "ALF_Medoc_toux", "", 3, -1, "SAMU" },
			{ "O2_Signal_Item_Cone_Sp", "", 35, -1, "" },
			{ "O2_Signal_Item_Triflash_Accid", "", 130, -1, "" },
			{ "O2_Signal_Item_Trav_dang_accid", "", 35, -1, "" },
			{ "BOXED_land_MRP_Petit_Generateur", "", 500, -1, "" },
			{ "Binocular", "", 15, -1, "" },
			{ "MRP_Ancre", "", 10, -1, "" },
			{ "ByScream_LDV500", "", 10, -1, "" },
			{ "ByScream_LDV500_chargeur", "", 10, -1, "" },
			{ "byscream_division_simple", "", 10, -1, "" },
			{ "byscream_tuyau20_45_simple", "", 10, -1, "" },
			{ "byscream_tuyau40_45_simple", "", 10, -1, "" },
			{ "byscream_tuyau20_70_simple", "", 10, -1, "" },
			{ "byscream_tuyau40_70_simple", "", 10, -1, "" },
			{ "byscream_tuyau10_110_simple", "", 10, -1, "" },
			{ "byscream_tuyau20_110_simple", "", 10, -1, "" },
			{ "byscream_tuyau40_110_simple", "", 10, -1, "" },
			{ "Item_PortableLight_single", "", 10, -1, "" },
			{ "Item_PortableLight_double", "", 10, -1, "" },
			{ "Item_PortableGenerator_01", "", 25, -1, "" },
			{ "Item_FireExtinguisher", "", 15, -1, "" },
			{ "Item_GasTank_01_blue", "", 20, -1, "" },
			{ "Item_GasTank_01_yellow", "", 20, -1, "" },
			{ "Item_Bodybag_01_white", "", 30, -1, "" },
			{ "Item_FirstAidKit_01_open", "", 40, -1, "" },
		};
	};

	/////////////////////////////////////////////////////
	class prison {
		name = "Magasin detenu";
		license = "";
		items[] = {
			{ "ALF_Pioche", "", 200, -1, "" },
			{ "ALF_Banane", "", 25, -1, "" },
			{ "ALF_Pomme", "", 25, -1, "" },
			{ "ALF_Peche", "", 25, -1, "" },
			{ "ALF_Pain", "", 25, -1, "" },
			{ "ALF_snickers", "", 25, -1, "" },
			{ "ALF_BakedBeans", "", 25, -1, "" },
			{ "ALF_BaconT", "", 65, -1, "" },
			{ "ALF_WaterB_G", "", 15, -1, "" },
			{ "ALF_coca", "", 25, -1, "" },
			{ "ItemGPS", "", 35, -1, "" },
			{ "ItemMap", "", 50, -1, "" },
			{ "ItemCompass", "", 15, -1, "" },
			{ "ItemWatch", "", 39, -1, "" }
        };
    };
    class prisonpro {
		name = "Magasin prison";
		license = "";
		items[] = {
			{ "ALF_iPhone", "", 699, -1, "" },
			{ "alf_sonypm", "", 150, -1, "" },
			{ "ALF_Bandage", "", 3, -1, "medWork" },
			{ "ALF_Guardian", "", 349, -1, "medWork" },
			{ "ALF_M_Oxy9L", "", 45, -1, "medWork" },
			{ "ALF_Defibrilateur", "", 15, -1, "medWork" },
			{ "MRP_X26", "", 15, -1, "" },
			{ "MRP_Taser_laser", "", 500, -1, "" },
			{ "ALF_Rangefinder", "", 49, -1, "" },
			{ "MRP_Taser_Mag", "", 3, -1, "" },
			{ "KA_P226_Black", "", 80, -1, "" },
			{ "KA_P226_15Rnd_9x19_FMJ_Mag", "", 5, -1, "" },
			{ "KA_M1014", "", 249, -1, "" },
			{ "6Rnd_M1014_buck", "", 19, -1, "" },
			{ "6Rnd_M1014_PPA", "", 19, -1, "" },

			{ "hlc_smg_mp5k_PDW", "", 80, -1, "" },
			{ "optic_Holosight_blk_F", "", 80, -1, "" },							
			{ "hlc_30Rnd_9x19_B_MP5", "", 80, -1, "" },	
			
			{ "KA_Rakurs", "", 8, -1, "" },
			{ "optic_aco", "", 8, -1, "" },
			{ "acc_flashlight", "", 8, -1, "" },
			{ "ALF_Menottes", "", 9, -1, "" },
			{ "ALF_cle_M", "", 4, -1, "" },
			{ "ALF_Bracelet", "", 489, -1, "" },
			{ "ALF_Barile_0", "", 9, -1, "" },
			{ "ALF_Roue", "", 45, -1, "" },
			{ "ALF_Boiteaoutils", "", 35, -1, "" },
			{ "ALF_KitMecatechnic", "", 25, -1, "" },
			{ "ALF_Banane", "", 15, -1, "" },
			{ "ALF_WaterB_P", "", 3, -1, "" },
			{ "ALF_Pain", "", 1, -1, "" },
			{ "ALF_Kebab", "", 7, -1, "" },
			{ "ALF_snickers", "", 3, -1, "" },
			{ "ALF_BakedBeans", "", 6, -1, "" },
			{ "ALF_BaconT", "", 9, -1, "" },
			{ "ALF_WaterB_G", "", 6, -1, "" },
			{ "ALF_coca", "", 2, -1, "" },
			{ "ItemGPS", "", 35, -1, "" },
			{ "ItemMap", "", 50, -1, "" },
			{ "ItemCompass", "", 15, -1, "" },
			{ "ItemWatch", "", 39, -1, "" }
        };
    };

    class genstore {
		name = "Magasin gÃ©nÃ©ral";
		license = "";
		items[] = {
			{ "ALF_Roue", "", 55, -1, "" },
			{ "ALF_Boiteaoutils", "", 75, -1, "" },
			{ "ALF_KitMecatechnic", "", 35, -1, "" },
			{ "ALF_Pioche", "", 150, -1, "" },
			{ "ALF_Batte", "", 250, -1, "" },
			{ "ALF_Hache", "", 200, -1, "" },
			{ "ALF_Faux", "", 250, -1, "" },
			{ "ALF_Camera", "", 230, -1, "" },
			{ "ALF_GoPro", "", 349, -1, "" },
			{ "ALF_Triangle_Item", "", 15, -1, "" },
			{ "ALF_Flash_Light", "", 90, -1, "" },
			{ "ALF_ZipCutter", "", 130, -1, "" },
			{ "murshun_cigs_lighter", "", 130, -1, "" },
			{ "ALF_CanneAPeche", "", 850, -1, "" },
			{ "ALF_appat", "", 25, -1, "" },
			// { "ALF_GPS", "", 453, -1, "" },
			{ "Binocular", "", 49, -1, "" },
			{ "ItemGPS", "", 35, -1, "" },
			{ "ItemMap", "", 50, -1, "" },
			{ "ItemCompass", "", 15, -1, "" },
			{ "ALF_bbq_M", "", 800, -1, "" },
			{ "Math_crossbow_black", "", 3000, -1, "" },
			{ "KA_arrow_mag", "", 100, -1, "" },
			{ "MRP_Ancre", "", 10000, -1, "" },
			{ "MRP_Carton_Fillet", "", 2000, -1, "" },
			{ "ItemWatch", "", 39, -1, "" },
			{ "ByScream_Extincteur", "", 500, -1, "" },
			{ "ByScream_LDV500_chargeur", "", 10, -1, "" }
        };
    };

    class barile {
        name = "Vendeur de baril";
        license = "";
        items[] = {
			{ "ALF_Barile_P_E", "", 25, -1, "" }
        };
    };
    class vdealer {
        name = "Vendeur de drogue";
        license = "";
        items[] = {
			//{ "ALF_Cocaine_U", "", 500, -1, "" }
        };
    };

    class station {
        name = "Magasin Total";
        license = "";
        items[] = {
			{ "ALF_Barile_100", "", 300, -1, "" },
			{ "ALF_Barile_0", "", 9, -1, "" },
			{ "ALF_Roue", "", 45, -1, "" },
			{ "ALF_Boiteaoutils", "", 35, -1, "" },
			{ "ALF_KitMecatechnic", "", 25, -1, "" },
			{ "ALF_Banane", "", 15, -1, "" },
			{ "ALF_WaterB_P", "", 3, -1, "" },
			{ "ALF_coca", "", 2, -1, "" },
			{ "ItemGPS", "", 35, -1, "" },
			{ "ItemMap", "", 50, -1, "" },
			{ "ItemCompass", "", 15, -1, "" },
			{ "ItemWatch", "", 39, -1, "" }
        };
    };

    class armurerie {
        name = "Armurerie";
        license = "";
        items[] = {
			//{ "KA_Px4", "", 6500, -1, "" },
			//{ "KA_Px4_Black", "", 6500, -1, "" },
			//{ "KA_Px4_17Rnd_9x19_FMJ_Mag", "", 149, -1, "" },
			{ "KA_Glock_17_Single", "", 10000, -1, "" },
			{ "KA_17Rnd_9x19_Mag", "", 170, -1, "" }
        };
    };

	class plongee {
		name = "Fourniture plongÃ©e";
		license = "";
        items[] = {
			{ "recharge", "", 4500, -1, "" }
        };
	}

    class market {
        name = "MarchÃ©";
        license = "";
        items[] = {
			{ "ALF_Banane", "", 15, -1, "" },
			{ "ALF_Pain", "", 1, -1, "" },
			{ "ALF_Kebab", "", 7, -1, "" },
			{ "ALF_snickers", "", 3, -1, "" },
			{ "ALF_BakedBeans", "", 6, -1, "" },
			{ "ALF_BaconT", "", 9, -1, "" },
			{ "ALF_WaterB_P", "", 3, -1, "" },
			{ "ALF_WaterB_G", "", 6, -1, "" },
			{ "ALF_coca", "", 2, -1, "" },
			{ "ALF_Jus", "", 2, -1, "" },
			{ "ALF_1664", "", 8, -1, "" },
			{ "ALF_Jack", "", 12, -1, "" },
			{ "ALF_Vodka", "", 15, -1, "" },
			{ "ALF_Saucisse_Crue_M", "", 10, -1, "" },
			{ "ALF_Bacon_Crue_M", "", 10, -1, "" },
			{ "ALF_CotePorc_Crue_M", "", 25, -1, "" },
			{ "ALF_Poulet_Crue_M", "", 10, -1, "" }
        };
    };

	// Prefecture
	class pref {
        name = "Prefecture";
        license = "";
        items[] = {
			{ "ALF_Banane", "", 10, -1, "" },
			{ "ALF_Pain", "", 1, -1, "" },
			{ "ALF_snickers", "", 3, -1, "" },
			{ "ALF_BakedBeans", "", 6, -1, "" },
			{ "ALF_BaconT", "", 9, -1, "" },
			{ "ALF_WaterB_P", "", 3, -1, "" },
			{ "ALF_WaterB_G", "", 6, -1, "" },
			{ "ALF_coca", "", 2, -1, "" },
			{ "ALF_Jus", "", 2, -1, "" }
        };
    };

	// Tribunal
	class tribunal {
        name = "Tribunal";
        license = "";
        items[] = {
			{ "ALF_Banane", "", 10, -1, "" },
			{ "ALF_Pain", "", 1, -1, "" },
			{ "ALF_snickers", "", 3, -1, "" },
			{ "ALF_BakedBeans", "", 6, -1, "" },
			{ "ALF_BaconT", "", 9, -1, "" },
			{ "ALF_WaterB_P", "", 3, -1, "" },
			{ "ALF_WaterB_G", "", 6, -1, "" },
			{ "ALF_coca", "", 2, -1, "" },
			{ "ALF_Jus", "", 2, -1, "" }
        };
    };

    /////////////////////////////////////////////////////

    class blackmarket {
		name = "MarchÃ© noir - Weed";
		license = "";
		items[] = {
			//{ "ALF_Lockpick", "", 5000, -1, "" },
			//{ "ALF_ZipTies", "", 3000, -1, "" },
			//{ "ALF_Perceuse_GDM_M", "", 25000, -1, "" },
			{ "ALF_Headbag", "", 1000, -1, "" },
			//{ "Table_weed_boite", "", 70000, -1, "" },
			{ "ALF_cle_1", "", 10000, -1, "" },
        	//{ "ALF_Plante_W_2_Boite", "", 20000, -1, "" },
        	//{ "ALF_C4", "", 15000, -1, "" },
        	//{ "ALF_Pc", "", 10000, -1, "" }
			{ "ALF_Cocaine_U", "", 500, -1, "" },
			{ "ALF_Graine_W", "", 10, -1, "" },
			{ "ALF_Pseudoephedrine", "", 760, -1, "" }									
		};
    };

    class blackmarket2	{
		name = "MarchÃ© noir - CocaÃ¯ne";
		license = "";
		items[] = {
			//{ "ALF_Lockpick", "", 5000, -1, "" },
			//{ "ALF_ZipTies", "", 3000, -1, "" },
			//{ "ALF_Perceuse_GDM_M", "", 25000, -1, "" },
			//{ "ALF_Headbag", "", 1000, -1, "" },
			//{ "ALF_Coco_boite", "Atelier de cocaine", 200000, -1, "" }
		};
    };
	
	class blackmarket3	{
		name = "MarchÃ© noir - Armes de Poing";
		license = "";
		items[] = {
			
        // PM (MAC-11)
        //{ "MRP_Mac11", "", 60000, -1, "" },
        //{ "MRP_32Rnd_9x17_MAC11", "", 1000, -1, "" } 
		};
    };

	class blackmarket4	{
		name = "MarchÃ© noir - Armes Lourde";
		license = "";
		items[] = {
		// Fusil d'assaut AKS
        { "arifle_AKS_F", "", 150000, -1, "" },
        { "30Rnd_545x39_Mag_F", "", 10000, -1, "" },

		// AK47 5.56
		{ "MRP_AKM_F", "", 200000, -1, "" },

        { "545x39_30rnds_AKM", "", 10000, -1, "" },
		{ "MRP_optic_kobra", "", 50000, -1, "" },

        // Vityaz 
        { "KA_Vityaz", "", 150000, -1, "" },
        { "KA_30Rnd_9x19_7N31_AP_Mag", "", 10000, -1, "" }

        
        // Shotgun 
        //{ "KICKASS_Sawed_Off_Shotgun", "", 95000, -1, "" },
       // { "KICKASS_2Rnd_Sawed_Off_Shotgun_Pellets", "", 500, -1, "" }	
		};
    };

	/* Shops delinquant / criminel â€” items a completer ; licence via panel admin uniquement */
	class mag_delinquant {
		name = "Magasin - Delinquant";
		license = "delinquant";
		items[] = {
			// { "classname", "Nom affiche", prix achat, prix vente (-1 = pas de vente), "licence item optionnelle" }
		{ "ALF_Lockpick", "Crochetage", 5000, -1, "" },

		{ "KA_Glock_18_Single", "", 35000, -1, "" },
		{ "KA_17Rnd_9x19_Mag", "", 500, -1, "" },

		{ "ALF_W_AKS", "", 90000, -1, "" },
		{ "ALF_30Rnd_545x39_Mag_Tracer_F", "", 750, -1, "" },

		{ "AEK_919K", "", 75000, -1, "" },
		{ "20Rnd_9x18_Mag", "", 750, -1, "" },

		{ "ALF_bnae_m97_virtual", "", 80000, -1, "" },
		{ "ALF_2Rnd_00_Buckshot_Magazine", "", 750, -1, "" },

		{ "optic_Holosight_smg_blk_F", "", 750, -1, "" },

		{ "KA_MP7_Rifle_Black_40Rnd", "", 100000, -1, "" },
		{ "KA_40Rnd_46x30_FMJ", "", 800, -1, "" },

		{ "MRP_Mac11", "", 60000, -1, "" },
		{ "MRP_32Rnd_9x17_MAC11", "", 750, -1, "" },

		{ "KICKASS_Sawed_Off_Shotgun", "", 75000, -1, "" },
		{ "KICKASS_2Rnd_Sawed_Off_Shotgun_Pellets", "", 500, -1, "" }	
		
		

		};
	};

	class mag_criminel {
		name = "Magasin - Criminel";
		license = "criminel";
		items[] = {
			// { "classname", "Nom affiche", prix achat, prix vente (-1 = pas de vente), "licence item optionnelle" }
		{ "AN94_MTK83", "", 100000, -1, "" },
        { "AN94_kobra", "", 500, -1, "" },
        { "KA_30rnd_7N6M_FMJ_HSC_mag", "", 500, -1, "" },

        { "optic_Holosight_blk_F", "", 500, -1, "" },
        { "SMG_01_F", "", 75000, -1, "" },
        { "30Rnd_45ACP_Mag_SMG_01", "", 800, -1, "" },

        { "arifle_AK12_F", "", 120000, -1, "" },
        { "30Rnd_762x39_AK12_Mag_F", "", 800, -1, "" },
		
		{ "MRP_AKM_F", "", 120000, -1, "" },
        { "MRP_optic_kobra", "", 500, -1, "" },		
        { "545x39_30rnds_AKM", "", 800, -1, "" },
		
		
        { "KA_Vityaz", "", 75000, -1, "" },
        { "KA_30Rnd_9x19_7N31_AP_Mag", "", 800, -1, "" },
		{ "optic_Yorris", "", 750, -1, "" }		


		};
	};

	class distributeur_auto {
		name = "Distributeur";
		license = "";
		items[] = {
			{ "ALF_Banane", "", 15, -1, "" },
			{ "ALF_Pain", "", 1, -1, "" },
			{ "ALF_Kebab", "", 7, -1, "" },
			{ "ALF_snickers", "", 3, -1, "" },
			{ "ALF_BakedBeans", "", 6, -1, "" },
			{ "ALF_BaconT", "", 9, -1, "" },
			{ "ALF_WaterB_P", "", 3, -1, "" },
			{ "ALF_WaterB_G", "", 6, -1, "" },
			{ "ALF_coca", "", 2, -1, "" },
			{ "ALF_Jus", "", 2, -1, "" },
			{ "ALF_1664", "", 8, -1, "" },
			{ "ALF_Vodka", "", 15, -1, "" },
			{ "ALF_Rome", "", 25, -1, "" },
			{ "ALF_Malibu", "", 25, -1, "" },
			{ "ALF_Luxe2", "", 25, -1, "" },
			{ "ALF_Luxe1", "", 25, -1, "" },
			{ "ALF_Jock", "", 25, -1, "" },
			{ "ALF_Jager", "", 25, -1, "" },
			{ "ALF_Horse", "", 25, -1, "" },
			{ "ALF_51", "", 25, -1, "" },
			{ "ALF_Sky", "", 25, -1, "" },
			{ "ALF_Vazisi", "", 25, -1, "" },
			{ "ALF_Smirnoff", "", 25, -1, "" },
			{ "ALF_Saucisse_Crue_M", "", 10, -1, "" },
			{ "ALF_Bacon_Crue_M", "", 10, -1, "" },
			{ "ALF_CotePorc_Crue_M", "", 25, -1, "" },
			{ "ALF_Poulet_Crue_M", "", 10, -1, "" }
		};
	};

	class distributeur_livreur {
		name = "Approvisionnement distributeur";
		license = "";
		items[] = {
			{ "ALF_Banane", "", 15, -1, "" },
			{ "ALF_Pain", "", 1, -1, "" },
			{ "ALF_Kebab", "", 7, -1, "" },
			{ "ALF_snickers", "", 3, -1, "" },
			{ "ALF_BakedBeans", "", 6, -1, "" },
			{ "ALF_BaconT", "", 9, -1, "" },
			{ "ALF_WaterB_P", "", 3, -1, "" },
			{ "ALF_WaterB_G", "", 6, -1, "" },
			{ "ALF_coca", "", 2, -1, "" },
			{ "ALF_Jus", "", 2, -1, "" },
			{ "ALF_1664", "", 8, -1, "" },
			{ "ALF_Vodka", "", 15, -1, "" },
			{ "ALF_Rome", "", 25, -1, "" },
			{ "ALF_Malibu", "", 25, -1, "" },
			{ "ALF_Luxe2", "", 25, -1, "" },
			{ "ALF_Luxe1", "", 25, -1, "" },
			{ "ALF_Jock", "", 25, -1, "" },
			{ "ALF_Jager", "", 25, -1, "" },
			{ "ALF_Horse", "", 25, -1, "" },
			{ "ALF_51", "", 25, -1, "" },
			{ "ALF_Sky", "", 25, -1, "" },
			{ "ALF_Vazisi", "", 25, -1, "" },
			{ "ALF_Smirnoff", "", 25, -1, "" },
			{ "ALF_Saucisse_Crue_M", "", 10, -1, "" },
			{ "ALF_Bacon_Crue_M", "", 10, -1, "" },
			{ "ALF_CotePorc_Crue_M", "", 25, -1, "" },
			{ "ALF_Poulet_Crue_M", "", 10, -1, "" }
		};
	};
};
