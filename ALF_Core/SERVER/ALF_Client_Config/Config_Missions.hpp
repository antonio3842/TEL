/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/
class ALF_MISSIONS {

	ALF_ConfigToClient_Patern[] = {
        {"ANY", "CLASS", {
            {"name", "STRING"},
            {"prix", "NUMBER"},
            {"vehicle", "STRING"},
			{"positions", "ARRAY"},
			{"stock", "CLASS", {
				{"weapons", "ARRAY"},
				{"magazines", "ARRAY"},
				{"items", "ARRAY"}
			}}
        }}
    };

	class crime {
		name = "Livraison criminelle";
		prix = 500000;
		vehicle = "CargoNet_01_box_F";
		positions[] = {
			{7825,2936,0},
			{2332,9278,0},
			{4115,2240,0}
		};
		class stock {
			weapons[] = {
				"MRP_AKM_F",
				"arifle_AKS_F",
				"KA_Vityaz",
				"KICKASS_Sawed_Off_Shotgun"
			};
			magazines[] = {
				"545x39_30rnds_AKM",
				"0Rnd_545x39_Mag_F",
				"KA_30Rnd_9x19_7N31_AP_Mag",
				"KICKASS_2Rnd_Sawed_Off_Shotgun_Pellets"
			};
			items[] = {
				"MRP_optic_kobra",
				"optic_Yorris",
				"ALF_C4",
				"ALF_Pc"
			};
		};
	};

	class gend {
        name = "Cargaison de la Gendarmerie Nationale";
        prix = 300000;
        vehicle = "V_ALF_Brinks_GND";
		positions[] = {
			{1579,10073,0},
			{3377,4235,0},
			{8409,951,0}
		};
        class stock {
            weapons[] = {
                "arifle_CTAR_GL_blk_F"
            };
            magazines[] = {
                "20Rnd_762x51_Mag"
            };
            items[] = {
                "bipod_01_F_blk"
            };
        };
	};
};
