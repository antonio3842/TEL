/*
    Author: Yuri Zoko
    Web site: www.the-programmer.com
    Discord: discord.the-programmer.com

    Terms of use:
      - This file is forbidden unless you have permission from the author. If you have this file without permission to use it please do not use it and do not share it.
      - If you have permission to use this file, you can use it on your server however it is strictly forbidden to share it.
      - Out of respect for the author please do not delete this information.
*/
class Credit_System_Index {
   idd = 4510;
   name = "Credit_System_Index";
   movingenable = 0;
   enablesimulation = 1;
   onload = "[(getPlayerUID player)] remoteExec [""Credit_System_fnc_getMouvements"",2];[(getPlayerUID player)] remoteExec [""Credit_System_fnc_getLastCredit"",2];[(getPlayerUID player)] remoteExec [""Credit_System_fnc_getLastIncident"",2];";
   class controlsBackground
   {
       class Fond : Life_RscPicture
       {
           idc = 4511;
           text = "";
           x = 0.2 * safezoneW + safezoneX;
           y = 0.03 * safezoneH + safezoneY;
           w = 0.6 * safezoneW;
           h = 1.1 * safezoneH;
       };
       class Icon : Life_RscPicture
       {
           idc = 4521;
           text = "";
           x = 0.217708333333334 * safezoneW + safezoneX;
           y = 0.18819696108978 * safezoneH + safezoneY;
           w = 0.0838541666666663 * safezoneW;
           h = 0.122697425208983 * safezoneH;
       };
   };
   class controls
   {
       class mouvementList : Life_RscListBox
       {
           idc = 4512;
           text = "";
           sizeex = 0.035;
           onlbselchanged = "";
           colorbackground[] = {0.3,0.3,0.3,1};
           x = 0.250207833333333 * safezoneW + safezoneX;
           y = 0.306996515936969 * safezoneH + safezoneY;
           w = 0.3143755 * safezoneW;
           h = 0.265553436489292 * safezoneH;
       };
       class myCredits : Life_RscStructuredText
       {
           idc = 4513;
           text = "";
           x = 0.629288833333333 * safezoneW + safezoneX;
           y = 0.3329701894623 * safezoneH + safezoneY;
           h = 0.0490009514747863 * safezoneH;
           w = 0.111458333333334 * safezoneW;
       };
       class information : Life_RscStructuredText
       {
           idc = 4514;
           text = "";
           x = 0.629288833333333 * safezoneW + safezoneX;
           y = 0.515653348358589 * safezoneH + safezoneY;
           h = 0.0490009514747863 * safezoneH;
           w = 0.111458333333334 * safezoneW;
       };
       class incidentHistory : Life_RscStructuredText
       {
           idc = 4515;
           text = "";
           x = 0.629288833333333 * safezoneW + safezoneX;
           y = 0.424311768910445 * safezoneH + safezoneY;
           h = 0.0490009514747863 * safezoneH;
           w = 0.111458333333334 * safezoneW;
       };
       class title : Life_RscStructuredText
       {
           idc = 4516;
           text = "";
           x = 0.211979166666667 * safezoneW + safezoneX;
           y = 0.200566133306716 * safezoneH + safezoneY;
           h = 0.0427735431918565 * safezoneH;
           w = 0.577083333333333 * safezoneW;
       };
       class lastCreditTXT : Life_RscStructuredText
       {
           idc = 4517;
           text = "";
           x = 0.51875 * safezoneW + safezoneX;
           y = 0.620123691722168 * safezoneH + safezoneY;
           h = 0.0972882968601342 * safezoneH;
           w = 0.230729166666667 * safezoneW;
           shadow = 0;
       };
       class lastIncidentTXT : Life_RscStructuredText
       {
           idc = 4518;
           text = "";
           x = 0.250207833333333 * safezoneW + safezoneX;
           y = 0.642007611798286 * safezoneH + safezoneY;
           h = 0.0972882968601342 * safezoneH;
           w = 0.2331255 * safezoneW;
           shadow = 0;
       };
       class MyCreditsMenu : Life_RscButtonMenuInvisibleCredit
       {
           idc = 4519;
           x = 0.600643 * safezoneW + safezoneX;
           y = 0.307947990722887 * safezoneH + safezoneY;
           w = 0.153002833333333 * safezoneW;
           h = 0.0781129036634116 * safezoneH;
       };
       class MyIncidentsMenu : Life_RscButtonMenuInvisibleCredit
       {
           idc = 4520;
           x = 0.600643 * safezoneW + safezoneX;
           y = 0.398621949690654 * safezoneH + safezoneY;
           w = 0.153002833333333 * safezoneW;
           h = 0.0781129036634116 * safezoneH;
       };
       class VehicleShop : Life_RscButtonMenuInvisibleCredit
       {
           idc = 4525;
           x = 0.600643 * safezoneW + safezoneX;
           y = 0.490915003924717 * safezoneH + safezoneY;
           w = 0.153002833333333 * safezoneW;
           h = 0.0781129036634116 * safezoneH;
       };
       class infoIcon : Life_RscStructuredText
       {
           idc = 4522;
           text = "";
           x = 0.250207833333333 * safezoneW + safezoneX;
           y = 0.576139393960685 * safezoneH + safezoneY;
           h = 0.0335180751163848 * safezoneH;
           w = 0.3143755 * safezoneW;
           shadow = 0;
       };
       class amount : Life_RscStructuredText
       {
           idc = 4523;
           text = "";
           x = 0.211979166666667 * safezoneW + safezoneX;
           y = 0.266412940057088 * safezoneH + safezoneY;
           h = 0.0490009514747863 * safezoneH;
           w = 0.577083333333333 * safezoneW;
           shadow = 0;
       };
       class BrokerMenu : Life_RscButtonMenuInvisibleCredit
       {
           idc = 4524;
           x = 0.751684666666667 * safezoneW + safezoneX;
           y = 0.245977643247079 * safezoneH + safezoneY;
           w = 0.0373778333333334 * safezoneW;
           h = 0.0696741169812751 * safezoneH;
       };
       class ChangeListTXT : Life_RscStructuredText
       {
           idc = 4526;
           text = "";
           x = 0.353768 * safezoneW + safezoneX;
           y = 0.742388201712654 * safezoneH + safezoneY;
           w = 0.312898666666667 * safezoneW;
           h = 0.044243577545195 * safezoneH;
           shadow = 0;
       };
       class ChangeListToSociety : Life_RscButtonMenuInvisibleCredit
       {
           idc = 4527;
           x = 0.353768 * safezoneW + safezoneX;
           y = 0.732181258851265 * safezoneH + safezoneY;
           w = 0.3134195 * safezoneW;
           h = 0.044243577545195 * safezoneH;
       };
       class ChangeListToMyMouvements : Life_RscButtonMenuInvisibleCredit
       {
           idc = 4528;
           x = 0.353768 * safezoneW + safezoneX;
           y = 0.732181258851265 * safezoneH + safezoneY;
           w = 0.312377833333333 * safezoneW;
           h = 0.0401783986178124 * safezoneH;
       };
   };
};