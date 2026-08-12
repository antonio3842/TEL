/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/
#define ALF_POKER_BG_X (0.319531 * safezoneW + safezoneX)
#define ALF_POKER_BG_Y (0.236 * safezoneH + safezoneY)
#define ALF_POKER_BG_W (0.366094 * safezoneW)
#define ALF_POKER_BG_H (0.594 * safezoneH)

class alfpoker {
	idd = 541618;
	name= "alfpoker";
	movingEnable = false;
	enableSimulation = true;
	onLoad = "uiNamespace setVariable ['ALF_Poker_DialogAnswered', false];";
	onUnload = "if !(uiNamespace getVariable ['ALF_Poker_DialogAnswered', false]) then { missionNamespace setVariable [format ['ALF_Poker%1_CurrentAction', ALF_Current_Partie], ['coucher', -1], true]; };";

	class controlsBackground {
		class BackgroundImage: Life_RscPictureKeepAspect {
			idc = -1;
			text = "\ALF_Client2\textures\interaction\menu_casino.paa";
			x = ALF_POKER_BG_X;
			y = ALF_POKER_BG_Y;
			w = ALF_POKER_BG_W;
			h = ALF_POKER_BG_H;
		};

		class Title: Life_RscTitle {
			colorBackground[] = {0.05,0.05,0.1,0.9};
			idc = -1;
			text = "POKER";
			x = ALF_POKER_BG_X + (ALF_POKER_BG_W * 0.14);
			y = ALF_POKER_BG_Y + (ALF_POKER_BG_H * 0.141);
			w = ALF_POKER_BG_W * 0.72;
			h = ALF_POKER_BG_H * 0.067;
			sizeEx = 0.045;
			colorText[] = {1,1,1,1};
			style = 2;
		};

		class Subtitle: Life_RscText {
			colorBackground[] = {0.05,0.05,0.1,0.85};
			idc = 5416190;
			text = "";
			x = ALF_POKER_BG_X + (ALF_POKER_BG_W * 0.14);
			y = ALF_POKER_BG_Y + (ALF_POKER_BG_H * 0.226);
			w = ALF_POKER_BG_W * 0.72;
			h = ALF_POKER_BG_H * 0.051;
			sizeEx = 0.028;
			colorText[] = {0.8,0.8,0.8,1};
			style = 2;
		};
	};

	class controls {
		class MiseEnCours: Life_RscText
		{
			idc = 5416185;
			text = "";
			x = ALF_POKER_BG_X;
			y = ALF_POKER_BG_Y + (ALF_POKER_BG_H * 0.293);
			w = ALF_POKER_BG_W;
			h = ALF_POKER_BG_H * 0.051;
			colorText[] = {0.95,0.95,0.95,1};
			sizeEx = 0.028;
			style = 2;
		};

		class MiserRelancerEdit: Life_RscEdit
		{
			idc = 5416181;
			text = "";
			x = ALF_POKER_BG_X + (ALF_POKER_BG_W * 0.124);
			y = ALF_POKER_BG_Y + (ALF_POKER_BG_H * 0.360);
			w = ALF_POKER_BG_W * 0.410;
			h = ALF_POKER_BG_H * 0.051;
			colorBackground[] = {0.1,0.1,0.1,0.8};
			sizeEx = 0.032;
		};

		class MiserRelancerButton: Life_RscButtonMenu
		{
			onButtonClick = "uiNamespace setVariable ['ALF_Poker_DialogAnswered', true]; [6] spawn ALF_fnc_playPoker;";
			idc = 5416182;
			text = "Miser";
			x = ALF_POKER_BG_X + (ALF_POKER_BG_W * 0.575);
			y = ALF_POKER_BG_Y + (ALF_POKER_BG_H * 0.352);
			w = ALF_POKER_BG_W * 0.300;
			h = ALF_POKER_BG_H * 0.067;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0.17,0.22,0.30,1};
			sizeEx = 0.036;
		};

		class SuivreButton: Life_RscButtonMenu
		{
			onButtonClick = "uiNamespace setVariable ['ALF_Poker_DialogAnswered', true]; [4] spawn ALF_fnc_playPoker;";
			idc = 5416183;
			text = "Suivre";
			show = 0;
			x = ALF_POKER_BG_X + (ALF_POKER_BG_W * 0.124);
			y = ALF_POKER_BG_Y + (ALF_POKER_BG_H * 0.461);
			w = ALF_POKER_BG_W * 0.355;
			h = ALF_POKER_BG_H * 0.067;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0.17,0.22,0.30,1};
			sizeEx = 0.036;
		};

		class CoucherButton: Life_RscButtonMenu
		{
			onButtonClick = "uiNamespace setVariable ['ALF_Poker_DialogAnswered', true]; [5] spawn ALF_fnc_playPoker;";
			idc = 5416184;
			text = "Se coucher";
			show = 0;
			x = ALF_POKER_BG_X + (ALF_POKER_BG_W * 0.589);
			y = ALF_POKER_BG_Y + (ALF_POKER_BG_H * 0.461);
			w = ALF_POKER_BG_W * 0.273;
			h = ALF_POKER_BG_H * 0.067;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0.17,0.22,0.30,1};
			sizeEx = 0.036;
		};

		class CheckerButton: Life_RscButtonMenu
		{
			onButtonClick = "uiNamespace setVariable ['ALF_Poker_DialogAnswered', true]; [9] spawn ALF_fnc_playPoker;";
			idc = 5416188;
			text = "Checker";
			show = 0;
			x = ALF_POKER_BG_X + (ALF_POKER_BG_W * 0.124);
			y = ALF_POKER_BG_Y + (ALF_POKER_BG_H * 0.461);
			w = ALF_POKER_BG_W * 0.355;
			h = ALF_POKER_BG_H * 0.067;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0.17,0.22,0.30,1};
			sizeEx = 0.036;
		};
	};
};

#undef ALF_POKER_BG_X
#undef ALF_POKER_BG_Y
#undef ALF_POKER_BG_W
#undef ALF_POKER_BG_H
