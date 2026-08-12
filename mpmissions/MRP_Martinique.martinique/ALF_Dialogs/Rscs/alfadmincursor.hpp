/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/
class ALF_AdminCursor_Dialog
{
	idd = 44875;
	duration = 1e+012;
	onLoad = "uiNamespace setVariable [""ALF_AdminCursor_Dialog"", _this select 0]";
	class Controls {
		class IGUIBack_2200: IGUIBack
		{
			idc = 2200;
			x = 0.835147 * safezoneW + safezoneX;
			y = 0.22492 * safezoneH + safezoneY;
			w = 0.154683 * safezoneW;
			h = 0.297086 * safezoneH;
		};
		class RscFrame_1800: Life_RscFrame
		{
			idc = 1800;
			x = 0.835147 * safezoneW + safezoneX;
			y = 0.22492 * safezoneH + safezoneY;
			w = 0.154683 * safezoneW;
			h = 0.297086 * safezoneH;
		};
		class RscText_1000: Life_RscText
		{
			idc = 1000;
			text = "Curseur: Non"; 
			x = 0.835147 * safezoneW + safezoneX;
			y = 0.22492 * safezoneH + safezoneY;
			w = 0.154683 * safezoneW;
			h = 0.0440128 * safezoneH;
		};
		class RscFrame_1801: Life_RscFrame
		{
			idc = 1801;
			x = 0.840303 * safezoneW + safezoneX;
			y = 0.268933 * safezoneH + safezoneY;
			w = 0.144371 * safezoneW;
			h = 0.187054 * safezoneH;
		};
		class RscText_1001: Life_RscText
		{
			idc = 1001;
			text = ""; 
			x = 0.835147 * safezoneW + safezoneX;
			y = 0.46699 * safezoneH + safezoneY;
			w = 0.154683 * safezoneW;
			h = 0.0440128 * safezoneH;
		};
		class RscText_1002: Life_RscText
		{
			idc = 1002;
			text = "NUMPAD1: Attacher Curseur"; 
			x = 0.840303 * safezoneW + safezoneX;
			y = 0.290939 * safezoneH + safezoneY;
			w = 0.139215 * safezoneW;
			h = 0.0220064 * safezoneH;
		};
		class RscText_1003: Life_RscText
		{
			idc = 1003;
			text = "NUMPAD1: Attacher Curseur"; 
			x = 0.840303 * safezoneW + safezoneX;
			y = 0.312946 * safezoneH + safezoneY;
			w = 0.139215 * safezoneW;
			h = 0.0220064 * safezoneH;
		};
		class RscText_1004: Life_RscText
		{
			idc = 1004;
			text = "NUMPAD1: Attacher Curseur"; 
			x = 0.840303 * safezoneW + safezoneX;
			y = 0.334952 * safezoneH + safezoneY;
			w = 0.139215 * safezoneW;
			h = 0.0220064 * safezoneH;
		};
		class RscText_1005: Life_RscText
		{
			idc = 1005;
			text = "NUMPAD1: Attacher Curseur"; 
			x = 0.840303 * safezoneW + safezoneX;
			y = 0.356958 * safezoneH + safezoneY;
			w = 0.139215 * safezoneW;
			h = 0.0220064 * safezoneH;
		};
		class RscText_1006: Life_RscText
		{
			idc = 1006;
			text = "NUMPAD1: Attacher Curseur"; 
			x = 0.840303 * safezoneW + safezoneX;
			y = 0.378965 * safezoneH + safezoneY;
			w = 0.139215 * safezoneW;
			h = 0.0220064 * safezoneH;
		};
		class RscText_1007: Life_RscText
		{
			idc = 1007;
			text = "NUMPAD1: Attacher Curseur";
			x = 0.840303 * safezoneW + safezoneX;
			y = 0.400971 * safezoneH + safezoneY;
			w = 0.139215 * safezoneW;
			h = 0.0220064 * safezoneH;
		};
		class RscText_1008: Life_RscText
		{
			idc = 1008;
			text = "F2 pour quitter"; 
			x = 0.840303 * safezoneW + safezoneX;
			y = 0.522006 * safezoneH + safezoneY;
			w = 0.139215 * safezoneW;
			h = 0.0220064 * safezoneH;
			style = ST_CENTER;
		};
	};
};

class Dialog_Dead {
	idd = 268;
	name= "Dialog_Dead";
	movingEnable = false;
	enableSimulation = true;
	class controlsBackground { };
	class Controls { };
};
