/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/

class ALF_MetaData {

	ALF_ConfigToClient_Patern[] = {
        {"ANY", "CLASS", {
            {"maxItems", "NUMBER"},
            {"displayName", "STRING"},
            {"allowNoData", "NUMBER"}
        }}
    };

	class ALF_TestMetaData {
		maxItems = 1000;
		displayName = "format['Carte META DATA de : %1', _this getOrDefault ['name', name player]]";
		allowNoData = false;
	};
};