class ByScream_Incendie_V3_ARI {
   idd = 15652;
   name = "ByScream_Incendie_V3_ARI";
   movingenable = true;
   enablesimulation = true;
   duration = 1e+1000; // Durée infinie (ou très longue)
    fadeIn = 0; // Apparition instantanée
    fadeOut = 0;
    onLoad = "uiNamespace setVariable ['ByScream_Incendie_V3_ARI', _this select 0];";
   class controlsBackground
   {
    class fond : ByScream_RscPicture
       {
           text = "MRP_Incendie\dialogs\mano_without_aiguille.paa";
           x = -0.0645833 * safezoneW + safezoneX;
           y = 0.56028245 * safezoneH + safezoneY;
           w = 0.3 * safezoneW;
           h = 0.5333 * safezoneH;
           idc = -1;
       };
   };
   class controls
   {
       
        class aiguille : ByScream_RscPicture
       {
           text = "MRP_Incendie\dialogs\aiguille.paa";
           x = -0.0645833 * safezoneW + safezoneX;
           y = 0.56028245 * safezoneH + safezoneY;
           w = 0.3 * safezoneW;
           h = 0.5333 * safezoneH;
           idc = 1000;
       };
   };
};