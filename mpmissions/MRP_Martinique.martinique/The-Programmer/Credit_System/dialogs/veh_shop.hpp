/*
    Author: Yuri Zoko
    Web site: www.the-programmer.com
    Discord: discord.the-programmer.com

    Terms of use:
      - This file is forbidden unless you have permission from the author. If you have this file without permission to use it please do not use it and do not share it.
      - If you have permission to use this file, you can use it on your server however it is strictly forbidden to share it.
      - Out of respect for the author please do not delete this information.
*/
class Credit_System_Shop {
   idd = 2300;
   name = "Credit_System_Shop";
   movingenable = 0;
   enablesimulation = 1;
   onload = "";
   class controlsBackground
   {
       class Fond : Life_RscPicture
       {
           idc = 2305;
           text = "";
           x = 0.2 * safezoneW + safezoneX;
           y = 0.03 * safezoneH + safezoneY;
           w = 0.6 * safezoneW;
           h = 1.1 * safezoneH;
       };
       class Icon : Life_RscPicture
       {
           idc = 2306;
           text = "";
           x = 0.217708333333334 * safezoneW + safezoneX;
           y = 0.18819696108978 * safezoneH + safezoneY;
           w = 0.0838541666666663 * safezoneW;
           h = 0.122697425208983 * safezoneH;
       };
   };
   class controls
   {
       class VehicleList : Life_RscListBox
       {
           idc = 2302;
           text = "";
           sizeex = 0.04;
           colorbackground[] = {0.3,0.3,0.3,1};
           onlbselchanged = "_this call credit_system_fnc_vehicleShopLBChange";
           x = 0.251041666666667 * safezoneW + safezoneX;
           y = 0.309611798287345 * safezoneH + safezoneY;
           w = 0.310395833333333 * safezoneW;
           h = 0.256277830637488 * safezoneH;
       };
       class ColorList : Life_RscCombo
       {
           idc = 2304;
           colorbackground[] = {0.3,0.3,0.3,1};
           x = 0.283333333333334 * safezoneW + safezoneX;
           y = 0.622074215033301 * safezoneH + safezoneY;
           w = 0.232291666666667 * safezoneW;
           h = 0.0418173168411043 * safezoneH;
       };
       class vehicleInfomationList : Life_RscStructuredText
       {
           idc = 2303;
           text = "";
           sizeex = 0.035;
           x = 0.606770833333334 * safezoneW + safezoneX;
           y = 0.340865842055185 * safezoneH + safezoneY;
           w = 0.185 * safezoneW;
           h = 0.256277830637488 * safezoneH;
           shadow = 0;
       };
       class buyTXT : Life_RscStructuredText
       {
           idc = 2311;
           text = "";
           x = 0.606770833333334 * safezoneW + safezoneX;
           y = 0.7058039961941 * safezoneH + safezoneY;
           w = 0.146875 * safezoneW;
           h = 0.0560894386298771 * safezoneH;
       };
       class BuyCar : Life_RscButtonMenuInvisibleCredit
       {
           idc = 2309;
           text = "";
           onbuttonclick = "[true] spawn credit_system_fnc_vehicleShopBuy;";
           x = 0.606770833333334 * safezoneW + safezoneX;
           y = 0.692483349191245 * safezoneH + safezoneY;
           w = 0.146875 * safezoneW;
           h = 0.0560894386298771 * safezoneH;
       };
       class title : Life_RscStructuredText
       {
           idc = 2301;
           text = "";
           x = 0.211979166666667 * safezoneW + safezoneX;
           y = 0.200566133306716 * safezoneH + safezoneY;
           h = 0.0427735431918565 * safezoneH;
           w = 0.577083333333333 * safezoneW;
       };
   };
};