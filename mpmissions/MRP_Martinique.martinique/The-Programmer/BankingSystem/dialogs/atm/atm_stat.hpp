/*
    Author: Sharywan & Jean-Baptiste
    Web site: www.the-programmer.com
    Discord: https://discord.the-programmer.com

    Terms of use:
        - This file is forbidden unless you have permission from the author. If you have this file without permission to use it please do not use it and do not share it.
        - If you have permission to use this file, you can use it on your server however it is strictly forbidden to share it.
        - Out of respect for the author please do not delete this information.
*/
class atm_stat {
   idd = 7003;
   name = "atm_stat";
   movingenable = 0;
   enablesimulation = 1;
   class controlsBackground
   {
       class Life_RscTitleBackground : Life_RscPicture
       {
           text = "";
           idc = 1000;
           x = 0.243854166666667 * safezoneW + safezoneX;
           y = 0.0511307767944936 * safezoneH + safezoneY;
           w = 0.505104166666667 * safezoneW;
           h = 0.928220255653884 * safezoneH;
       };
       class screen : Life_RscPicture
       {
           text = "";
           idc = 2000;
           x = 0.243854166666667 * safezoneW + safezoneX;
           y = 0.0511307767944936 * safezoneH + safezoneY;
           w = 0.505104166666667 * safezoneW;
           h = 0.928220255653884 * safezoneH;
       };
       class logo: Life_RscPicture
        {
            idc = 05052020;
            text = "";
            x = 0.586474 * safezoneW + safezoneX;
            y = 0.289405 * safezoneH + safezoneY;
            w = 0.037825 * safezoneW;
            h = 0.064773 * safezoneH;
        };
   };
   class controls
   {
       class Close : Life_RscButtonInvisible_ATM
       {
           onbuttonclick = "playSound ""bankbip"";closeDialog 0";
           x = 0.460416666666667 * safezoneW + safezoneX;
           y = 0.675516224188791 * safezoneH + safezoneY;
           w = 0.0255208333333333 * safezoneW;
           h = 0.0196656833824973 * safezoneH;
           tooltip = "Annuler";
           idc = 1000;
       };
       class cancel_menu : Life_RscButtonInvisible_ATM
       {
           onbuttonclick = "playSound ""bankbip"";closeDialog 0";
           x = 0.534895833333333 * safezoneW + safezoneX;
           y = 0.498525073746313 * safezoneH + safezoneY;
           w = 0.0138020833333333 * safezoneW;
           h = 0.0196656833824973 * safezoneH;
           idc = -1;
       };
       class CPP : Life_RscStructuredText
       {
           idc = 2016;
           sizeex = 0.020;
           shadow = 0;
           x = 0.403125 * safezoneW + safezoneX;
           y = 0.407653757097091 * safezoneH + safezoneY;
           w = 0.11875 * safezoneW;
           h = 0.0195673549655845 * safezoneH;
       };
       class livret_A : Life_RscStructuredText
       {
           idc = 2015;
           sizeex = 0.020;
           shadow = 0;
           x = 0.413020833333333 * safezoneW + safezoneX;
           y = 0.431139975259302 * safezoneH + safezoneY;
           w = 0.11875 * safezoneW;
           h = 0.0195673549655845 * safezoneH;
       };
       class livret_B : Life_RscStructuredText
       {
           idc = 2014;
           sizeex = 0.020;
           shadow = 0;
           x = 0.413020833333333 * safezoneW + safezoneX;
           y = 0.445899810744231 * safezoneH + safezoneY;
           w = 0.11875 * safezoneW;
           h = 0.0195673549655845 * safezoneH;
       };
       class livret_C : Life_RscStructuredText
       {
           idc = 2013;
           sizeex = 0.020;
           shadow = 0;
           x = 0.413020833333333 * safezoneW + safezoneX;
           y = 0.461505482073567 * safezoneH + safezoneY;
           w = 0.11875 * safezoneW;
           h = 0.0195673549655845 * safezoneH;
       };
   };
};