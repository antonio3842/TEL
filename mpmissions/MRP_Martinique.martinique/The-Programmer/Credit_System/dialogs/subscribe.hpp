/*
    Author: Yuri Zoko
    Web site: www.the-programmer.com
    Discord: discord.the-programmer.com

    Terms of use:
      - This file is forbidden unless you have permission from the author. If you have this file without permission to use it please do not use it and do not share it.
      - If you have permission to use this file, you can use it on your server however it is strictly forbidden to share it.
      - Out of respect for the author please do not delete this information.
*/
class Credit_System_Subscribe {
   idd = 2040;
   name = "Credit_System_Subscribe";
   movingenable = false;
   enablesimulation = true;
   onload = "";
   class controlsBackground
   {
       class Fond : Life_RscPicture
       {
           idc = 2041;
           text = "";
           x = 0.2 * safezoneW + safezoneX;
           y = 0.03 * safezoneH + safezoneY;
           w = 0.6 * safezoneW;
           h = 1.1 * safezoneH;
       };
       class Icon : Life_RscPicture
       {
           idc = 2053;
           text = "";
           x = 0.217708333333334 * safezoneW + safezoneX;
           y = 0.18819696108978 * safezoneH + safezoneY;
           w = 0.0838541666666663 * safezoneW;
           h = 0.122697425208983 * safezoneH;
       };
   };
   class controls
   {
       class amountTXT : Life_RscStructuredText
       {
           idc = 2042;
           text = "";
           x = 0.419270833333333 * safezoneW + safezoneX;
           y = 0.398905803996194 * safezoneH + safezoneY;
           h = 0.0336917105511711 * safezoneH;
           w = 0.166145833333333 * safezoneW;
           shadow = 0;
       };
       class amount : Life_RscEdit
       {
           idc = 2043;
           text = "";
           x = 0.419270833333333 * safezoneW + safezoneX;
           y = 0.436013320647003 * safezoneH + safezoneY;
           w = 0.166145833333333 * safezoneW;
           h = 0.0336917105511711 * safezoneH;
           style = 0x02;
       };
       class interetTXT : Life_RscStructuredText
       {
           idc = 2044;
           text = "";
           x = 0.419270833333333 * safezoneW + safezoneX;
           y = 0.504519505233112 * safezoneH + safezoneY;
           h = 0.0336917105511711 * safezoneH;
           w = 0.165625 * safezoneW;
           shadow = 0;
       };
       class interet : Life_RscEdit
       {
           idc = 2045;
           text = "";
           x = 0.419270833333333 * safezoneW + safezoneX;
           y = 0.549238820171265 * safezoneH + safezoneY;
           w = 0.166145833333333 * safezoneW;
           h = 0.0336917105511711 * safezoneH;
           style = 0x02;
       };
       class totalTXT : Life_RscStructuredText
       {
           idc = 2046;
           text = "";
           x = 0.4203125 * safezoneW + safezoneX;
           y = 0.612036156041865 * safezoneH + safezoneY;
           h = 0.0336917105511711 * safezoneH;
           w = 0.165625 * safezoneW;
           shadow = 0;
       };
       class total : Life_RscStructuredText
       {
           idc = 2047;
           text = "";
           x = 0.4203125 * safezoneW + safezoneX;
           y = 0.645337773549001 * safezoneH + safezoneY;
           w = 0.165625 * safezoneW;
           h = 0.0336917105511711 * safezoneH;
           shadow = 0;
           style = 0x02;
       };
       class playerTXT : Life_RscStructuredText
       {
           idc = 2049;
           text = "";
           x = 0.419270833333333 * safezoneW + safezoneX;
           y = 0.292383450147821 * safezoneH + safezoneY;
           h = 0.0336917105511711 * safezoneH;
           w = 0.166145833333333 * safezoneW;
           shadow = 0;
       };
       class player : Life_RscCombo
       {
           idc = 2050;
           text = "";
           x = 0.419270833333333 * safezoneW + safezoneX;
           y = 0.32949096679863 * safezoneH + safezoneY;
           w = 0.166145833333333 * safezoneW;
           h = 0.0336917105511711 * safezoneH;
       };
       class title : Life_RscStructuredText
       {
           idc = 2051;
           text = "";
           x = 0.211979166666667 * safezoneW + safezoneX;
           y = 0.200566133306716 * safezoneH + safezoneY;
           h = 0.0427735431918565 * safezoneH;
           w = 0.577083333333333 * safezoneW;
       };
       class interetTotal : Life_RscStructuredText
       {
           idc = 2052;
           text = "";
           x = 0.419270833333333 * safezoneW + safezoneX;
           y = 0.523549000951475 * safezoneH + safezoneY;
           w = 0.166145833333333 * safezoneW;
           h = 0.0336917105511711 * safezoneH;
           shadow = 0;
       };
       class confirmTXT : Life_RscStructuredText
       {
           idc = 2048;
           text = "";
           x = 0.426822916666667 * safezoneW + safezoneX;
           y = 0.74052807431528 * safezoneH + safezoneY;
           h = 0.0346860075115514 * safezoneH;
           w = 0.14765625 * safezoneW;
           shadow = 0;
       };
       class confirm : Life_RscButtonMenuInvisibleCredit
       {
           idc = -1;
           text = "";
           onbuttonclick = "[] spawn credit_system_fnc_checkBlacklist;";
           x = 0.426822916666667 * safezoneW + safezoneX;
           y = 0.727164605137964 * safezoneH + safezoneY;
           w = 0.148958333333333 * safezoneW;
           h = 0.0575642245480494 * safezoneH;
       };
   };
};