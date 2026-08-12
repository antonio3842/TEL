/////////////////////////////////////////////////////////////////
/////////// This File was Edited by GUI D3V by Shinji ///////////
/////////////////////////////////////////////////////////////////
class alfgofast_revendeur {
   idd = 8201;
   name = "alfgofast_revendeur";
   movingenable = 0;
   enablesimulation = 1;
   onload = "";
   class controlsBackground
   {
       class Gestion : Life_RscText
       {
           colorbackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
           idc = -1;
           x = 0.1;
           y = 0.2;
           w = 0.6;
           h = (1 / 25);
       };
       class MainBackground : Life_RscText
       {
           colorbackground[] = {0, 0, 0, 0.7};
           idc = -1;
           x = 0.1;
           y = 0.2 + (11 / 250);
           w = 0.6;
           h = 0.6 - (22 / 250);
       };
       class Title : Life_RscTitle
       {
           colorbackground[] = {0, 0, 0, 0};
           idc = -1;
           text = "Sélectionner le véhicule contenant la drogue";
           x = 0.1;
           y = 0.2;
           w = 0.6;
           h = (1 / 25);
       };
   };
   class controls
   {
       class GangMemberList : Life_RscListBox
       {
           idc = 1000;
           text = "";
           sizeex = 0.035;
           x = 0.11;
           y = 0.26;
           w = 0.350;
           h = 0.370;
       };
       class Close : Life_RscButtonMenu
       {
           text = "Fermer";
           onbuttonclick = "closeDialog 0;";
           x = -0.06 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
           y = 0.8 - (1 / 25);
           w = (6.25 / 40);
           h = (1 / 25);
           idc = 1000;
       };
       class Remplir : Life_RscButtonMenu
       {
           text = "Vider";
           colorbackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
           onbuttonclick = "[] spawn ALF_fnc_gofastVider";
           x = 0.47;
           y = 0.26;
           w = (9 / 40);
           h = (1 / 25);
           idc = 1001;
       };
   };
};
/////////////////////////////////////////////////////////////////
////////////////////////// FILE END /////////////////////////////
/////////////////////////////////////////////////////////////////
