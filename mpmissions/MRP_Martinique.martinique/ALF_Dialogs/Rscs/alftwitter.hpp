/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/
#define TOCOLOR(r,g,b) {(r / 255), (g / 255), (b / 255), 1}
#define POSITION(X,Y,W,H) \
    x = (X * safeZoneW) / 1920 + safeZoneX; \
    y = (Y * safeZoneH) / 1080 + safeZoneY; \
    w = (W * safeZoneW) / 1920; \
    h = (H * safeZoneH) / 1080
#define POSITION_CT(X,Y,W,H) \
    x = (X * safeZoneW) / 1920; \
    y = (Y * safeZoneH) / 1080; \
    w = (W * safeZoneW) / 1920; \
    h = (H * safeZoneH) / 1080

class alftwitter
{
	idd = 785460;

	class Controls
	{
		class menu_twitter_show : Life_RscPicture
		{
			idc = 785461;
			x = safeZoneX + safeZoneW * 0.44875;
			y = safeZoneY + safeZoneH * 0.24666667;
			w = safeZoneW * 0.454375;
			h = safeZoneH * 0.76666667;
			text = "\ALF_Client2\textures\iPhone\ALF_iphone_13.paa";
		};
		class btn_twitter_write : Life_RscButtonInvisible
		{
			idc = 785462;
			x = safeZoneX + safeZoneW * 0.726875;
			y = safeZoneY + safeZoneH * 0.90444445;
			w = safeZoneW * 0.03375;
			h = safeZoneH * 0.06;
			text = "['Erreur','Cette fonctionalité n'est pas encore disponible','warning'] spawn ALF_fnc_doMsg;";		
		};
		class Body: RscControlsGroup {
            idc = -1;
            POSITION(810,283,300,527);
            class Controls {
                class Background: IGUIBack {
                    idc = -1;
                    POSITION_CT(0,0,300,527);
                    colorBackground[] = TOCOLOR(54,57,63);
                };
                class Messages: RscControlsGroup {
                    idc = 16199;
                    onLoad = "systemChat 'Loading Data...'; call ALF_fnc_twitterLoadMessages";
                    onUnload = "";
                    onMouseZChanged = "_this call ALF_fnc_twitterScroll";
                    POSITION_CT(0,0,300,527);
                };
            };
        };
		class HomeBtn : Life_RscButtonInvisible {
			idc = -1;
			text = "";
			onButtonClick = "uiNamespace setVariable ['iphonemenu',0]; call ALF_fnc_menuiPhone;";
			x = 0.638907 * safezoneW + safezoneX;
			y = 0.963389 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.011 * safezoneH;
		};
	};
	
};
