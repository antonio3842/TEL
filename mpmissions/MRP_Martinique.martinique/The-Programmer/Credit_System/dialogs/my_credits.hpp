/*
    Author: Yuri Zoko
    Web site: www.the-programmer.com
    Discord: discord.the-programmer.com

    Terms of use:
      - This file is forbidden unless you have permission from the author. If you have this file without permission to use it please do not use it and do not share it.
      - If you have permission to use this file, you can use it on your server however it is strictly forbidden to share it.
      - Out of respect for the author please do not delete this information.
*/
class Credit_System_My_Credits {
   idd = 4610;
   name = "Credit_System_My_Credits";
   movingenable = 0;
   enablesimulation = 1;
   onload = "";
   class controlsBackground
   {
       class Fond : Life_RscPicture
       {
           idc = 4611;
           text = "";
           x = 0.2 * safezoneW + safezoneX;
           y = 0.03 * safezoneH + safezoneY;
           w = 0.6 * safezoneW;
           h = 1.1 * safezoneH;
       };
       class Icon : Life_RscPicture
       {
           idc = 4616;
           text = "";
           x = 0.217708333333334 * safezoneW + safezoneX;
           y = 0.18819696108978 * safezoneH + safezoneY;
           w = 0.0838541666666663 * safezoneW;
           h = 0.122697425208983 * safezoneH;
       };
       class PayIcon : Life_RscPicture
       {
           idc = 4617;
           text = "";
           x = 0.58515625 * safezoneW + safezoneX;
           y = 0.546643675597221 * safezoneH + safezoneY;
           w = 0.103385416666666 * safezoneW;
           h = 0.236182204516955 * safezoneH;
       };
   };
   class controls
   {
       class infoList : Life_RscListBox
       {
           idc = 4612;
           text = "";
           sizeex = 0.035;
           onlbselchanged = "_this spawn credit_system_fnc_lbSelectCredit;";
           colorbackground[] = {0.3,0.3,0.3,1};
           x = 0.250207833333333 * safezoneW + safezoneX;
           y = 0.306996515936969 * safezoneH + safezoneY;
           w = 0.3143755 * safezoneW;
           h = 0.265553436489292 * safezoneH;
       };
       class info : Life_RscStructuredText
       {
           idc = 4613;
           text = "";
           x = 0.250207833333333 * safezoneW + safezoneX;
           y = 0.639061216222412 * safezoneH + safezoneY;
           h = 0.100948298525448 * safezoneH;
           w = 0.233646333333334 * safezoneW;
           shadow = 0;
       };
       class title : Life_RscStructuredText
       {
           idc = 4614;
           text = "";
           x = 0.211979166666667 * safezoneW + safezoneX;
           y = 0.200566133306716 * safezoneH + safezoneY;
           h = 0.0427735431918565 * safezoneH;
           w = 0.577083333333333 * safezoneW;
       };
       class informationsIcon : Life_RscStructuredText
       {
           idc = 4619;
           text = "";
           x = 0.250207833333333 * safezoneW + safezoneX;
           y = 0.576139393960685 * safezoneH + safezoneY;
           h = 0.0335180751163848 * safezoneH;
           w = 0.3143755 * safezoneW;
           shadow = 0;
       };
       class info2 : Life_RscStructuredText
       {
           idc = 4618;
           text = "";
           x = 0.519114333333333 * safezoneW + safezoneX;
           y = 0.639061216222412 * safezoneH + safezoneY;
           h = 0.100948298525448 * safezoneH;
           w = 0.233646333333334 * safezoneW;
           shadow = 0;
       };
       class payTXT : Life_RscStructuredText
       {
           idc = 4621;
           text = "";
           x = 0.584375 * safezoneW + safezoneX;
           y = 0.741632066869218 * safezoneH + safezoneY;
           w = 0.105208333333333 * safezoneW;
           h = 0.0383393888872042 * safezoneH;
           shadow = 0;
       };
       class pay : Life_RscButtonMenuInvisibleCredit
       {
           idc = 4615;
           x = 0.584375 * safezoneW + safezoneX;
           y = 0.726408470294527 * safezoneH + safezoneY;
           w = 0.105208333333333 * safezoneW;
           h = 0.0592718341774039 * safezoneH;
           text = "";
           onbuttonclick = "[] spawn credit_system_fnc_payCredit;";
       };
       class returnTXT : Life_RscStructuredText
       {
           idc = 4620;
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
   };
};