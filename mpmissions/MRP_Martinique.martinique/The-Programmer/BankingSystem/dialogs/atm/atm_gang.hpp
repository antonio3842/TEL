/*
    Author: Sharywan & Jean-Baptiste
    Web site: www.the-programmer.com
    Discord: https://discord.the-programmer.com

    Terms of use:
        - This file is forbidden unless you have permission from the author. If you have this file without permission to use it please do not use it and do not share it.
        - If you have permission to use this file, you can use it on your server however it is strictly forbidden to share it.
        - Out of respect for the author please do not delete this information.
*/
class atm_gang {
   idd = 7007;
   name = "atm_gang";
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
       class close : Life_RscButtonInvisible_ATM
       {
           onbuttonclick = "playSound ""bankbip"";closeDialog 0";
           x = 0.460416666666667 * safezoneW + safezoneX;
           y = 0.675516224188791 * safezoneH + safezoneY;
           w = 0.0255208333333333 * safezoneW;
           h = 0.0196656833824973 * safezoneH;
           idc = 2001;
           tooltip = "";
       };
      class close_clavier : Life_RscButtonInvisible_ATM
       {
           onbuttonclick = "playSound ""bankbip"";closeDialog 0";
           x = 0.53203125 * safezoneW + safezoneX;
           y = 0.494591937069813 * safezoneH + safezoneY;
           w = 0.0192708333333333 * safezoneW;
           h = 0.0275319567354966 * safezoneH;
       };
       class edit_depose : Life_RscEdit
       {
           idc = 1001;
           text = "0";
           x = 0.3734375 * safezoneW + safezoneX;
           y = 0.40117994100295 * safezoneH + safezoneY;
           w = 0.085416666666667 * safezoneW;
           h = 0.0226155358898722 * safezoneH;
       };
       class edit_retire : Life_RscEdit
       {
           idc = 1002;
           text = "0";
           x = 0.3734375 * safezoneW + safezoneX;
           y = 0.466076696165192 * safezoneH + safezoneY;
           w = 0.085416666666667 * safezoneW;
           h = 0.0226155358898722 * safezoneH;
       };
       class retire : Life_RscButtonInvisible_ATM
       {
           onbuttonclick = "playSound ""bankbip"";[false] spawn the_programmer_bank_system_fnc_atm_gangMoney";
           x = 0.53203125 * safezoneW + safezoneX;
           y = 0.462143559488692 * safezoneH + safezoneY;
           w = 0.0192708333333333 * safezoneW;
           h = 0.0285152409046214 * safezoneH;
           idc = 3568;
       };
       class depose : Life_RscButtonInvisible_ATM
       {
           onbuttonclick = "playSound ""bankbip"";[true] spawn the_programmer_bank_system_fnc_atm_gangMoney";
           x = 0.53203125 * safezoneW + safezoneX;
           y = 0.39724680432645 * safezoneH + safezoneY;
           w = 0.0192708333333333 * safezoneW;
           h = 0.0275319567354966 * safezoneH;
       };
   };
};