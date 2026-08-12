/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/
class ALF_dirPc
{
	idd = 7529001;
	movingEnable = 0;
  	enableSimulation = 1;
  	onload = "uiNamespace setVariable ['alf_dir_menu',0]";
	onUnload = "{deleteMarkerLocal _x;} forEach ALF_MarkerTempDir";

	
	class ControlsBackground
	{
		
	};
	class Controls
	{
		class background: Life_RscPicture
		{
			type = 0;
			idc = 1486301;
			x = safeZoneX + safeZoneW * 0.219375;
			y = safeZoneY + safeZoneH * 0.12666667;
			w = safeZoneW * 0.561875;
			h = safeZoneH * 0.71888889;
			style = 0+48;
			text = "";
			colorBackground[] = {1,1,1,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class btnFeux: Life_RscButtonMenu
		{
			idc = 1486302;
			x = safeZoneX + safeZoneW * 0.34625;
			y = safeZoneY + safeZoneH * 0.31111112;
			w = safeZoneW * 0.020625;
			h = safeZoneH * 0.03666667;
			text = "";
		};
		class btnCentrale: Life_RscButtonMenu
		{
			idc = 1486303;
			x = safeZoneX + safeZoneW * 0.34625;
			y = safeZoneY + safeZoneH * 0.36;
			w = safeZoneW * 0.020625;
			h = safeZoneH * 0.03666667;
			text = "";
		};
		class mapInfo: Life_RscStructuredText
		{
			idc = 1486304;
			x = safeZoneX + safeZoneW * 0.55125;
			y = safeZoneY + safeZoneH * 0.34555556;
			w = safeZoneW * 0.094375;
			h = safeZoneH * 0.18111112;
			text = "";			
		};
		class mapView: Life_RscMapControl
		{
			idc = 1486305;
			x = safeZoneX + safeZoneW * 0.350625;
			y = safeZoneY + safeZoneH * 0.33888889;
			w = safeZoneW * 0.163125;
			h = safeZoneH * 0.31333334;
			text = "";
		};
		class closeWindows: Life_RscButtonMenu
		{
			idc = 1486306;
			x = safeZoneX + safeZoneW * 0.649375;
			y = safeZoneY + safeZoneH * 0.3;
			w = safeZoneW * 0.01;
			h = safeZoneH * 0.01777778;
			text = "";
		};		
	};	
};
