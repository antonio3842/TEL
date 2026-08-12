/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/
class ALF_DESEASES {

	ALF_ConfigToClient_Patern[] = {
        {"ANY", "CLASS", {
            {"name", "STRING"},
            {"event_sounds", "ARRAY"},
            {"event_contagion_chance", "NUMBER"},
            {"reduce_fatigue", "NUMBER"},
            {"protect_contamination_air", "ARRAY"}
        }}
    };

	class rhume {
		name = "Rhume";
		event_sounds[] = {"rhume_1","rhume_2"};
		event_contagion_chance = 1;
		reduce_fatigue = 0;
		protect_contamination_air[] = {"ALF_Mask_Samu"};
	};
	class toux {
		name = "Toux";
		event_sounds[] = {"cough_0","cough_1","cough_2"};
		event_contagion_chance = 1;
		reduce_fatigue = 0.20;
		protect_contamination_air[] = {"ALF_Mask_Samu"};
	};
};

class ALF_MEDECINE {

	ALF_ConfigToClient_Patern[] = {
        {"ANY", "CLASS", {
            {"interval", "NUMBER"},
			{"heal", "CLASS", {
				{"max", "NUMBER"},
				{"min", "NUMBER"}
			}}
        }}
    };

	class ALF_Medoc_rhume {
		interval = 300;
		class heal {
			class rhume {
				max = 6;
				min = 1;
			};
		};
	};
	class ALF_Medoc_toux {
		interval = 600;
		class heal {
			class toux {
				max = 6;
				min = 1;
			};
		};
	};
};

class ALF_VACCINS {

	ALF_ConfigToClient_Patern[] = {
        {"ANY", "CLASS", {
            {"time", "NUMBER"},
			{"protect", "CLASS", {
				{"ANY", "CLASS", {}}
			}}
        }}
    };

	class ALF_Prevention_rhume {
		time = 43000;
		class protect {
			class Rhume {};
		};
	};
	class ALF_Prevention_toux {
		time = 35000;
		class protect {
			class Toux {};
		};
	};
};
