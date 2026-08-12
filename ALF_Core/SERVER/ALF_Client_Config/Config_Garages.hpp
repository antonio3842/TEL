/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/
class ALF_GARAGES {

    ALF_ConfigToClient_Patern[] = {
        {"ANY", "CLASS", {
            {"garageSpawnPos", "ARRAY"},
			{"garageSpawnDir", "NUMBER"}
        }}
    };

    class Land_i_Garage_V1_F {
        garageSpawnPos[] = {-11.5,0,0};
        garageSpawnDir = -90;
    };
    class Land_i_Garage_V2_F : Land_i_Garage_V1_F {};
    class Land_Garage : Land_i_Garage_V1_F {
        garageSpawnDir = 180;
    };
	class Land_Garage2 : Land_i_Garage_V1_F {};

	class Land_HouseA {
        garageSpawnPos[] = {4.9,-13,0};
        garageSpawnDir = 45;
    };
	class Land_HouseB : Land_HouseA {};
	class Land_HouseC : Land_HouseA {};
	class Land_HouseD : Land_HouseA {};
	
	class Land_ALF_MaisonMitoyenne {
        garageSpawnPos[] = {-4.95068,-15.459,0.22366};
        garageSpawnDir = 180;
    };
	class Land_ALF_MaisonMitoyenne1 {
        garageSpawnPos[] = {5.82031,-13.9189,0.506723};
        garageSpawnDir = 180;
    };

    class Land_Residence_A_1 {
        garageSpawnPos[] = {4.89844,-2.21545,0.1};
        garageSpawnDir = 180;
    };
    class Land_Residence_A_2 : Land_Residence_A_1 {};
    class Land_Residence_A_3 : Land_Residence_A_1 {};
    class Land_Residence_A_4 : Land_Residence_A_1 {};
	
	class Land_ALF_MaisonContemporaine {
        garageSpawnPos[] = {6.20459,-16.291,-4.7};
        garageSpawnDir = 180;
    };
	
	class Land_ALF_MaisonModerne {
        garageSpawnPos[] = {6.22,-18.47,-4};
        garageSpawnDir = 180;
    };

    class Land_ALF_MaisonModerne_Blanc {
        garageSpawnPos[] = {6.22,-18.47,-4};
        garageSpawnDir = 180;
    };

    class Land_ALF_MaisonModerne_Verte {
        garageSpawnPos[] = {6.22,-18.47,-4};
        garageSpawnDir = 180;
    };

    
};
