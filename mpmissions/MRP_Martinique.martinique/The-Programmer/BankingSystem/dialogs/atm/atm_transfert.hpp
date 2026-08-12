/*
    Author: Sharywan & Jean-Baptiste
    Web site: www.the-programmer.com
    Discord: https://discord.the-programmer.com

    Terms of use:
        - This file is forbidden unless you have permission from the author. If you have this file without permission to use it please do not use it and do not share it.
        - If you have permission to use this file, you can use it on your server however it is strictly forbidden to share it.
        - Out of respect for the author please do not delete this information.
*/
class atm_transfert {
   idd = 7005;
   name = "atm_transfert";
   movingenable = 0;
   enablesimulation = 1;
   class controlsBackground
   {
       class Life_RscTitleBackground : Life_RscPicture
       {
           text = "";
           idc = 1000;
           x = 0.243854166666667 * safezoneW + safezoneX;
           y = 0.0511307767944936 * safezoneH + safezoneY;
           w = 0.505104166666667 * safezoneW;
           h = 0.928220255653884 * safezoneH;
       };
      class screen : Life_RscPicture
       {
           text = "";
           idc = 2000;
           x = 0.243854166666667 * safezoneW + safezoneX;
           y = 0.0511307767944936 * safezoneH + safezoneY;
           w = 0.505104166666667 * safezoneW;
           h = 0.928220255653884 * safezoneH;
       };
       class logo: Life_RscPicture
        {
            idc = 05052020;
            text = "";
            x = 0.586474 * safezoneW + safezoneX;
            y = 0.289405 * safezoneH + safezoneY;
            w = 0.037825 * safezoneW;
            h = 0.064773 * safezoneH;
        };
   };
   class controls
   {
       class destinataire : Life_RscEdit
       {
           x = 0.435416666666667 * safezoneW + safezoneX;
           y = 0.451976401179941 * safezoneH + safezoneY;
           h = 0.025 * safezoneH;
           w = 0.07 * safezoneW;
           text = "";
           idc = 1001;
       };
       class montant : Life_RscEdit
       {
           x = 0.435416666666667 * safezoneW + safezoneX;
           y = 0.416211897738446 * safezoneH + safezoneY;
           h = 0.025 * safezoneH;
           w = 0.07 * safezoneW;
           text = "";
           idc = 1002;
       };
       class liste_compte : Life_RscCombo
       {
           x = 0.435416666666667 * safezoneW + safezoneX;
           y = 0.380730088495575 * safezoneH + safezoneY;
           w = 0.07 * safezoneW;
           h = 0.022 * safezoneH;
           idc = 1003;
       };
       class cancel_menu : Life_RscButtonInvisible_ATM
       {
           onbuttonclick = "playSound ""bankbip"";closeDialog 0";
           x = 0.534895833333333 * safezoneW + safezoneX;
           y = 0.498525073746313 * safezoneH + safezoneY;
           w = 0.0138020833333333 * safezoneW;
           h = 0.0196656833824973 * safezoneH;
           idc = -1;
       };
      class transfer : Life_RscButtonInvisible_ATM
       {
           onbuttonclick = "playSound ""bankbip""; [] spawn the_programmer_bank_system_fnc_atm_transfert;";
           x = 0.345703125 * safezoneW + safezoneX;
           y = 0.498525073746313 * safezoneH + safezoneY;
           w = 0.0138020833333333 * safezoneW;
           h = 0.0196656833824973 * safezoneH;
           idc = -1;
       };
   };
};
