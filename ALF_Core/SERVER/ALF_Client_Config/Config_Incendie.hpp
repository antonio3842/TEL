#define true 1
#define false 0

class ByScream_Incendie_V3 {
	ALF_ConfigToClient_Patern[] = {
		{"ARI_mask_unset", "STRING"},
        {"ARI_mask_set", "STRING"},
		{"ARI", "ARRAY"},
		{"hydrant_debit", "NUMBER"},
		{"allow_multiples_fire", "NUMBER"},
		{"building_burn_time", "NUMBER"},
		{"building_marker_text", "ARRAY"},
		{"building_medic_min", "NUMBER"},
		{"buildings_whitelisted", "ARRAY"},
		{"poubelle_burn_time", "NUMBER"},
		{"poubelle_marker_text", "ARRAY"},
		{"poubelle_medic_min", "NUMBER"},
		{"poubelles_whitelisted", "ARRAY"},
		{"enable_vehicle_fire", "NUMBER"},
		{"vehicle_fire_part1_time", "NUMBER"},
		{"vehicle_fire_part2_time", "NUMBER"},
		{"vehicle_fire_part3_time", "NUMBER"},
		{"foret_burn_time", "NUMBER"},
		{"foret_marker_text", "ARRAY"},
		{"foret_medic_min", "NUMBER"},
		{"coefficient_propagation", "NUMBER"},
		{"flammes_proportionelles", "STRING"},
		{"flammes_par_pompiers", "NUMBER"},
		{"flammes_max", "NUMBER"},
		{"extinguisher_rate", "NUMBER"},
		{"lance_rate", "NUMBER"},
		{"fire_wait_time", "NUMBER"},
		{"fire_wait_time_random", "NUMBER"},
		{"feu_de_batiment", "NUMBER"},
		{"feu_de_poubelle", "NUMBER"},
		{"feu_de_foret", "NUMBER"},
        {"devidoirs", "CLASS", {
            {"ANY", "CLASS", {
				{"nb_tuyau", "NUMBER"}
			}}
        }},
		{"vehicles", "CLASS", {
            {"ANY", "CLASS", {
				{"reservoir", "NUMBER"},
				{"can_refuel_ari", "NUMBER"},
				{"vannes", "ARRAY"},
				{"LDT", "CLASS", {
					{"pos", "STRING"},
					{"longueur", "NUMBER"}
				}}
			}}
        }}
    };


	ARI_mask_unset = "byscream_incendie_v3_cagoule"; //Classname de la cagoule
	ARI_mask_set = "byscream_incendie_v3_masque_ari"; //Classname du masque ARI
	ARI[] = { 
		//Classname des ARI et le temps maximum cappelé
		{"byscream_incendie_v3_ari", 18*60 },
		{"byscream_ari_bspp", 20*60 }
	};

    hydrant_debit = 60000; //Débit en eau des hydrants, défaut : 60000 L/h -> 60 m3/h
	allow_multiples_fire = false; //Autoriser plusieurs feux en simultanés

    //FEU DE BATIMENT
	building_burn_time = 45*60; //Temps maximum que peut bruler un bâtiment, défaut : 45 minutes
	building_marker_text[] = {"Fumée suspecte","Feu d'habitation isolée"}; //Marqueurs qui s'affichent sur la map
	building_medic_min = 4; //Nombre de pompiers minimum pour un feu de bâtiment, défaut : 4
	buildings_whitelisted[] = { //Classname des bâtiments pouvant bruler
		"Land_i_House_Big_01_V1_F"
		,"Land_i_House_Big_01_V2_F"
		,"Land_i_House_Big_01_V3_F"
		,"Land_i_House_Big_02_V1_F"
		,"Land_i_House_Big_02_V2_F"
		,"Land_i_House_Big_02_V3_F"
		,"Land_House_2W02_F"
		,"Land_House_2W05_F"
		,"Land_House_1B01_F"
		,"Land_House_2B01_F"
		,"Land_House_2B02_F"
		,"Land_House_2B03_F"
		,"Land_House_2B04_F"
		,"Land_i_House_Small_01_V1_F"
		,"MRP_Wooden_House_03_F"
		,"Land_i_House_Small_01_V2_F"
		,"Land_i_House_Small_01_V3_F"
		,"Land_House_1W01_F"
		,"Land_House_1W02_F"
		,"Land_House_1W05_F"
		,"Land_House_1W06_F"
		,"Land_House_1W08_F"
		,"Land_House_1W10_F"
		,"Land_House_1W09_F"
		,"Land_i_House_Small_02_V1_F"
		,"Land_i_House_Small_02_V2_F"
		,"Land_i_House_Small_02_V3_F"
		,"Land_House_1W11_F"
		,"Land_House_1W12_F"
		,"Land_House_1W03_F"
		,"Land_House_1W04_F"
		,"Land_House_1W07_F"
		,"Land_House_2W01_F"
		,"Land_House_2W03_F"
		,"Land_House_2W04_F"
		,"Land_Barn_02_F"
		,"Land_Shed_14_F"
		,"Land_i_Addon_02_V1_F"
		,"Land_Camp_House_01_brown_F"
		,"Land_Shed_13_F"
		,"Land_Shed_12_F"
		,"Land_Shed_11_F"
		,"Land_Shed_10_F"
		,"land_aka_caravan"
		,"Land_Caravan_01_green_F"
		,"Land_Caravan_01_rust_F"
		,"Land_i_Garage_V1_F"
		,"Land_i_Garage_V2_F"
		,"Land_Garage"
		,"Land_Garage2"
		,"Land_GarageRow_01_small_F", 
		"Land_i_House_Big_01_b_white_F", 
		"Land_i_House_Big_01_b_brown_F", 
		"Land_i_House_Big_01_b_blue_F", 
		"Land_i_House_Big_01_b_whiteblue_F", 
		"Land_i_House_Big_01_b_pink_F",    
		"Land_i_House_Big_02_b_blue_F", 
		"Land_i_House_Big_02_b_white_F", 
		"Land_i_House_Big_02_b_whiteblue_F", 
		"Land_i_House_Big_02_b_yellow_F", 
		"Land_i_House_Big_02_b_brown_F", 
		"Land_i_House_Big_02_b_pink_F", 
		"Land_House_Big_02_F", 
		"Land_House_Big_03_F", 
		"Land_i_House_Small_03_V1_F",  
		"Land_House_Big_01_F", 
		"Land_i_Stone_HouseSmall_V2_F", 
		"Land_i_Stone_HouseSmall_V3_F", 
		"Land_i_Stone_HouseSmall_V1_F", 
		"Land_House_Small_02_F", 
		"Land_HouseA", 
		"Land_HouseB", 
		"Land_HouseC", 
		"Land_HouseD", 
		"Land_Hotel_02_F"
	};

	//FEU DE POUBELLE
	poubelle_burn_time = 30*60; //Temps maximum que peut bruler une poubelle, défaut : 30 minutes
	poubelle_marker_text[] = {"Feu de poubelle"};
	poubelle_medic_min = 1;
	poubelles_whitelisted[] = {
		"ALF_Poubelle"
	};

	//FEU DE VOITURE
	enable_vehicle_fire = false;
	vehicle_fire_part1_time = 300;
	vehicle_fire_part2_time = 300;
	vehicle_fire_part3_time = 300;

	//FEU DE FORET
	foret_burn_time = 80*60;
	foret_marker_text[] = {"Feu de broussaille","Feu de forêt"}; //Marker
	foret_medic_min = 6; //NOMBRE POMPIERS POUR FEU DE FORET
	coefficient_propagation = 0.8; //COEFFICIENT DE PROPAGATION Default: 1 (2 = le double...)
	flammes_proportionelles = "false"; //Flammes proportionnelles au nombre de SP connectés ?
	flammes_par_pompiers = 2; //Nombre de flammes par pompiers (Uniquement si flammes_proportionelles = "true")
	flammes_max = 8; //NOMBRE DE FLAMMES MAX

	//-------------------


	extinguisher_rate = 0.004; //Dégat que fait un pshhtttt Default = 0.01
	lance_rate = 0.01;
	
	fire_wait_time = 20*60; //Temps entre deux incendies de maisons/poubelles Default: 5400
	fire_wait_time_random = 10*60; //Temps random ajouté au temps minimum Default: 1000

	//POURCENTAGES LORS DE LA CREATION D'UN FEU (Attention la somme des 3 chiffres doit être égale à 100) 
	feu_de_batiment = 50;  //Default: 35
	feu_de_poubelle = 0;  //Default: 55
	feu_de_foret = 50;  //Default: 10
    
    class devidoirs {
        class VEH_MRP_Devidoir_1 {
            nb_tuyau = 5;  //Tuyau de 40m donc au total il y a nb_tuyau * 40m.
        };
    };

    class vehicles {
        class VEH_Mercura_MRP_Renault_FPT {
            reservoir = 3000;
			can_refuel_ARI = true;
            vannes[]={
                "pos_rope_1",
                "pos_rope_2",
                "pos_rope_3",
                "pos_rope_4",
                "pos_rope_5"
            };
            class LDT {
                pos = "pos_ldt";
                longueur = 42;
            };
        };
		class VEH_Mercura_MRP_MB_Unimog_CCF {
            reservoir = 6000;
			can_refuel_ARI = false;
            vannes[]={
                "pos_rope_1",
                "pos_rope_2",
                "pos_rope_3",
                "pos_rope_4"
            };
            class LDT {
                pos = "pos_ldt";
                longueur = 82;
            };
        };
    };

};