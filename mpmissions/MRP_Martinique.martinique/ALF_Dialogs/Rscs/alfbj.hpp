/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/
#define ALF_BJ_BG_X (0.319531 * safezoneW + safezoneX)
#define ALF_BJ_BG_Y (0.236 * safezoneH + safezoneY)
#define ALF_BJ_BG_W (0.366094 * safezoneW)
#define ALF_BJ_BG_H (0.594 * safezoneH)

class alfbj {
	idd = 541619;
	name= "alfbj";
	movingEnable = false;
	enableSimulation = true;
	onLoad = "uiNamespace setVariable ['ALF_BJ_DialogAnswered', false]; uiNamespace setVariable ['ALF_BJ_Phase', ''];";
	onUnload = "if (uiNamespace getVariable ['ALF_BJ_Phase',''] isEqualTo 'action' && {!(uiNamespace getVariable ['ALF_BJ_DialogAnswered', false])}) then { [3, ALF_Current_Table, player, 'rester'] remoteExec ['ALF_Server_fnc_playBJ', 2]; }; if (uiNamespace getVariable ['ALF_BJ_Phase',''] isEqualTo 'croupier' && {!(uiNamespace getVariable ['ALF_BJ_DialogAnswered', false])}) then { if !(isNil 'ALF_BJ_CroupierTable') then { private _s = uiNamespace getVariable ['ALF_BJ_CroupierScore', 17]; private _a = if (_s < 17) then {'tirer'} else {'rester'}; ALF_BJ_CroupierTable setVariable ['ALF_BJ_CroupierAction', _a, true]; }; };";

	class controlsBackground {
		// Image de fond casino, alignee sur le cadre du menu interaction
		class BackgroundImage: Life_RscPictureKeepAspect {
			idc = -1;
			text = "\ALF_Client2\textures\interaction\menu_casino.paa";
			x = ALF_BJ_BG_X;
			y = ALF_BJ_BG_Y;
			w = ALF_BJ_BG_W;
			h = ALF_BJ_BG_H;
		};

		// Titre principal
		class Title: Life_RscTitle {
			colorBackground[] = {0.05,0.05,0.1,0.9};
			idc = -1;
			text = "BLACKJACK";
			x = ALF_BJ_BG_X + (ALF_BJ_BG_W * 0.14);
			y = ALF_BJ_BG_Y + (ALF_BJ_BG_H * 0.141);
			w = ALF_BJ_BG_W * 0.72;
			h = ALF_BJ_BG_H * 0.067;
			sizeEx = 0.045;
			colorText[] = {1,1,1,1};
			style = 2;
		};

		// Sous-titre (change selon la phase)
		class Subtitle: Life_RscText {
			colorBackground[] = {0.05,0.05,0.1,0.85};
			idc = 5416180;
			text = "";
			x = ALF_BJ_BG_X + (ALF_BJ_BG_W * 0.14);
			y = ALF_BJ_BG_Y + (ALF_BJ_BG_H * 0.226);
			w = ALF_BJ_BG_W * 0.72;
			h = ALF_BJ_BG_H * 0.051;
			sizeEx = 0.028;
			colorText[] = {0.8,0.8,0.8,1};
			style = 2;
		};
	};

	class controls {
		// ========== PHASE MISE ==========
		class MiserRelancerEdit: Life_RscEdit
		{
			idc = 5416181;
			text = "";
			x = ALF_BJ_BG_X + (ALF_BJ_BG_W * 0.247);
			y = ALF_BJ_BG_Y + (ALF_BJ_BG_H * 0.327);
			w = ALF_BJ_BG_W * 0.492;
			h = ALF_BJ_BG_H * 0.051;
			colorBackground[] = {0.1,0.1,0.1,0.8};
			sizeEx = 0.032;
		};

		class MiserButton: Life_RscButtonMenu
		{
			onButtonClick = "uiNamespace setVariable ['ALF_BJ_DialogAnswered', true]; [2] spawn ALF_fnc_playBJ;";
			idc = 5416182;
			text = "Miser";
			x = ALF_BJ_BG_X + (ALF_BJ_BG_W * 0.329);
			y = ALF_BJ_BG_Y + (ALF_BJ_BG_H * 0.403);
			w = ALF_BJ_BG_W * 0.328;
			h = ALF_BJ_BG_H * 0.067;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0.17,0.22,0.30,1};
			sizeEx = 0.036;
		};

		// ========== PHASE ACTION ==========
		class TirerButton: Life_RscButtonMenu
		{
			onButtonClick = "uiNamespace setVariable ['ALF_BJ_DialogAnswered', true]; [3, ALF_Current_Table, player, 'tirer'] remoteExec ['ALF_Server_fnc_playBJ', 2]; closeDialog 0;";
			idc = 5416183;
			text = "Tirer";
			show = 0;
			x = ALF_BJ_BG_X + (ALF_BJ_BG_W * 0.138);
			y = ALF_BJ_BG_Y + (ALF_BJ_BG_H * 0.360);
			w = ALF_BJ_BG_W * 0.232;
			h = ALF_BJ_BG_H * 0.076;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0.17,0.22,0.30,1};
			sizeEx = 0.034;
		};

		class ResterButton: Life_RscButtonMenu
		{
			onButtonClick = "uiNamespace setVariable ['ALF_BJ_DialogAnswered', true]; [3, ALF_Current_Table, player, 'rester'] remoteExec ['ALF_Server_fnc_playBJ', 2]; closeDialog 0;";
			idc = 5416184;
			text = "Rester";
			show = 0;
			x = ALF_BJ_BG_X + (ALF_BJ_BG_W * 0.384);
			y = ALF_BJ_BG_Y + (ALF_BJ_BG_H * 0.360);
			w = ALF_BJ_BG_W * 0.232;
			h = ALF_BJ_BG_H * 0.076;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0.17,0.22,0.30,1};
			sizeEx = 0.034;
		};

		class DoublerButton: Life_RscButtonMenu
		{
			onButtonClick = "uiNamespace setVariable ['ALF_BJ_DialogAnswered', true]; [5] spawn ALF_fnc_playBJ;";
			idc = 5416185;
			text = "Doubler";
			show = 0;
			x = ALF_BJ_BG_X + (ALF_BJ_BG_W * 0.630);
			y = ALF_BJ_BG_Y + (ALF_BJ_BG_H * 0.360);
			w = ALF_BJ_BG_W * 0.232;
			h = ALF_BJ_BG_H * 0.076;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0.17,0.22,0.30,1};
			sizeEx = 0.034;
		};

		// ========== PHASE REJOUER ==========
		class RejouerButton: Life_RscButtonMenu
		{
			onButtonClick = "uiNamespace setVariable ['ALF_BJ_DialogAnswered', true]; closeDialog 0; [0] spawn ALF_fnc_playBJ;";
			idc = 5416186;
			text = "Rejouer";
			show = 0;
			x = ALF_BJ_BG_X + (ALF_BJ_BG_W * 0.193);
			y = ALF_BJ_BG_Y + (ALF_BJ_BG_H * 0.360);
			w = ALF_BJ_BG_W * 0.273;
			h = ALF_BJ_BG_H * 0.076;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0.17,0.22,0.30,1};
			sizeEx = 0.034;
		};

		class QuitterButton: Life_RscButtonMenu
		{
			onButtonClick = "uiNamespace setVariable ['ALF_BJ_DialogAnswered', true]; closeDialog 0;";
			idc = 5416187;
			text = "Quitter";
			show = 0;
			x = ALF_BJ_BG_X + (ALF_BJ_BG_W * 0.521);
			y = ALF_BJ_BG_Y + (ALF_BJ_BG_H * 0.360);
			w = ALF_BJ_BG_W * 0.273;
			h = ALF_BJ_BG_H * 0.076;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0.17,0.22,0.30,1};
			sizeEx = 0.034;
		};
	};
};

#undef ALF_BJ_BG_X
#undef ALF_BJ_BG_Y
#undef ALF_BJ_BG_W
#undef ALF_BJ_BG_H
