/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/
class ALF_OBJECTS {

	ALF_ConfigToClient_Patern[] = {
        {"ANY", "CLASS", {
            {"item", "STRING"},
            {"attachTo", "ARRAY"},
			{"conditionRecup", "STRING"}
        }}
    };

	class Target_PopUp3_Moving_Acc2_F {
		item = "MRP_Cible";
		attachTo[] = {0,0.85,0.7};
		conditionRecup = "";
	};

	class Land_Target_Dueling_01_F {
		item = "MRP_Cible_precision";
		attachTo[] = {0,0.85,0.7};
		conditionRecup = "";
	};

	class Land_Target_Oval_F {
		item = "MRP_Cible_precision2";
		attachTo[] = {0,0.85,0.7};
		conditionRecup = "";
	};

	class Land_ALF_Triflash {
		item = "ALF_Triflash_Item";
		attachTo[] = {0,0.85,0.7};
		conditionRecup = "";
	};
	class ALF_Triangle {
		item = "ALF_Triangle_Item";
		attachTo[] = {0,0.85,0.3};
		conditionRecup = "";
	};
	class ALF_Camping_Chair {
		item = "ALF_Camping_Chair_Item";
		attachTo[] = {0,0.7,1.2};
		conditionRecup = "";
	};
	class ALF_Rideaux {
		item = "ALF_Rideaux_Item";
		attachTo[] = {0,3.5,0.5};
		conditionRecup = "";
	};
	class ALF_Poubelle_Medic {
		item = "ALF_Poubelle_Medic_Item";
		attachTo[] = {0,1.5,0.74};
		conditionRecup = "";
	};
	class ALF_Table_Soin {
		item = "ALF_Table_Soin_Item";
		attachTo[] = {0,1.5,1.52};
		conditionRecup = "life_mediclevel > 0";
	};
	class ALF_Tente_Medic {
		item = "ALF_Tente_Medic_Item";
		attachTo[] = {0,8,1.95};
		conditionRecup = "life_mediclevel > 0";
	};
	class ALF_Don_Sang {
		item = "ALF_DonDuSang_Chair_Item";
		attachTo[] = {0,0.7,1.2};
		conditionRecup = "life_mediclevel > 0 && {!(_object getVariable [""ALF_player_usingChaise"",false])}";
	};
	class ALF_Table_Palais {
		item = "ALF_Table_Palais";
		attachTo[] = {0,0.7,1.2};
		conditionRecup = "";
	};
	class ALF_Chevalet {
		item = "ALF_Chevalet";
		attachTo[] = {0,0.7,1.2};
		conditionRecup = "";
	};
	class Land_30 {
		item = "ALF_30_Item";
		attachTo[] = {0,0.85,0.3};
		conditionRecup = "";
	};
	class Land_50 {
		item = "ALF_50_Item";
		attachTo[] = {0,0.85,0.3};
		conditionRecup = "";
	};
	class ALF_Tente_1 {
		item = "ALF_Tente_1_Item";
		attachTo[] = {0,2,1.5};
		conditionRecup = "";
	};
	class ALF_Herse {
		item = "ALF_Herse_i";
		attachTo[] = {0,2.5,0.1};
		conditionRecup = "";
	};
	class land_O2_Stop_Stick_x2 {
		item = "O2_Item_Stop_Stick_x2";
		attachTo[] = {0,1.5,0};
		conditionRecup = "";
	};
	class Land_halte {
		item = "ALF_P_halte";
		attachTo[] = {0,0.85,0.3};
		conditionRecup = "";
	};
	class Land_Panneau_D {
		item = "ALF_P_devi_g";
		attachTo[] = {0,0.85,0.3};
		conditionRecup = "";
	};
	class Land_Panneau_D_g {
		item = "ALF_P_devi_d";
		attachTo[] = {0,0.85,0.3};
		conditionRecup = "";
	};
	class ALF_Barricades {
		item = "ALF_Barricades_Item";
		attachTo[] = {0,1.5,0.59};
		conditionRecup = "";
	};
	class ALF_Bloc_route {
		item = "ALF_Bloc_route_Item";
		attachTo[] = {0,1.5,1};
		conditionRecup = "";
	};
	class ALF_Route_barree {
		item = "ALF_Route_barree_Item";
		attachTo[] = {0,1.5,1};
		conditionRecup = "";
	};
	class ALF_Route_barree_100 {
		item = "ALF_Route_barree_100_Item";
		attachTo[] = {0,1.5,1};
		conditionRecup = "";
	};
	class ALF_Route_barree_200 {
		item = "ALF_Route_barree_200_Item";
		attachTo[] = {0,1.5,1};
		conditionRecup = "";
	};
	class ALF_Route_barree_300 {
		item = "ALF_Route_barree_300_Item";
		attachTo[] = {0,1.5,1};
		conditionRecup = "";
	};
	class ALF_Route_barree_400 {
		item = "ALF_Route_barree_400_Item";
		attachTo[] = {0,1.5,1};
		conditionRecup = "";
	};
	class ALF_Route_barree_500 {
		item = "ALF_Route_barree_500_Item";
		attachTo[] = {0,1.5,1};
		conditionRecup = "";
	};
	class ALF_Route_barree_600 {
		item = "ALF_Route_barree_600_Item";
		attachTo[] = {0,1.5,1};
		conditionRecup = "";
	};
	class ALF_Route_barree_700 {
		item = "ALF_Route_barree_700_Item";
		attachTo[] = {0,1.5,1};
		conditionRecup = "";
	};
	class ALF_Route_barree_800 {
		item = "ALF_Route_barree_800_Item";
		attachTo[] = {0,1.5,1};
		conditionRecup = "";
	};
	class ALF_Route_barree_900 {
		item = "ALF_Route_barree_900_Item";
		attachTo[] = {0,1.5,1};
		conditionRecup = "";
	};
	class ALF_Poubelle {
		item = "ALF_noItem";
		attachTo[] = {0,1.5,0.8};
		conditionRecup = "false";
	};
	
	class Land_BagFence_Long_F {
		item = "ALF_BagFence_Long";
		attachTo[]={0,1.5,0.3};
		conditionRecup = "false";
	};
	class Land_BagFence_Round_F {
		item = "ALF_BagFence_Round";
		attachTo[]={0,3.5,0.3};
		conditionRecup = "false";
	};
	class Land_travaux_temp {
		item = "ALF_LX_travaux_temp_item";
		attachTo[] = {0,1.5,1};
		conditionRecup = "";
	};
	class Land_retrecissement_temp {
		item = "ALF_LX_retrecissement_temp_item";
		attachTo[] = {0,1.5,1};
		conditionRecup = "";
	};
	class Land_attention_temp {
		item = "ALF_LX_attention_temp_item";
		attachTo[] = {0,1.5,1};
		conditionRecup = "";
	};
	class Land_sens_interdit {
		item = "ALF_LX_sens_interdit_item";
		attachTo[] = {0,1.5,1};
		conditionRecup = "";
	};
	class Land_panneau_30 {
		item = "ALF_LX_v30_item";
		attachTo[] = {0,1.5,1};
		conditionRecup = "";
	};
	class Land_panneau_50 {
		item = "ALF_LX_v50_item";
		attachTo[] = {0,1.5,1};
		conditionRecup = "";
	};
	class Land_cone_flash {
		item = "ALF_LX_cone_flash_item";
		attachTo[] = {0,1.5,1};
		conditionRecup = "";
	};
	class Land_cone_drapeau {
		item = "ALF_LX_cone_drapeau_item";
		attachTo[] = {0,1.5,1};
		conditionRecup = "";
	};
	class Land_O2_cone {
		item = "O2_Signal_Item_Cone";
		attachTo[] = {0,1.2,0};
		conditionRecup = "";
	};
	class Land_O2_cone_sp {
	    item = "O2_Signal_Item_Cone_Sp";
		attachTo[] = {0,1.2,0};
	    conditionRecup = "";
	};
	class Land_O2_cone_dir {
	    item = "O2_Signal_Item_Cone_DIR";
		attachTo[] = {0,1.2,0};
	    conditionRecup = "";
	};
	class Land_O2_trav_pann {
	    item = "O2_Signal_Item_Trav";
		attachTo[] = {0,1.2,0};
	    conditionRecup = "";
	};
	class Land_O2_trav_pann_dang {
	    item = "O2_Signal_Item_Trav_dang";
		attachTo[] = {0,1.2,0};
	    conditionRecup = "";
	};
	class Land_O2_trav_pann_dang_gliss {
	    item = "O2_Signal_Item_Trav_dang_gliss";
		attachTo[] = {0,1.2,0};
	    conditionRecup = "";
	};
	class Land_O2_trav_pann_dang_retre {
	    item = "O2_Signal_Item_Trav_dang_retre";
		attachTo[] = {0,1.2,0};
	    conditionRecup = "";
	};
	class Land_O2_trav_pann_dang_accid {
	    item = "O2_Signal_Item_Trav_dang_accid";
		attachTo[] = {0,1.2,0};
	    conditionRecup = "";
	};
	class Land_O2_trav_pann_dang_grav {
	    item = "O2_Signal_Item_Trav_dang_grav";
		attachTo[] = {0,1.2,0};
	    conditionRecup = "";
	};
	class Land_O2_trav_Dev_Dr {
	    item = "O2_Signal_Item_Trav_Dev_Dr";
		attachTo[] = {0,1.2,0};
	    conditionRecup = "";
	};
	class Land_O2_trav_Dev_Ga {
	    item = "O2_Signal_Item_Trav_Dev_Ga";
		attachTo[] = {0,1.2,0};
	    conditionRecup = "";
	};
	class Land_O2_trav_Dev_Dr_Pl {
	    item = "O2_Signal_Item_Trav_Dev_Dr_Pl";
		attachTo[] = {0,1.2,0};
	    conditionRecup = "";
	};
	class Land_O2_trav_Dev_Ga_Pl {
	    item = "O2_Signal_Item_Trav_Dev_Ga_Pl";
		attachTo[] = {0,1.2,0};
	    conditionRecup = "";
	};
	class Land_O2_trav_pann_Ron {
	    item = "O2_Signal_Item_Trav_Ron";
		attachTo[] = {0,1.2,0};
	    conditionRecup = "";
	};
	class Land_O2_trav_limit_30 {
	    item = "O2_Signal_Item_Trav_30";
		attachTo[] = {0,1.2,0};
	    conditionRecup = "";
	};
	class Land_O2_trav_limit_70 {
	    item = "O2_Signal_Item_Trav_70";
		attachTo[] = {0,1.2,0};
	    conditionRecup = "";
	};
	class Land_O2_trav_limit_110 {
	    item = "O2_Signal_Item_Trav_110";
		attachTo[] = {0,1.2,0};
	    conditionRecup = "";
	};
	class Land_O2_trav_limit_fin {
	    item = "O2_Signal_Item_Trav_Limit_Fin";
		attachTo[] = {0,1.2,0};
	    conditionRecup = "";
	};
	class Land_O2_trav_int_sta {
	    item = "O2_Signal_Item_Trav_Int_Sta";
		attachTo[] = {0,1.2,0};
	    conditionRecup = "";
	};
	class Land_O2_trav_int_arr {
	    item = "O2_Signal_Item_Trav_Int_Arr";
		attachTo[] = {0,1.2,0};
	    conditionRecup = "";
	};
	class Land_O2_trav_int_depass {
	    item = "O2_Signal_Item_Trav_Int_Depass";
		attachTo[] = {0,1.2,0};
	    conditionRecup = "";
	};
	class Land_O2_trav_int_depass_fin {
	    item = "O2_Signal_Item_Trav_Int_Depass_Fin";
		attachTo[] = {0,1.2,0};
	    conditionRecup = "";
	};
	class Land_O2_trav_obl_dr {
	    item = "O2_Signal_Item_Trav_Obl_Dr";
		attachTo[] = {0,1.2,0};
	    conditionRecup = "";
	};
	class Land_O2_trav_obl_ga {
	    item = "O2_Signal_Item_Trav_Obl_Ga";
		attachTo[] = {0,1.2,0};
	    conditionRecup = "";
	};
	class Land_O2_trav_halt_gn {
	    item = "O2_Signal_Item_Halt_Gn";
		attachTo[] = {0,1.2,0};
	    conditionRecup = "";
	};
	class Land_O2_trav_halt_pm {
	    item = "O2_Signal_Item_Halt_Pm";
		attachTo[] = {0,1.2,0};
	    conditionRecup = "";
	};
	class Land_O2_trav_pann_rect {
	    item = "O2_Signal_Item_Trav_Rect";
		attachTo[] = {0,1.2,0};
	    conditionRecup = "";
	};
	class Land_O2_trav_pann_flech_dr {
	    item = "O2_Signal_Item_Trav_Flech_Dr";
		attachTo[] = {0,1.2,0};
	    conditionRecup = "";
	};
	class Land_O2_trav_pann_flech_ga {
	    item = "O2_Signal_Item_Trav_Flech_Ga";
		attachTo[] = {0,1.2,0};
	    conditionRecup = "";
	};
	class Land_O2_trav_pann_rect_50 {
	    item = "O2_Signal_Item_Trav_Bar_50";
		attachTo[] = {0,1.2,0};
	    conditionRecup = "";
	};
	class Land_O2_trav_pann_rect_100 {
	    item = "O2_Signal_Item_Trav_Bar_100";
		attachTo[] = {0,1.2,0};
	    conditionRecup = "";
	};
	class Land_O2_trav_balise_K5 {
	    item = "O2_Signal_Item_Trav_Balise_K5";
		attachTo[] = {0,1.2,0};
	    conditionRecup = "";
	};
	class Land_O2_trav_bloc_r {
	    item = "O2_Signal_Item_Trav_Bloc_Rg";
		attachTo[] = {0,1.2,0};
	    conditionRecup = "";
	};
	class Land_O2_trav_bloc_b {
	    item = "O2_Signal_Item_Trav_Bloc_Bl";
		attachTo[] = {0,1.2,0};
	    conditionRecup = "";
	};
	class Land_O2_triflash {
	    item = "O2_Signal_Item_Triflash";
		attachTo[] = {0,1.2,0};
	    conditionRecup = "";
	};
	class Land_O2_triflash_dang {
	    item = "O2_Signal_Item_Triflash_Dang";
		attachTo[] = {0,1.2,0};
	    conditionRecup = "";
	};
	class Land_O2_triflash_accid {
	    item = "O2_Signal_Item_Triflash_Accid";
		attachTo[] = {0,1.2,0};
	    conditionRecup = "";
	};
	class Land_O2_cone_flash {
	    item = "O2_Signal_Item_Cone_Flash";
		attachTo[] = {0,1.2,0};
	    conditionRecup = "";
	};
	class Land_O2_Affiche_Arret_F {
	    item = "O2_Item_Affiche_Arret";
		attachTo[] = {0,1,0};
	    conditionRecup = "b_13"; //Prefecture
	};
	class Land_O2_Affiche_Arret_Exp_F {
	    item = "O2_Item_Affiche_Arret_Exp";
		attachTo[] = {0,1,0};
	    conditionRecup = "b_13"; //Prefecture
	};
	class Land_O2_Affiche_Arret_Sta_F {
	    item = "O2_Item_Affiche_Arret_Stat";
		attachTo[] = {0,1,0};
	    conditionRecup = "b_13"; //Prefecture
	};
	class Land_O2_Affiche_Arret_Cir_F {
	    item = "O2_Item_Affiche_Arret_Circ";
		attachTo[] = {0,1,0};
	    conditionRecup = "b_13"; //Prefecture
	};
	class Land_O2_Affiche_Arret_Ferm_F {
	    item = "O2_Item_Affiche_Arret_Ferm";
		attachTo[] = {0,1,0};
	    conditionRecup = "b_13"; //Prefecture
	};

	// Kits objets placables (Item_*) — mêmes repères que O2 / panneaux (ajuster attachTo au besoin)
	class Land_PortableLight_single_F {
		item = "Item_PortableLight_single";
		attachTo[] = {0,1.5,1.08};
		conditionRecup = "";
	};
	class Land_PortableLight_double_F {
		item = "Item_PortableLight_double";
		attachTo[] = {0,1.5,1.08};
		conditionRecup = "";
	};
	class Land_PortableGenerator_01_F {
		item = "Item_PortableGenerator_01";
		attachTo[] = {0,1.5,0.38};
		conditionRecup = "";
	};
	class Land_FireExtinguisher_F {
		item = "Item_FireExtinguisher";
		attachTo[] = {0,1.5,0.39};
		conditionRecup = "";
	};
	class Land_GasTank_01_blue_F {
		item = "Item_GasTank_01_blue";
		attachTo[] = {0,1.5,0.34};
		conditionRecup = "";
	};
	class Land_GasTank_01_yellow_F {
		item = "Item_GasTank_01_yellow";
		attachTo[] = {0,1.5,0.34};
		conditionRecup = "";
	};
	class BloodPool_01_Large_F {
		item = "Item_BloodPool_01_Large";
		attachTo[] = {0,1.2,0};
		conditionRecup = "";
	};
	class BloodPool_01_Medium_F {
		item = "Item_BloodPool_01_Medium";
		attachTo[] = {0,1.2,0};
		conditionRecup = "";
	};
	class Land_Bodybag_01_white_F {
		item = "Item_Bodybag_01_white";
		attachTo[] = {0,1.5,0.14};
		conditionRecup = "";
	};
	class Land_FirstAidKit_01_open_F {
		item = "Item_FirstAidKit_01_open";
		attachTo[] = {0,1.5,0.06};
		conditionRecup = "";
	};
	class Land_MedicalTent_01_white_F {
		item = "Item_MedicalTent_01_white";
		attachTo[] = {0,1.5,0.58};
		conditionRecup = "";
	};
	class Land_TentA_F {
		item = "Item_TentA";
		attachTo[] = {0,1.5,0.58};
		conditionRecup = "";
	};
	class Land_Grinder_01_F {
		item = "Item_Grinder_01";
		attachTo[] = {0,1.5,0};
		conditionRecup = "";
	};
};
