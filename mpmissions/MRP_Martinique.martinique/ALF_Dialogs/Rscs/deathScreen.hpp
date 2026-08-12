/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/
class DeathScreen {
	idd = 7300;
	name = "Life_Death_Screen";
	movingEnable = 0;
	enableSimulation = 1;

	class controlsBackground { };

	class Controls {
		class MedicsOnline: Life_RscText {
			idc = 7304;
			colorBackground[] = {0,0,0,0};
			text = "Pompier en ligne: 1";
			x = 0.005 * safezoneW + safezoneX;
			y = 0.015 * safezoneH + safezoneY;
			w = 0.8;
			h = (1 / 25);
		};

		class MedicsNearby: Life_RscText {
			idc = 7305;
			colorBackground[] = {0,0,0,0};
			text = "A proximite: 0m";
			x = 0.005 * safezoneW + safezoneX;
			y = 0.040 * safezoneH + safezoneY;
			w = 0.8;
			h = (1 / 25);
		};

		class RespawnBtn: Life_RscButtonMenu {
			idc = 7302;
			x = 0.9 * safezoneW + safezoneX;
			y = 0.015 * safezoneH + safezoneY;
			w = (9 / 40);
			h = (1 / 25);
			text = "Réapparaître";
			onButtonClick = " if !(isNull attachedTo player) exitWith {}; closeDialog 0; life_respawned = true; call ALF_fnc_spawnMenu; [name player,getPlayerUID player,""MORT"",""A appuyé sur le bouton respawn""] remoteExec [""ALF_Server_fnc_logIt"",2];";
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.7};
			class Attributes {align = "center";};
		};

		class MedicBtn: Life_RscButtonMenu {
			idc = 7303;
			x = 0.9 * safezoneW + safezoneX;
			y = 0.040 * safezoneH + safezoneY;
			w = (9 / 40);
			h = (1 / 25);
			onButtonClick = "call ALF_fnc_requestMedic;";
			text = "SOS POMPIER";
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.7};
			class Attributes {align = "center";};
		};

		class respawnTime: Life_RscText {
			idc = 7301;
			colorBackground[] = {0,0,0,0.5};
			text = "";
			x = 0.4175 * safezoneW + safezoneX;
			y = 0.7 * safezoneH + safezoneY;
			w = 0.4;
			h = (1 / 25);
		};
	};
};
