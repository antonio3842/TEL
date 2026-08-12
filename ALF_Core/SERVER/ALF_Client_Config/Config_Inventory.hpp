/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/
class ALF_CfgInventory {
	ALF_ConfigToClient_Patern[] = {
        {"ANY", "CLASS", {
             {"ANY", "CLASS", {
				{"displayName", "STRING"},
				{"statement", "STRING"},
				{"condition", "STRING"}
			}}
        }}
    };

	//UTILISER LA VARIALBE 'ALF_item_current_selected' DANS STATEMENT POUR LE CLASSNAME DE L'ITEM

	class ALF_snickers {
		class interaction1 {
			displayName="Manger";
			statement="closeDialog 602;_val = round(random(5)) + 9;_sum = life_hunger + _val;if(_sum > 100) then {_sum = 100; player setFatigue 1;};[_sum,300] spawn ALF_fnc_remonterFaim;[ALF_item_current_selected,false] spawn ALF_fnc_handleItem";
			condition="true";
		};
	};
	class ALF_Pain : ALF_snickers {
		class interaction1 : interaction1 {};
	};
	class ALF_Banane : ALF_snickers {
		class interaction1 : interaction1 {};
	};
	class ALF_Peche : ALF_snickers {
		class interaction1 : interaction1 {};
	};
	class ALF_Pomme : ALF_snickers {
		class interaction1 : interaction1 {};
	};
	class ALF_Bonbon : ALF_snickers {
		class interaction1 : interaction1 {};
	};
	class ALF_Croissant : ALF_snickers {
		class interaction1 : interaction1 {};
	};
	class ALF_Huitre : ALF_snickers {
		class interaction1 : interaction1 {};
	};
	class ALF_Fraise : ALF_snickers {
		class interaction1 : interaction1 {};
	};
	class ALF_Champignon : ALF_snickers {
		class interaction1 : interaction1 {};
	};
	class ALF_Raisin : ALF_snickers {
		class interaction1 : interaction1 {};
	};
	class TAG_Compote_F_F : ALF_snickers {
		class interaction1 : interaction1 {};
	};
	class ALF_XxX {
		class interaction1 {
			displayName="Boire";
			statement="closeDialog 602;_val = round(random(80)) + 25;_sum = life_thirst + _val;if(_sum > 100) then {_sum = 100;};[_sum,300] spawn ALF_fnc_remonterSoif;[ALF_item_current_selected,false] spawn ALF_fnc_handleItem;";
			condition="true";
		};
	};
	class ALF_coca : ALF_XxX {
		class interaction1 : interaction1 {};
	};
	class ALF_Jus : ALF_XxX {
		class interaction1 : interaction1 {};
	};
	class ALF_WaterB_P : ALF_XxX {
		class interaction1 : interaction1 {};
	};
	class ALF_Macchiato : ALF_XxX {
		class interaction1 : interaction1 {};
	};
	class ALF_Expresso : ALF_XxX {
		class interaction1 : interaction1 {};
	};
	class ALF_Viennois : ALF_XxX {
		class interaction1 : interaction1 {};
	};
	class ALF_Cappuccino : ALF_XxX {
		class interaction1 : interaction1 {};
	};
	class ALF_Jus_Pomme : ALF_XxX {
		class interaction1 : interaction1 {};
	};
	class ALF_Jus_Fraise : ALF_XxX {
		class interaction1 : interaction1 {};
	};
	class ALF_Jus_Raisin : ALF_XxX {
		class interaction1 : interaction1 {};
	};
	class ALF_WaterB_G {
		class interaction1 {
			displayName="Boire";
			statement="closeDialog 602;[100,300] spawn ALF_fnc_remonterSoif;[ALF_item_current_selected,false] spawn ALF_fnc_handleItem;";
			condition="true";
		};
	};
	class bouteille_rhum {
		class interaction1 {
			displayName="Boire l'alcool";
			statement="closeDialog 602;_val = random(1) + 0.05;[35,300] spawn ALF_fnc_remonterSoif;[_val] call ALF_fnc_handleAlcool;[ALF_item_current_selected,false] spawn ALF_fnc_handleItem;";
			condition="true";
		};
	};
	class ALF_Vin : bouteille_rhum {
		class interaction1 : interaction1 {};
	};
	class ALF_Pinot : bouteille_rhum {
		class interaction1 : interaction1 {};
	};
	class ALF_Vodka : bouteille_rhum {
		class interaction1 : interaction1 {};
	};
	class ALF_Jack : bouteille_rhum {
		class interaction1 : interaction1 {};
	};
	class ALF_Whisky : bouteille_rhum {
		class interaction1 : interaction1 {};
	};
	class ALF_Rome : bouteille_rhum {
		class interaction1 : interaction1 {};
	};
	class ALF_Malibu : bouteille_rhum {
		class interaction1 : interaction1 {};
	};
	class ALF_Luxe2 : bouteille_rhum {
		class interaction1 : interaction1 {};
	};
	class ALF_Luxe1 : bouteille_rhum {
		class interaction1 : interaction1 {};
	};
	class ALF_Jock : bouteille_rhum {
		class interaction1 : interaction1 {};
	};
	class ALF_Jager : bouteille_rhum {
		class interaction1 : interaction1 {};
	};
	class ALF_Horse : bouteille_rhum {
		class interaction1 : interaction1 {};
	};
	class ALF_1664 : bouteille_rhum {
		class interaction1 : interaction1 {};
	};
	class ALF_51 : bouteille_rhum {
		class interaction1 : interaction1 {};
	};
	class ALF_Sky : bouteille_rhum {
		class interaction1 : interaction1 {};
	};
	class ALF_Vazisi : bouteille_rhum {
		class interaction1 : interaction1 {};
	};
	class ALF_Smirnoff : bouteille_rhum {
		class interaction1 : interaction1 {};
	};
	class ALF_Weed {
		class interaction1 {
			displayName="Consommer la drogue";
			statement="closeDialog 602;_val = random(1) + 0.1;[_val] call ALF_fnc_handleDrug;[ALF_item_current_selected,false] spawn ALF_fnc_handleItem;";
			condition="true";
		};
	};
	class ALF_Weed_2 : ALF_Weed {
		class interaction1 : interaction1 {};
	};
	class ALF_Weed_3 : ALF_Weed {
		class interaction1 : interaction1 {};
	};
	class ALF_Cocaine : ALF_Weed {
		class interaction1 : interaction1 {};
	};
	class ALF_Cocaine_2 : ALF_Weed {
		class interaction1 : interaction1 {};
	};
	class ALF_Meth50 : ALF_Weed {
		class interaction1 : interaction1 {};
	};
	class ALF_Meth90 : ALF_Weed {
		class interaction1 : interaction1 {};
	};

	class ALF_Saucisse_Crue_M {
		class interaction1 {
			displayName="Mettre sur le barbecue";
			statement="closeDialog 602;[ALF_item_current_selected] spawn ALF_fnc_poseViande;";
			condition="true";
		};
	};
	class ALF_CotePorc_Crue_M : ALF_Saucisse_Crue_M {
		class interaction1 : interaction1 {};
	};
	class ALF_Poulet_Crue_M : ALF_Saucisse_Crue_M {
		class interaction1 : interaction1 {};
	};
	class ALF_Bacon_Crue_M : ALF_Saucisse_Crue_M {
		class interaction1 : interaction1 {};
	};
	class ALF_Maquereau_Crue_M : ALF_Saucisse_Crue_M {
		class interaction1 : interaction1 {};
	};
	class ALF_Confiture_Fraise : ALF_Saucisse_Crue_M {
		class interaction1 : interaction1 {};
	};
	class ALF_Confiture_Pomme : ALF_Saucisse_Crue_M {
		class interaction1 : interaction1 {};
	};
	class ALF_CotePorc_Cuite_M {
		class interaction1 {
			displayName="Manger";
			statement="closeDialog 602;_val = round(random(25)) + 75;_sum = life_hunger + _val;if(_sum > 100) then {_sum = 100; player setFatigue 1;};[_sum,300] spawn ALF_fnc_remonterFaim;[ALF_item_current_selected,false] spawn ALF_fnc_handleItem;";
			condition="true";
		};
	};
	class ALF_Poulet_Cuit_M {
		class interaction1 {
			displayName="Manger";
			statement="closeDialog 602;_val = round(random(15)) + 35;_sum = life_hunger + _val;if(_sum > 100) then {_sum = 100; player setFatigue 1;};[_sum,300] spawn ALF_fnc_remonterFaim;[ALF_item_current_selected,false] spawn ALF_fnc_handleItem;";
			condition="true";
		};
	};
	class MRP_Sushi_Thon {
		class interaction1 {
			displayName="Manger";
			statement="closeDialog 602;_val = round(random(15)) + 20;_sum = life_hunger + _val;if(_sum > 100) then {_sum = 100; player setFatigue 1;};[_sum,300] spawn ALF_fnc_remonterFaim;[ALF_item_current_selected,false] spawn ALF_fnc_handleItem;";
			condition="true";
		};
	};
	class MRP_Sushi_Saumon : MRP_Sushi_Thon {
		class interaction1 : interaction1 {};
	};
	class ALF_Saucisse_Cuite_M : MRP_Sushi_Thon {
		class interaction1 : interaction1 {};
	};
	class ALF_CotePorc_Brulee_M : MRP_Sushi_Thon {
		class interaction1 : interaction1 {};
	};
	class ALF_Bacon_Cuit_M : MRP_Sushi_Thon {
		class interaction1 : interaction1 {};
	};
	class ALF_Maquereau_Cuit_M : MRP_Sushi_Thon {
		class interaction1 : interaction1 {};
	};
	class ALF_Tarte_Pomme : MRP_Sushi_Thon {
		class interaction1 : interaction1 {};
	};
	class ALF_Tarte_Fraise : MRP_Sushi_Thon {
		class interaction1 : interaction1 {};
	};
	class ALF_BakedBeans : MRP_Sushi_Thon {
		class interaction1 : interaction1 {};
	};
	class ALF_BaconT : MRP_Sushi_Thon {
		class interaction1 : interaction1 {};
	};
	class ALF_Kebab : MRP_Sushi_Thon {
		class interaction1 : interaction1 {};
	};
	class ALF_Saucisse_Brulee_M {
		class interaction1 {
			displayName="Manger";
			statement="closeDialog 602;_val = round(random(10)) + 15;_sum = life_hunger + _val;if(_sum > 100) then {_sum = 100; player setFatigue 1;};[_sum,300] spawn ALF_fnc_remonterFaim;[ALF_item_current_selected,false] spawn ALF_fnc_handleItem;";
			condition="true";
		};
	};
	class ALF_Poulet_Brulee_M : ALF_Saucisse_Brulee_M {
		class interaction1 : interaction1 {};
	};
	class ALF_Bacon_Brulee_M : ALF_Saucisse_Brulee_M {
		class interaction1 : interaction1 {};
	};
	class ALF_Maquereau_Brulee_M : ALF_Saucisse_Brulee_M {
		class interaction1 : interaction1 {};
	};
	class ALF_Medoc_rhume {
		class interaction1 {
			displayName="Prendre le médicament";
			statement="closeDialog 602;[ALF_item_current_selected,true] spawn ALF_fnc_handleMedecine;";
			condition="true";
		};
	};
	class ALF_Medoc_toux : ALF_Medoc_rhume {
		class interaction1 : interaction1 {};
	};
	class ALF_Lockpick {
		class interaction1 {
			displayName="Utiliser le pied de biche";
			statement="closeDialog 602;if(cursorObject isKindOf 'House_F') then {[cursorObject,1] spawn ALF_fnc_copBreakDoor;} else {if(cursorObject in [alf_coffre_prison_1,alf_coffre_prison_2,alf_coffre_prison_3,alf_coffre_prison_4,alf_coffre_prison_5,alf_coffre_prison_6,alf_coffre_prison_7,alf_coffre_prison_8,alf_coffre_prison_9,alf_coffre_prison_10,alf_coffre_prison_11,alf_coffre_prison_12,alf_coffre_prison_13,alf_coffre_prison_14,alf_coffre_prison_15,alf_coffre_prison_16,alf_coffre_prison_17,alf_coffre_prison_18,alf_coffre_prison_19,alf_coffre_prison_20] && {((cursorObject animationSourcePhase 'safe_source') < 0.5) OR {(cursorObject animationSourcePhase 'piege_source') < 0.5}}) then {if((cursorObject animationSourcePhase 'safe_source') < 0.5) then {[cursorObject,1] remoteExec ['ALF_Server_fnc_customCoffre',2];} else {[cursorObject,3] remoteExec ['ALF_Server_fnc_customCoffre',2];};['ALF_Lockpick',false] call ALF_fnc_handleItem;} else {['Info', 'Vous ne pouvez pas utiliser cet objet ici.', 'warning', false] spawn ALF_fnc_doMsg;};};";
			condition="true";
		};
	};
	class ALF_Pc_Traceur {
		class interaction1 {
			displayName="Ouvrir le PC";
			statement="closeDialog 602;[0] spawn ALF_fnc_menuInspectTel;";
			condition="true";
		};
	};
	class O2_Item_Stop_Stick_x2 {
		class interaction1 {
			displayName="Mettre le stopstick";
			statement="closeDialog 602;[ALF_item_current_selected] spawn ALF_fnc_spikeStrip;";
			condition="true";
		};
	};
	class ALF_Radar_m_i {
		class interaction1 {
			displayName="Mettre le radar";
			statement="closeDialog 602;[ALF_item_current_selected] spawn ALF_fnc_placeRadarM;";
			condition="true";
		};
	};
	class ALF_Camera_Discret {
		class interaction1 {
			displayName="Mettre la caméra";
			statement="closeDialog 602;[cursortarget] spawn ALF_fnc_placeCam;";
			condition="true";
		};
	};
	class O2_Item_Affiche_Arret {
		class interaction1 {
			displayName="Placer l'objet";
			statement="closeDialog 602;[ALF_item_current_selected] spawn ALF_fnc_Object_deploy;";
			condition="true";
		};
	};
	class O2_Item_Affiche_Arret_Exp : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class O2_Item_Affiche_Arret_Stat : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class O2_Item_Affiche_Arret_Circ : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class O2_Item_Affiche_Arret_Ferm : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class O2_Signal_Item_Cone : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class O2_Signal_Item_Cone_Sp : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class O2_Signal_Item_Cone_DIR : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class O2_Signal_Item_Trav : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class O2_Signal_Item_Trav_dang : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class O2_Signal_Item_Trav_dang_gliss : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class O2_Signal_Item_Trav_dang_retre : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class O2_Signal_Item_Trav_dang_accid : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class O2_Signal_Item_Trav_dang_grav : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class O2_Signal_Item_Trav_Dev_Dr : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class O2_Signal_Item_Trav_Dev_Ga : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class O2_Signal_Item_Trav_Dev_Dr_Pl : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class O2_Signal_Item_Trav_Dev_Ga_Pl : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class O2_Signal_Item_Trav_Ron : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class O2_Signal_Item_Trav_30 : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class O2_Signal_Item_Trav_70 : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class O2_Signal_Item_Trav_110 : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class O2_Signal_Item_Trav_Limit_Fin : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class O2_Signal_Item_Trav_Int_Sta : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class O2_Signal_Item_Trav_Int_Arr : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class O2_Signal_Item_Trav_Int_Depass : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class O2_Signal_Item_Trav_Int_Depass_Fin : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class O2_Signal_Item_Trav_Obl_Dr : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class O2_Signal_Item_Trav_Obl_Ga : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class O2_Signal_Item_Halt_Gn : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class O2_Signal_Item_Halt_Pm : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class O2_Signal_Item_Trav_Rect : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class O2_Signal_Item_Trav_Flech_Dr : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class O2_Signal_Item_Trav_Flech_Ga : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class O2_Signal_Item_Trav_Bar_50 : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class O2_Signal_Item_Trav_Bar_100 : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class O2_Signal_Item_Trav_Balise_K5 : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class O2_Signal_Item_Trav_Bloc_Rg : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class O2_Signal_Item_Trav_Bloc_Bl : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class O2_Signal_Item_Triflash : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class O2_Signal_Item_Triflash_Dang : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class O2_Signal_Item_Triflash_Accid : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class O2_Signal_Item_Cone_Flash : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class MRP_Cible : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class MRP_Cible_precision : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class MRP_Cible_precision2 : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class ALF_PortableLight_double : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class ALF_BagFence_Long : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class ALF_BagFence_Round : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class ALF_PortableLight_single : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class ALF_Triangle_Item : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class ALF_Barricades_Item : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class ALF_Bloc_route_Item : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class ALF_Route_barree_Item : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class ALF_Route_barree_100_Item : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class ALF_Route_barree_200_Item : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class ALF_Route_barree_300_Item : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class ALF_Route_barree_400_Item : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class ALF_Route_barree_500_Item : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class ALF_Route_barree_600_Item : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class ALF_Route_barree_700_Item : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class ALF_Route_barree_800_Item : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class ALF_Route_barree_900_Item : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class ALF_30_Item : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class ALF_50_Item : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class ALF_Triflash_Item : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class ALF_Tente_1_Item : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class ALF_Table_Palais : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class ALF_P_devi_d : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class ALF_P_devi_g : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class ALF_P_halte : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class ALF_Camping_Chair_Item : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class ALF_Rideaux_Item : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class ALF_DonDuSang_Chair_Item : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class ALF_Poubelle_Medic_Item : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class ALF_Table_Soin_Item : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class ALF_Tente_Medic_Item : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class ALF_Chevalet : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class ALF_LX_travaux_temp_item : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class ALF_LX_retrecissement_temp_item : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class ALF_LX_attention_temp_item : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class ALF_LX_sens_interdit_item : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class ALF_LX_v30_item : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class ALF_LX_v50_item : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class ALF_LX_sens_item : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class ALF_LX_cone_flash_item : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class ALF_LX_cone_drapeau_item : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class ALF_bbq_M {
		class interaction1 {
			displayName="Placer le barbecue";
			statement="closeDialog 602;[ALF_item_current_selected] spawn ALF_fnc_poserBBQ;";
			condition="true";
		};
	};
	class ALF_Charge_C2_M {
		class interaction1 {
			displayName="Placer la charge";
			statement="closeDialog 602;[ALF_item_current_selected] spawn ALF_fnc_poserChargePorte;";
			condition="license_GIGN";
		};
	};
	class ALF_Perceuse_GDM_M {
		class interaction1 {
			displayName="Placer la perceuse";
			statement="closeDialog 602;[ALF_item_current_selected] spawn ALF_fnc_poserPerceuse;";
			condition="true";
		};
	};
	class ALF_laptop_unfolded_f {
		class interaction1 {
			displayName="Utiliser l'ordinateur";
			statement="closeDialog 602;if(life_gendarme_service && {(typeOf cursorObject) isEqualTo 'Land_ALF_ATM'} && {player distance cursorObject < 3} && {license_TIC}) then {cursorObject] spawn ALF_fnc_laptopMenu;} else {['Info', 'Vous ne pouvez pas utiliser cet objet.', 'warning', false] spawn ALF_fnc_doMsg;};";
			condition="true";
		};
	};
	class ALF_laptop_dir {
		class interaction1 {
			displayName="Utiliser l'ordinateur";
			statement="closeDialog 602;if(life_publique_service && {b_18}) then {uiNamespace setVariable ['alf_dir_menu',0];[] spawn ALF_fnc_dirpc;} else {['Info', 'Vous ne pouvez pas utiliser cet objet.', 'warning', false] spawn ALF_fnc_doMsg;};";
			condition="true";
		};
	};
	class ALF_Graine_M {
		class interaction1 {
			displayName="Planter du maïs";
			statement="closeDialog 602;[ALF_item_current_selected] spawn ALF_fnc_planterMais;";
			condition="true";
		};
	};
	class ALF_Graine_T {
		class interaction1 {
			displayName="Planter du tabac";
			statement="closeDialog 602;[ALF_item_current_selected] spawn ALF_fnc_planterTabac;";
			condition="true";
		};
	};
	class Graine_canne_sucre {
		class interaction1 {
			displayName="Planter de la canne à sucre";
			statement="closeDialog 602;[ALF_item_current_selected] spawn ALF_fnc_planterCanneSucre;";
			condition="true";
		};
	};
	class ALF_Barile_10 {
		class interaction1 {
			displayName="Remplir le véhicule";
			statement="closeDialog 602;[ALF_item_current_selected] spawn ALF_fnc_refuelCar;";
			condition="true";
		};
	};
	class ALF_Barile_20 : ALF_Barile_10 {
		class interaction1 : interaction1 {};
	};
	class ALF_Barile_30 : ALF_Barile_10 {
		class interaction1 : interaction1 {};
	};
	class ALF_Barile_40 : ALF_Barile_10 {
		class interaction1 : interaction1 {};
	};
	class ALF_Barile_50 : ALF_Barile_10 {
		class interaction1 : interaction1 {};
	};
	class ALF_Barile_60 : ALF_Barile_10 {
		class interaction1 : interaction1 {};
	};
	class ALF_Barile_70 : ALF_Barile_10 {
		class interaction1 : interaction1 {};
	};
	class ALF_Barile_80 : ALF_Barile_10 {
		class interaction1 : interaction1 {};
	};
	class ALF_Barile_90 : ALF_Barile_10 {
		class interaction1 : interaction1 {};
	};
	class ALF_Barile_100 : ALF_Barile_10 {
		class interaction1 : interaction1 {};
	};
	class ALF_Barile_0 {
		class interaction1 {
			displayName="Siphoner le véhicule";
			statement="closeDialog 602;[ALF_item_current_selected] spawn ALF_fnc_siphonageVehicles;";
			condition="true";
		};
	};
	class ALF_Peinture_Black {
		class interaction1 {
			displayName="Peindre";
			statement="closeDialog 602;[player, 'ALF_Client2\Textures\tags\black\0.paa'] spawn ALF_fnc_tag;";
			condition="true";
		};
	};
	class ALF_Peinture_Blue {
		class interaction1 {
			displayName="Peindre";
			statement="closeDialog 602;[player, 'ALF_Client2\Textures\tags\blue\0.paa'] spawn ALF_fnc_tag;";
			condition="true";
		};
	};
	class ALF_Peinture_Green {
		class interaction1 {
			displayName="Peindre";
			statement="closeDialog 602;[player, 'ALF_Client2\Textures\tags\green\0.paa'] spawn ALF_fnc_tag;";
			condition="true";
		};
	};
	class ALF_Peinture_Red {
		class interaction1 {
			displayName="Peindre";
			statement="closeDialog 602;[player, 'ALF_Client2\Textures\tags\red\0.paa'] spawn ALF_fnc_tag;";
			condition="true";
		};
	};
	class ToolKit {
		class interaction1 {
			displayName="Réparer";
			statement="closeDialog 602;if (b_18 && b_enService) then {[] spawn MRPV2_fnc_reparerDir;};if (MRP_Bie_EnService) then {[] spawn ALF_fnc_reparerBie;};";
			condition="true";
		};
	};
	class BOXED_land_MRP_Petit_Generateur {
		class interaction1 {
			displayName="Poser";
			statement="closeDialog 602;[0] spawn ALF_fnc_poseGenerator;";
			condition="true";
		};
	};
	class BOXED_land_MRP_Grand_Generateur {
		class interaction1 {
			displayName="Poser";
			statement="closeDialog 602;[2] spawn ALF_fnc_poseGenerator;";
			condition="true";
		};
	};
	class MRP_Item_O2_Kdo_rouge {
		class interaction1 {
			displayName="Ouvrir";
			statement="closeDialog 602;[ALF_item_current_selected,true] spawn MRPV2_fnc_openNoelGift;";
			condition="true";
		};
	};
	class MRP_Item_O2_Kdo_Bleu : MRP_Item_O2_Kdo_rouge {
		class interaction1 : interaction1 {};
	};
	class MRP_Item_O2_Kdo_Vert : MRP_Item_O2_Kdo_rouge {
		class interaction1 : interaction1 {};
	};
	class MRP_Item_O2_Kdo_Rose : MRP_Item_O2_Kdo_rouge {
		class interaction1 : interaction1 {};
	};
	class MRP_Item_O2_Gros_Kdo_Rouge : MRP_Item_O2_Kdo_rouge {
		class interaction1 : interaction1 {};
	};
	class MRP_Item_O2_Gros_Kdo_Bleu : MRP_Item_O2_Kdo_rouge {
		class interaction1 : interaction1 {};
	};
	class MRP_Item_O2_Gros_Kdo_Vert : MRP_Item_O2_Kdo_rouge {
		class interaction1 : interaction1 {};
	};
	class MRP_Item_O2_Gros_Kdo_Rose : MRP_Item_O2_Kdo_rouge {
		class interaction1 : interaction1 {};
	};
	class mrp_rubalise {
		class interaction1 {
			displayName="Placer la rubalise";
			statement="closeDialog 602;[ALF_item_current_selected] spawn ALF_fnc_placerRubalise;";
			condition="true";
		};
	};
	class MRP_Rubalise_gn : mrp_rubalise {
		class interaction1 : interaction1 {};
	};
	class MRP_Rubalise_pm : mrp_rubalise {
		class interaction1 : interaction1 {};
	};
	class MRP_Rubalise_sp : mrp_rubalise {
		class interaction1 : interaction1 {};
	};

	// Kits objets placables (CfgWeapons Item_* — addon ou config dédié requis)
	class Item_PortableLight_single : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class Item_PortableLight_double : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class Item_PortableGenerator_01 : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class Item_FireExtinguisher : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class Item_GasTank_01_blue : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class Item_GasTank_01_yellow : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class Item_BloodPool_01_Large : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class Item_BloodPool_01_Medium : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class Item_Bodybag_01_white : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class Item_FirstAidKit_01_open : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class Item_MedicalTent_01_white : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class Item_TentA : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
	class Item_Grinder_01 : O2_Item_Affiche_Arret {
		class interaction1 : interaction1 {};
	};
};
