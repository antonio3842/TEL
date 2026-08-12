/*
    Author: Robert
    Web site: www.the-programmer.com
    Discord: https://discord.the-programmer.com

    Terms of use:
        - This file is forbidden unless you have permission from the author. If you have this file without permission to use it please do not use it and do not share it.
        - If you have permission to use this file, you can use it on your server however it is strictly forbidden to share it.
        - Out of respect for the author please do not delete this information.
*/
class terminal_1 {
    idd = 14256;
    name = "terminal_1";
    movingEnable = false;
    enableSimulation = true;

    class controlsBackground {
        class Picturebox_1100: Life_RscPicture
        {
            idc = 1100;
            text = "";
            x = 0.269664 * safezoneW + safezoneX;
            y = 0.072457 * safezoneH + safezoneY;
            w = 0.429255 * safezoneW;
            h = 0.767251 * safezoneH;
        };
    };
    class controls {
        class CANCEL: Life_RscButtonInvisible_Bank
        {
            idc = 1110;
            x = 0.427399 * safezoneW + safezoneX;
            y = 0.651936 * safezoneH + safezoneY;
            w = 0.030472 * safezoneW;
            h = 0.026876 * safezoneH;
            OnButtonClick = "closeDialog 0;";
        };
        class inserez_enter_wait: Life_RscStructuredText
        {
            idc = 1114;
           x = 0.421636 * safezoneW + safezoneX;
            y = 0.358111 * safezoneH + safezoneY;
            w = 0.117495 * safezoneW;
            h = 0.029055 * safezoneH;
        };
        class prix_code: Life_RscStructuredText
        {
            idc = 1115;
            x = 0.422223 * safezoneW + safezoneX;
            y = 0.395884 * safezoneH + safezoneY;
            w = 0.116128 * safezoneW;
            h = 0.029055 * safezoneH;
            font = PuristaBold;
        };
        
        class Inserer_Carte: Life_RscButtonInvisible_Bank
        {
            idc = 1123;
            x = 0.420074 * safezoneW + safezoneX;
            y = 0.688710 * safezoneH + safezoneY;
            w = 0.118570 * safezoneW;
            h = 0.025332 * safezoneH;
            OnButtonClick = "closeDialog 0; [1] spawn the_programmer_bank_system_fnc_terminal_open;";
        };
    };
};