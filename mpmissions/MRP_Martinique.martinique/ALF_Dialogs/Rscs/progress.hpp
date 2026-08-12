/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/
class init_progress {
	name = "init_progress";
	idd = 38300;
	fadein=0;
	duration = 99999999999;
	fadeout=0;
	movingEnable = 0;
	onLoad="uiNamespace setVariable ['init_progress',_this select 0]";
	objects[]={};

	class controlsBackground {
		class background: Life_RscText {
			idc = -1;
			colorBackground[] = {0,0,0,0.7};
			x = 0.38140 * safezoneW + safezoneX;
			y = 0.06 * safezoneH + safezoneY;
			w = 0.65;
			h = 0.05;
		};
		class ProgressBar: Life_RscProgress {
			idc = 38301;
			x = 0.38140 * safezoneW + safezoneX;
			y = 0.06 * safezoneH + safezoneY;
			w = 0.65;
			h = 0.05;
		};
		class ProgressText: Life_RscText {
			idc = 38302;
			text = "";
			x = 0.386 * safezoneW + safezoneX;
			y = 0.0635 * safezoneH + safezoneY;
			w = 0.65;
			h = (1 / 25);
		};
		class PictureInit: RscPicture {
			idc = 38303;
			type = 0;
			style = 48;
			text = "\ALF_headgear\data\1.jpg";
			x = -0.0331563 * safezoneW + safezoneX;
			y = 0.0908 * safezoneH + safezoneY;
			w = 1.05187 * safezoneW;
			h = 0.913 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0, 0, 0, 0.3};
			font = "TahomaB";
			sizeEx = 0;
			lineSpacing = 0;
			fixedWidth = 0;
			shadow = 0;
		};
	};
};

class life_progress {
	name = "life_progress";
	idd = 38200;
	fadein=0;
	duration = 99999999999;
	fadeout=0;
	movingEnable = 0;
	onLoad="uiNamespace setVariable ['life_progress',_this select 0]";
	objects[]={};

	class controlsBackground {
		class background: Life_RscText {
			idc = -1;
			colorBackground[] = {0,0,0,0.7};
			x = 0.38140 * safezoneW + safezoneX;
			y = 0.06 * safezoneH + safezoneY;
			w = 0.65;
			h = 0.05;
		};
		class ProgressBar: Life_RscProgress {
			idc = 38201;
			x = 0.38140 * safezoneW + safezoneX;
			y = 0.06 * safezoneH + safezoneY;
			w = 0.65;
			h = 0.05;
		};

		class ProgressText: Life_RscText {
			idc = 38202;
			text = "Servicing Chopper (50%)...";
			x = 0.386 * safezoneW + safezoneX;
			y = 0.0635 * safezoneH + safezoneY;
			w = 0.65;
			h = (1 / 25);
		};
	};
};

class ALFCamera {
		idd = -1;
		movingEnable = 0;
		enableSimulation = 1;
		enableDisplay = 1;
		onLoad="uiNamespace setVariable [""hcam_ui_disp"", _this select 0];uiNamespace setVariable [""hcam_ctrl_pip"", (_this select 0) displayCtrl 0];";
		duration = 99999999;
		fadein = 0;
		fadeout = 0;
		class controls { 
			class life_RscTitleBackground: Life_RscText {
				colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
				idc = -1;
				x = 0.335 * safezoneW + safezoneX;
				y = 0.335 * safezoneH + safezoneY;
				w = 0.4 * safezoneW;
				h = 0.022 * safezoneH;
			};

			class MainBackground: Life_RscText {
				colorBackground[] = {0,0,0,0.7};
				idc = -1;
				x = 0.335 * safezoneW + safezoneX;
				y = 0.3592 * safezoneH + safezoneY;
				w = 0.4 * safezoneW;
				h = 0.4 * safezoneH;
			};

			class TitreGlobale: Life_RscTitle {
				colorBackground[] = {0,0,0,0};
				idc = -1;
				text = "Caméra discrète";
				x = 0.334322 * safezoneW + safezoneX;
				y = 0.336111 * safezoneH + safezoneY;
				w = 0.4 * safezoneW;
				h = 0.022 * safezoneH;
			};
			
			class RscHcamCam: RscPicture {
				idc = 754723;
				type = 0;
				style = 48;
				text = "";
				x = 0.46927 * safezoneW + safezoneX;
				y = 0.366667 * safezoneH + safezoneY;
				w = 0.261562 * safezoneW;
				h = 0.382778 * safezoneH;
				colorText[] = {1,1,1,1};
				colorBackground[] = {0, 0, 0, 0.3};
				font = "TahomaB";
				sizeEx = 0;
				lineSpacing = 0;
				fixedWidth = 0;
				shadow = 0;
			};
			class HistoriqueListe: Life_RscListBox {
				idc = 754724;
				text = "";
				sizeEx = 0.035;
				x = 0.340104 * safezoneW + safezoneX;
				y = 0.458333 * safezoneH + safezoneY;
				w = 0.1225 * safezoneW;
				h = 0.276296 * safezoneH;
				onLBSelChanged = "[3] call ;";
			};
			class CloseButtonKey: Life_RscButtonMenu {
				idc = -1;
				text = "$STR_Global_Close";
				onButtonClick = "closeDialog 0; ";
				x = 0.334896 * safezoneW + safezoneX;
				y = 0.792259 * safezoneH + safezoneY;
				w = 0.0644531 * safezoneW;
				h = 0.022 * safezoneH;
			};
		};
};

class life_timer {
	name = "life_timer";
	idd = 38300;
	fadeIn = 1;
	duration = 99999999999;
	fadeout = 1;
	movingEnable = 0;
	onLoad = "uiNamespace setVariable['life_timer',_this select 0]";
	objects[] = {};

	class controlsBackground {
		class TimerIcon: life_RscPicture {
			idc = -1;
			text = "\a3\ui_f\data\IGUI\RscTitles\MPProgress\timer_ca.paa";
			x = 0.00499997 * safezoneW + safezoneX;
			y = 0.291 * safezoneH + safezoneY;
			w = 0.04;
			h = 0.045;
		};

		class TimerText: Life_RscText {
			colorBackground[] = {0,0,0,0};
			idc = 38301;
			text = "";
			x = 0.0204688 * safezoneW + safezoneX;
			y = 0.2778 * safezoneH + safezoneY;
			w = 0.09125 * safezoneW;
			h = 0.055 * safezoneH;
		};
	};
};
