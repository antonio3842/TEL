/*
    Author: Yuri Zoko
    Web site: www.the-programmer.com
    Discord: discord.the-programmer.com

    Terms of use:
      - This file is forbidden unless you have permission from the author. If you have this file without permission to use it please do not use it and do not share it.
      - If you have permission to use this file, you can use it on your server however it is strictly forbidden to share it.
      - Out of respect for the author please do not delete this information.
*/
class Credit_System_Player_Mouvements {
   idd = 5610;
   name = "Credit_System_Player_Mouvements";
   movingenable = 0;
   enablesimulation = 1;
   onload = "";
   class controlsBackground
   {
       class Fond : Life_RscPicture
       {
           idc = 5611;
           text = "";
           x = 0.2 * safezoneW + safezoneX;
           y = 0.03 * safezoneH + safezoneY;
           w = 0.6 * safezoneW;
           h = 1.1 * safezoneH;
       };
       class Icon : Life_RscPicture
       {
           idc = 5616;
           text = "";
           x = 0.217708333333334 * safezoneW + safezoneX;
           y = 0.18819696108978 * safezoneH + safezoneY;
           w = 0.0838541666666663 * safezoneW;
           h = 0.122697425208983 * safezoneH;
       };
   };
   class controls
   {
       class infoList : Life_RscListBox
       {
           idc = 5612;
           text = "";
           sizeex = 0.035;
           onlbselchanged = "_this spawn credit_system_fnc_lbSelectInfo;";
           colorbackground[] = {0.3,0.3,0.3,1};
           x = 0.250207833333333 * safezoneW + safezoneX;
           y = 0.306996515936969 * safezoneH + safezoneY;
           w = 0.3143755 * safezoneW;
           h = 0.265553436489292 * safezoneH;
       };
       class lastIncident : Life_RscStructuredText
       {
           idc = 5617;
           text = "";
           x = 0.51875 * safezoneW + safezoneX;
           y = 0.620123691722168 * safezoneH + safezoneY;
           h = 0.0972882968601342 * safezoneH;
           w = 0.230729166666667 * safezoneW;
           shadow = 0;
       };
       class lastCredit : Life_RscStructuredText
       {
           idc = 5618;
           text = "";
           x = 0.250207833333333 * safezoneW + safezoneX;
           y = 0.642007611798286 * safezoneH + safezoneY;
           h = 0.0972882968601342 * safezoneH;
           w = 0.2331255 * safezoneW;
           shadow = 0;
       };
       class infoIcon : Life_RscStructuredText
       {
           idc = 5619;
           text = "";
           x = 0.250207833333333 * safezoneW + safezoneX;
           y = 0.576139393960685 * safezoneH + safezoneY;
           h = 0.0335180751163848 * safezoneH;
           w = 0.3143755 * safezoneW;
           shadow = 0;
       };
       class title : Life_RscStructuredText
       {
           idc = 5614;
           text = "";
           x = 0.211979166666667 * safezoneW + safezoneX;
           y = 0.200566133306716 * safezoneH + safezoneY;
           h = 0.0427735431918565 * safezoneH;
           w = 0.577083333333333 * safezoneW;
       };
       class returnTXT : Life_RscStructuredText
       {
           idc = 5620;
           text = "";
           x = 0.607934666666667 * safezoneW + safezoneX;
           y = 0.324123062083496 * safezoneH + safezoneY;
           w = 0.153002833333333 * safezoneW;
           h = 0.0448112861562757 * safezoneH;
           shadow = 0;
       };
       class returnButton : Life_RscButtonMenuInvisibleCredit
       {
           idc = -1;
           x = 0.600643 * safezoneW + safezoneX;
           y = 0.307947990722887 * safezoneH + safezoneY;
           w = 0.153002833333333 * safezoneW;
           h = 0.0781129036634116 * safezoneH;
           text = "";
           onbuttonclick = "closeDialog 2;";
       };
       class amount : Life_RscStructuredText
       {
           idc = 5623;
           text = "";
           x = 0.211979166666667 * safezoneW + safezoneX;
           y = 0.266412940057088 * safezoneH + safezoneY;
           h = 0.0490009514747863 * safezoneH;
           w = 0.577083333333333 * safezoneW;
           shadow = 0;
       };
       class AmountLastCredit : Life_RscStructuredText
       {
           idc = 5624;
           text = "";
           x = 0.600643 * safezoneW + safezoneX;
           y = 0.451712654614652 * safezoneH + safezoneY;
           h = 0.106089438629876 * safezoneH;
           w = 0.153002833333333 * safezoneW;
           shadow = 0;
       };
   };
};