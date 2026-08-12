/*
    Author: Jean_Park
    Teamspeak 3: ts.the-programmer.com
    Web site: www.the-programmer.com
    Discord : https://discord.gg/DhFUFsq

    Terms of use:
        - This file is forbidden unless you have permission from the author. If you have this file without permission to use it please do not use it and do not share it.
        - If you have permission to use this file, you can use it on your server however it is strictly forbidden to share it.
        - Out of respect for the author please do not delete this information.

    License number:
    Server's name:
    Owner's name:
*/
class Life_Button_Invisible_CBX : Life_RscButtonMenu {
    animTextureNormal = "#(argb,8,8,3)color(1,1,1,0)";
    animTextureDisabled = "#(argb,8,8,3)color(1,1,1,0)";
    animTextureOver = "#(argb,8,8,3)color(1,1,1,0)";
    animTextureFocused = "#(argb,8,8,3)color(1,1,1,0)";
    animTexturePressed = "#(argb,8,8,3)color(1,1,1,0)";
    animTextureDefault = "#(argb,8,8,3)color(1,1,1,0)";
    colorBackground[] = {0, 0, 0, 0};
    colorBackground2[] = {1, 1, 1, 0};
    color[] = {1, 1, 1, 0};
    color2[] = {1, 1, 1, 0};
    colorText[] = {1, 1, 1, 0};
    colorDisabled[] = {1, 1, 1, 0};
};

class CBX_Interaction  {
    idd = 2500;
    onUnload = "[1] spawn CBX_fnc_menuEffects";
    movingEnable = true;
    enableSimulation = true;
    class controls {

		class Logo_pic: life_RscPicture
		{
			idc = 1200;
			moving = 1;	
			text = "";
			x = 0.37625 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.2475 * safezoneW;
			h = 0.44 * safezoneH;
		};

		class Picture_1: life_RscPicture
		{
			idc = 1201;
            moving = 1;	
			text = "";
			x = 0.37625 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.2475 * safezoneW;
			h = 0.44 * safezoneH;
		};
		class Picture_2: life_RscPicture
		{
			idc = 1202;
            moving = 1;	
			text = "";
			x = 0.37625 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.2475 * safezoneW;
			h = 0.44 * safezoneH;
		};
		class Picture_3: life_RscPicture
		{
			idc = 1203;
            moving = 1;	
			text = "";
			x = 0.37625 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.2475 * safezoneW;
			h = 0.44 * safezoneH;
		};
		class Picture_4: life_RscPicture
		{
			idc = 1204;
            moving = 1;	
			text = "";
			x = 0.37625 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.2475 * safezoneW;
			h = 0.44 * safezoneH;
		};
		class Picture_5: life_RscPicture
		{
			idc = 1205;
            moving = 1;	
			text = "";
			x = 0.37625 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.2475 * safezoneW;
			h = 0.44 * safezoneH;
		};
		class Picture_6: life_RscPicture
		{
			idc = 1206;
            moving = 1;	
			text = "";
			x = 0.37625 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.2475 * safezoneW;
			h = 0.44 * safezoneH;
		};
		class Picture_7: life_RscPicture
		{
			idc = 1207;
            moving = 1;	
			text = "";
			x = 0.37625 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.2475 * safezoneW;
			h = 0.44 * safezoneH; 
		};
		class Picture_8: life_RscPicture
		{
			idc = 1208;
            moving = 1;	
			text = "";
			x = 0.37625 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.2475 * safezoneW;
			h = 0.44 * safezoneH;
		};
        class Text_1: Life_RscStructuredText
		{
			idc = 2400;
            moving = 1;	
			text = "";
			x = 0.417501 * safezoneW + safezoneX;
			y = 0.4406 * safezoneH + safezoneY;
			w = 0.0464063 * safezoneW;
			h = 0.0352 * safezoneH;
		};
		class Text_2: Life_RscStructuredText
		{
			idc = 2401;
            moving = 1;	
			text = "";
            x = 0.4505 * safezoneW + safezoneX;
			y = 0.3702 * safezoneH + safezoneY;
			w = 0.0464063 * safezoneW;
			h = 0.0352 * safezoneH;
		};
		class Text_3: Life_RscStructuredText
		{
			idc = 2402;
            moving = 1;	
			text = "";
			x = 0.503094 * safezoneW + safezoneX;
			y = 0.3702 * safezoneH + safezoneY;
			w = 0.0464063 * safezoneW;
			h = 0.0352 * safezoneH;
		};
		class Text_4: Life_RscStructuredText
		{
			idc = 2403;
            moving = 1;	
			text = "";
			x = 0.536094 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.0464063 * safezoneW;
			h = 0.0352 * safezoneH;
		};
		class Text_5: Life_RscStructuredText
		{
			idc = 2404;
            moving = 1;	
			text = "";
			x = 0.536094 * safezoneW + safezoneX;
			y = 0.5198 * safezoneH + safezoneY;
			w = 0.0464063 * safezoneW;
			h = 0.0352 * safezoneH;
		};
		class Text_6: Life_RscStructuredText
		{
			idc = 2405;
            moving = 1;	
			text = "";
			x = 0.503093 * safezoneW + safezoneX;
			y = 0.588 * safezoneH + safezoneY;
			w = 0.0464063 * safezoneW;
			h = 0.0352 * safezoneH;
		};
		class Text_7: Life_RscStructuredText
		{
			idc = 2406;
            moving = 1;	
			text = "";
			x = 0.451531 * safezoneW + safezoneX;
			y = 0.588 * safezoneH + safezoneY;
			w = 0.0464063 * safezoneW;
			h = 0.0352 * safezoneH;
		};
		class Text_8: Life_RscStructuredText
		{
			idc = 2407;
            moving = 1;	
			text = "";
			x = 0.4175 * safezoneW + safezoneX;
			y = 0.522 * safezoneH + safezoneY;
			w = 0.0464063 * safezoneW;
			h = 0.0352 * safezoneH;
		};
        class Button_1: Life_Button_Invisible_CBX
		{
			idc = 2600;
            moving = 1;	
			x = 0.422656 * safezoneW + safezoneX;
			y = 0.434 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.055 * safezoneH;
		};
		class Button_2: Life_Button_Invisible_CBX
		{
			idc = 2601;
            moving = 1;	
			x = 0.45875 * safezoneW + safezoneX;
			y = 0.368 * safezoneH + safezoneY;
			w = 0.0391876 * safezoneW;
			h = 0.0528 * safezoneH;
		};
		class Button_3: Life_Button_Invisible_CBX
		{
			idc = 2602;
            moving = 1;	
			x = 0.505156 * safezoneW + safezoneX;
			y = 0.368 * safezoneH + safezoneY;
			w = 0.0402188 * safezoneW;
			h = 0.055 * safezoneH;
		};
		class Button_4: Life_Button_Invisible_CBX
		{
			idc = 2603;
            moving = 1;	
			x = 0.54125 * safezoneW + safezoneX;
			y = 0.434 * safezoneH + safezoneY;
			w = 0.0402188 * safezoneW;
			h = 0.055 * safezoneH;
		};
		class Button_5: Life_Button_Invisible_CBX
		{
			idc = 2604;
            moving = 1;	
			x = 0.54125 * safezoneW + safezoneX;
			y = 0.511 * safezoneH + safezoneY;
			w = 0.0402188 * safezoneW;
			h = 0.055 * safezoneH;
		};
		class Button_6: Life_Button_Invisible_CBX
		{
			idc = 2605;
            moving = 1;	
			x = 0.505156 * safezoneW + safezoneX;
			y = 0.577 * safezoneH + safezoneY;
			w = 0.0402188 * safezoneW;
			h = 0.055 * safezoneH;
		};
		class Button_7: Life_Button_Invisible_CBX
		{
			idc = 2606;
            moving = 1;	
			x = 0.454626 * safezoneW + safezoneX;
			y = 0.5792 * safezoneH + safezoneY;
			w = 0.0402188 * safezoneW;
			h = 0.055 * safezoneH;
		};
		class Button_8: Life_Button_Invisible_CBX
		{
			idc = 2607;
            moving = 1;	
			x = 0.422656 * safezoneW + safezoneX;
			y = 0.511 * safezoneH + safezoneY;
			w = 0.0391876 * safezoneW;
			h = 0.0528 * safezoneH;
		};
    };
};