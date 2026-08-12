/*
    Author: Yuri Zoko
    Web site: www.the-programmer.com
    Discord: https://discord.the-programmer.com

    Terms of use:
      - This file is forbidden unless you have permission from the author. If you have this file without permission to use it please do not use it and do not share it.
      - If you have permission to use this file, you can use it on your server however it is strictly forbidden to share it.
      - Out of respect for the author please do not delete this information.
*/
class Advanced_Documents_Create_Document {
   idd = 5540;
   name = "Advanced_Documents_Create_Document";
   movingenable = false;
   enablesimulation = true;
   onload = "[] spawn advanced_documents_tpfn_createDocumentMenu;";
   class controlsBackground
   {
       class Fond : Life_RscPicture
       {
           idc = 5541;
           text = "";
           x = 0.286979166666667 * safezoneW + safezoneX;
           y = 0.110127826941986 * safezoneH + safezoneY;
           w = 0.4296875 * safezoneW;
           h = 0.779744346116028 * safezoneH;
       };
   };
   class controls
   {
       class title : Life_RscStructuredText
       {
           idc = 5545;
           text = "";
           x = 0.3078125 * safezoneW + safezoneX;
           y = 0.264747859181732 * safezoneH + safezoneY;
           h = 0.0528068506184586 * safezoneH;
           w = 0.382291666666667 * safezoneW;
           shadow = 0;
       };
       class text : Life_RscEdit
       {
           idc = 5542;
           text = "";
           x = 0.498958333333333 * safezoneW + safezoneX;
           y = 0.40707958175076 * safezoneH + safezoneY;
           w = 0.161979166666667 * safezoneW;
           h = 0.175024646371167 * safezoneH;
           linespacing = 1;
           style = 0 + 16 + 0x200;
       };
       class selectplayers : Life_RscCombo
       {
           idc = 5543;
           colortext[] = {1,1,1,1};
           colorscrollbar[] = {1,1,1,0};
           colorbackground[] = {0.4,0.4,0.4,0.8};
           colorselectbackground[] = {0.95, 0.95, 0.95, 0.8};
           x = 0.334895833333333 * safezoneW + safezoneX;
           y = 0.483680422745113 * safezoneH + safezoneY;
           w = 0.1203125 * safezoneW;
           h = 0.0251284374779083 * safezoneH;
       };
       class day : Life_RscEdit
       {
           idc = 5544;
           text = "";
           x = 0.334895833333333 * safezoneW + safezoneX;
           y = 0.557925472954072 * safezoneH + safezoneY;
           w = 0.1203125 * safezoneW;
           h = 0.0251284374779083 * safezoneH;
       };
       class typeDocument : Life_RscCombo
       {
           colortext[] = {1,1,1,1};
           colorscrollbar[] = {1,1,1,0};
           colorbackground[] = {0.4,0.4,0.4,0.8};
           colorselectbackground[] = {0.95, 0.95, 0.95, 0.8};
           x = 0.334895833333333 * safezoneW + safezoneX;
           y = 0.409458268715555 * safezoneH + safezoneY;
           w = 0.119270833333334 * safezoneW;
           h = 0.0251284374779083 * safezoneH;
           idc = 5547;
           onlbselchanged = "_this spawn advanced_documents_tpfn_lbChangedCreateDocument;";
       };
       class send : Life_RscButtonInvisibleDocuments
       {
           idc = 5550;
           text = "";
           onbuttonclick = "[] spawn advanced_documents_tpfn_sendDocument;";
           x = 0.578124999999999 * safezoneW + safezoneX;
           y = 0.596935939176717 * safezoneH + safezoneY;
           w = 0.0833333333333337 * safezoneW;
           h = 0.0402640117994102 * safezoneH;
       };
       class type : Life_RscStructuredText
       {
           idc = 5546;
           text = "";
           x = 0.334895833333333 * safezoneW + safezoneX;
           y = 0.384157944814463 * safezoneH + safezoneY;
           h = 0.0271170313986679 * safezoneH;
           w = 0.119791666666667 * safezoneW;
           shadow = 0;
       };
       class player : Life_RscStructuredText
       {
           idc = 5551;
           text = "";
           x = 0.334895833333333 * safezoneW + safezoneX;
           y = 0.456470028544244 * safezoneH + safezoneY;
           h = 0.0271170313986679 * safezoneH;
           w = 0.119791666666667 * safezoneW;
           shadow = 0;
       };
       class validity : Life_RscStructuredText
       {
           idc = 5548;
           text = "";
           x = 0.334895833333333 * safezoneW + safezoneX;
           y = 0.530685061845861 * safezoneH + safezoneY;
           h = 0.0271170313986679 * safezoneH;
           w = 0.1203125 * safezoneW;
           shadow = 0;
       };
       class info : Life_RscStructuredText
       {
           idc = 5549;
           text = "";
           x = 0.498958333333333 * safezoneW + safezoneX;
           y = 0.384157944814463 * safezoneH + safezoneY;
           h = 0.0271170313986679 * safezoneH;
           w = 0.161979166666667 * safezoneW;
           shadow = 0;
       };
   };
};