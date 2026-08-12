/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/
/*
class Config_ALF_API {
	class Requests {
		class GET {
			class ALF_API_IsOnline {
				statement = "[true,true, true]";
				condition = "true";
			};

			class ALF_API_getUserInfo {
				statement = "_ret = (_this call ALFCore_Request_R_G_fnc_getUserInfos); _ret";
				condition = "true";
			};

			class ALF_API_isUnderMaintenance {
				statement = "[true, ALF_isUnderMaintenance, true]";
				condition = "true";
			};

			class ALF_API_getUserBan {
				statement = "_ret = (_this call ALFCore_Request_R_G_fnc_getUserBan); _ret";
				condition = "true";
			};
		};
		class POST {
			class ALF_API_toogleMaintenance {
				statement = "_ret = (_this call ALFCore_Request_R_P_fnc_toogleMaintenance); _ret";
				condition = "_ret = ([(_this#1),1] call ALFTools_Server_fnc_isAdmin); _ret";
			};

			class ALF_API_kickPlayer {
				statement = "_ret = (_this call ALFCore_Request_R_P_fnc_kickPlayer); _ret";
				condition = "_ret = ([(_this#1),1] call ALFTools_Server_fnc_isAdmin); _ret";
			};
			class ALF_API_banPlayer {
				statement = "_ret = (_this call ALFCore_Request_R_P_fnc_banPlayer); _ret";
				condition = "_ret = ([(_this#1),1] call ALFTools_Server_fnc_isAdmin); _ret";
			};
		};
	};
};
*/