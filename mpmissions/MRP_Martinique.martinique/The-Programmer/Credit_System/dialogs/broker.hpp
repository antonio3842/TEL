/*
    Author: Yuri Zoko
    Web site: www.the-programmer.com
    Discord: discord.the-programmer.com

    Terms of use:
      - This file is forbidden unless you have permission from the author. If you have this file without permission to use it please do not use it and do not share it.
      - If you have permission to use this file, you can use it on your server however it is strictly forbidden to share it.
      - Out of respect for the author please do not delete this information.
*/
class Credit_System_Broker_Menu {
   idd = 6040;
   name = "Credit_System_Broker_Menu";
   movingenable = false;
   enablesimulation = true;
   onload = "";
   class controlsBackground
   {
       class Fond : Life_RscPicture
       {
           idc = 6041;
           text = "";
           x = 0.2 * safezoneW + safezoneX;
           y = 0.03 * safezoneH + safezoneY;
           w = 0.6 * safezoneW;
           h = 1.1 * safezoneH;
       };
       class Icon : Life_RscPicture
       {
           idc = 6042;
           text = "";
           x = 0.217708333333334 * safezoneW + safezoneX;
           y = 0.18819696108978 * safezoneH + safezoneY;
           w = 0.0838541666666663 * safezoneW;
           h = 0.122697425208983 * safezoneH;
       };
   };
   class controls
   {
       class playerTXT : Life_RscStructuredText
       {
           idc = 6046;
           text = "";
           x = 0.419270833333333 * safezoneW + safezoneX;
           y = 0.315218845009857 * safezoneH + safezoneY;
           h = 0.0336917105511711 * safezoneH;
           w = 0.166145833333333 * safezoneW;
           shadow = 0;
       };
       class deleteTXT : Life_RscStructuredText
       {
           idc = 6049;
           text = "";
           x = 0.3859375 * safezoneW + safezoneX;
           y = 0.539269746006355 * safezoneH + safezoneY;
           w = 0.2328125 * safezoneW;
           h = 0.058018550853778 * safezoneH;
           shadow = 0;
       };
       class creditTXT : Life_RscStructuredText
       {
           idc = 6050;
           text = "";
           x = 0.3859375 * safezoneW + safezoneX;
           y = 0.647737871601027 * safezoneH + safezoneY;
           w = 0.2328125 * safezoneW;
           h = 0.058018550853778 * safezoneH;
           shadow = 0;
       };
       class mouvementTXT : Life_RscStructuredText
       {
           idc = 6051;
           text = "";
           x = 0.3859375 * safezoneW + safezoneX;
           y = 0.43270456998352 * safezoneH + safezoneY;
           w = 0.2328125 * safezoneW;
           h = 0.058018550853778 * safezoneH;
           shadow = 0;
       };
       class player : Life_RscCombo
       {
           idc = 6047;
           colorText[] = {0,0,0,1};
           text = "";
           x = 0.419270833333333 * safezoneW + safezoneX;
           y = 0.351374886874748 * safezoneH + safezoneY;
           w = 0.166145833333333 * safezoneW;
           h = 0.0336917105511711 * safezoneH;
       };
       class title : Life_RscStructuredText
       {
           idc = 6048;
           text = "";
           x = 0.211979166666667 * safezoneW + safezoneX;
           y = 0.200566133306716 * safezoneH + safezoneY;
           h = 0.0427735431918565 * safezoneH;
           w = 0.577083333333333 * safezoneW;
       };
       class delete : Life_RscButtonMenuInvisibleCredit
       {
           idc = 6043;
           text = "";
           onbuttonclick = "[] spawn credit_system_fnc_deleteCredit;";
           x = 0.3859375 * safezoneW + safezoneX;
           y = 0.509774027642892 * safezoneH + safezoneY;
           w = 0.2328125 * safezoneW;
           h = 0.101289242525823 * safezoneH;
       };
       class credit : Life_RscButtonMenuInvisibleCredit
       {
           idc = 6044;
           text = "";
           x = 0.3859375 * safezoneW + safezoneX;
           y = 0.616339203665728 * safezoneH + safezoneY;
           w = 0.2328125 * safezoneW;
           h = 0.101289242525823 * safezoneH;
       };
       class mouvements : Life_RscButtonMenuInvisibleCredit
       {
           idc = 6045;
           text = "";
           x = 0.3859375 * safezoneW + safezoneX;
           y = 0.40275452531433 * safezoneH + safezoneY;
           w = 0.2328125 * safezoneW;
           h = 0.101289242525823 * safezoneH;
       };
   };
};