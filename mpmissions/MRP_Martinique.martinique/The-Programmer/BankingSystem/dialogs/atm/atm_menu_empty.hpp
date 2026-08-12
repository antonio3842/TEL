/*
    Author: Robert
    Web site: www.the-programmer.com
    Discord: https://discord.the-programmer.com

    Terms of use:
        - This file is forbidden unless you have permission from the author. If you have this file without permission to use it please do not use it and do not share it.
        - If you have permission to use this file, you can use it on your server however it is strictly forbidden to share it.
        - Out of respect for the author please do not delete this information.
*/
class atm_empty {
   idd = 7000;
   name = "atm_empty";
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
       class Card : Life_RscButtonInvisible_ATM
       {
           onbuttonclick = "[1] spawn the_programmer_bank_system_fnc_atm_main;";
           x = 0.491666666666666 * safezoneW + safezoneX;
           y = 0.578171091445428 * safezoneH + safezoneY;
           w = 0.0614583333333336 * safezoneW;
           h = 0.0521140609636185 * safezoneH;
           idc = 2001;
           tooltip = "Inserer carte";
       };
       class Close : Life_RscButtonInvisible_ATM
       {
           onbuttonclick = "closeDialog 0;";
           x = 0.460416666666667 * safezoneW + safezoneX;
           y = 0.675516224188791 * safezoneH + safezoneY;
           w = 0.0255208333333333 * safezoneW;
           h = 0.0196656833824973 * safezoneH;
       };
   };
};