/*
    Author: Jean-Baptiste
    Web site: www.the-programmer.com
    Discord: https://discord.the-programmer.com

    Terms of use:
        - This file is forbidden unless you have permission from the author. If you have this file without permission to use it please do not use it and do not share it.
        - If you have permission to use this file, you can use it on your server however it is strictly forbidden to share it.
        - Out of respect for the author please do not delete this information.
*/
class The_Programmer_bank_receipt {
   idd = 7008;
   name = "The_Programmer_bank_receipt";
   movingenable = 0;
   enablesimulation = 1;
   onload = "uiNamespace setVariable ['The_Programmer_bank_receipt',_this select 0]";
   duration = 30;
   fadein = 0;
   fadeout = 1;
   class controlsBackground
   {
       class fond : Life_RscPicture
       {
           idc = 999;
           text = "";
           x = -0.0753124000000003 * safezoneW + safezoneX;
           y = -0.0665986234021633 * safezoneH + safezoneY;
           w = 0.35 * safezoneW;
           h = 0.6 * safezoneH;
       };
   };
   class controls
   {
       class total : Life_RscStructuredText
       {
           idc = 1000;
           text = "";
           x = 0.135416666666667 * safezoneW + safezoneX;
           y = 0.283933136676499 * safezoneH + safezoneY;
           w = 0.05 * safezoneW;
           h = 0.017 * safezoneH;
       };
       class city : Life_RscStructuredText
       {
           idc = 1006;
           text = "";
           x = 0.072 * safezoneW + safezoneX;
           y = 0.137 * safezoneH + safezoneY;
           w = 0.065 * safezoneW;
           h = 0.02 * safezoneH;
       };
       class date : Life_RscText
       {
           idc = 1007;
           text = "";
           x = 0.102 * safezoneW + safezoneX;
           y = 0.200016715830875 * safezoneH + safezoneY;
           w = 0.075 * safezoneW;
           h = 0.013 * safezoneH;
           font = "PuristaBold";
           colortext[] = {0,0,0,1};
           sizeex = 0.035;
           shadow = 0;
       };
       class compte : Life_RscText
       {
           idc = 1008;
           text = "";
           x = 0.102 * safezoneW + safezoneX;
           y = 0.230016715830875 * safezoneH + safezoneY;
           w = 0.075 * safezoneW;
           h = 0.013 * safezoneH;
           font = "PuristaBold";
           colortext[] = {0,0,0,1};
           sizeex = 0.035;
           shadow = 0;
       };
       class tax : Life_RscStructuredText
       {
           idc = 1009;
           text = "";
           x = 0.116145833333334 * safezoneW + safezoneX;
           y = 0.305 * safezoneH + safezoneY;
           w = 0.07 * safezoneW;
           h = 0.025 * safezoneH;
       };
       class order : Life_RscText
       {
           idc = 1010;
           text = "";
           x = 0.102 * safezoneW + safezoneX;
           y = 0.185240412979351 * safezoneH + safezoneY;
           w = 0.065 * safezoneW;
           h = 0.013 * safezoneH;
           font = "PuristaBold";
           sizeex = 0.035;
           colortext[] = {0,0,0,1};
           shadow = 0;
       };
       class authorization : Life_RscText
       {
           idc = 1012;
           text = "";
           x = 0.102 * safezoneW + safezoneX;
           y = 0.258986725663717 * safezoneH + safezoneY;
           w = 0.08 * safezoneW;
           h = 0.013 * safezoneH;
           sizeex = 0.035;
           font = "PuristaBold";
           colortext[] = {0,0,0,1};
           shadow = 0;
       };
       class end_date : Life_RscText
       {
           idc = 1011;
           text = "";
           x = 0.102 * safezoneW + safezoneX;
           y = 0.244237463126843 * safezoneH + safezoneY;
           w = 0.065 * safezoneW;
           h = 0.013 * safezoneH;
           font = "PuristaBold";
           sizeex = 0.035;
           colortext[] = {0,0,0,1};
           shadow = 0;
       };
   };
};