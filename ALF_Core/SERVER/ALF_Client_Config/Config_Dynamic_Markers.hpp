/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/
class ALF_DYN_MARKERS {
	ALF_ConfigToClient_Patern[] = {
        {"ANY", "CLASS", {
            {"text", "STRING"},
			{"type", "STRING"},
			{"color", "STRING"},
			{"shape", "STRING"},
			{"size", "NUMBER"},
			{"linked", "STRING"},
			{"destroy", "STRING"},
			{"positions", "STRING"},
			{"distance", "NUMBER"}
        }}
    };

	class dealer_marker {
		text = "Dealer";
		type = "Maels_sell";
		color = "ColorRed";
		shape = "ICON";
		size = 0.55;
		linked = "dealer";
		destroy = "life_service_gendarme && life_coplevel > 5";
		positions = "stands";
		distance = 4;
	};
};

/*
class ALF_MARKERS {
	stands[] = {
		{{12816.6,10365.3,0.00138712}, 180},
		{{14266.6,4511.09,1.32822}, 46},
		{{10136.6,7113.65,7.66853}, 177},
		{{15327,5264.97,0.00172997}, 130},
		{{8423.95,9808.94,0.00144267}, 327},
		{{1769.22,12341.2,0.390674}, 168},
		{{9060.37,14392.7,12.806}, 258},
		{{11933.9,10687,0.126344}, 307},
		{{3196.85,12309.9,12.3149}, 272},
		{{7563.84,6843.2.9,4.799}, 48},
		{{7909.69,8268.72,0.00175}, 232},
		{{3289.71,12969.8,1.55408}, 97},
		{{5325.98,9473.32,3.897}, 156},
		{{7058.87,8391.33,0.00145} 204}
	};
};
