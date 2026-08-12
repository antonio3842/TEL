/*
    Author: Sharywan & Jean-Baptiste
    Web site: www.the-programmer.com
    Discord: https://discord.the-programmer.com

    Terms of use:
        - This file is forbidden unless you have permission from the author. If you have this file without permission to use it please do not use it and do not share it.
        - If you have permission to use this file, you can use it on your server however it is strictly forbidden to share it.
        - Out of respect for the author please do not delete this information.
*/
class atm_loading {
   idd = 7009;
   name = "atm_loading";
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
       class progress : Life_RscProgress
       {
           w = 0.1 * safezoneW;
           h = 0.0238495575221236 * safezoneH;
           idc = 1001;
           x = 0.398 * safezoneW + safezoneX;
           y = 0.445 * safezoneH + safezoneY;
           colorBar[] = {0,0.22,0.514,1};
           class Attributes {align = "center";};
       };
       class text : Life_RscText
       {
           w = 0.1 * safezoneW;
           h = 0.0238495575221236 * safezoneH;
           idc = 1002;
           x = 0.398 * safezoneW + safezoneX;
           y = 0.445 * safezoneH + safezoneY;
           colorbackground[] = {0,0,0,0};
           colorText[] = {0,0,0,1};
       };
   };
};