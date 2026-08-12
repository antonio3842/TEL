/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/
class ALF_CfgTraitements {
	ALF_ConfigToClient_Patern[] = {
        {"ANY", "CLASS", {
			{"duration", "NUMBER"},
			{"displayText", "STRING"},
			{"itemRequired", "ARRAY"},
			{"itemGiven", "ARRAY"},
			{"condition", "STRING"}
        }},
		{"keys","ARRAY"}
    };

	keys[] = {
		{200, "\MRPV2_Texture\asset\arrow\UpArrow.paa"}, // Up
		{203, "\MRPV2_Texture\asset\arrow\LeftArrow.paa"}, // Left
		{205, "\MRPV2_Texture\asset\arrow\RightArrow.paa"}, // Right
		{208, "\MRPV2_Texture\asset\arrow\DownArrow.paa"}
	};	


	class traitement_test {
		duration = 15;
		displayText = "Fabrication de cigarettes";
		itemRequired[] = { {"FirstAidKit",1} };
		itemGiven[]= { {"plp_bo_w_AfterSun",2} };
	};
};
