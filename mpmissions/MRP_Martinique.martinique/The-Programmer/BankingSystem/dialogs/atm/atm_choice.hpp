/*
    Author: Sharywan & Jean-Baptiste
    Web site: www.the-programmer.com
    Discord: https://discord.the-programmer.com

    Terms of use:
        - This file is forbidden unless you have permission from the author. If you have this file without permission to use it please do not use it and do not share it.
        - If you have permission to use this file, you can use it on your server however it is strictly forbidden to share it.
        - Out of respect for the author please do not delete this information.
*/
class atm_choice {
   idd = 7002;
   name = "atm_choice";
   movingenable = 0;
   enablesimulation = 1;
   onUnload = "uiNamespace setVariable [""time_atm_menu_closed"",time]";

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
       class deposit : Life_RscButtonInvisible_ATM
       {
           onbuttonclick = "playSound ""bankbip"";[0] spawn the_programmer_bank_system_fnc_atm_money;";
           x = 0.344791666666666 * safezoneW + safezoneX;
           y = 0.4031465093412 * safezoneH + safezoneY;
           w = 0.0166666666666673 * safezoneW;
           h = 0.0245821042281217 * safezoneH;
           idc = -1;
       };
       class Situation : Life_RscButtonInvisible_ATM
       {
           onbuttonclick = "playSound ""bankbip"";[] spawn the_programmer_bank_system_fnc_atm_situation";
           x = 0.344791666666666 * safezoneW + safezoneX;
           y = 0.499016715830875 * safezoneH + safezoneY;
           w = 0.0166666666666673 * safezoneW;
           h = 0.0245821042281217 * safezoneH;
           idc = -1;
       };
       class Cancel : Life_RscButtonInvisible_ATM
       {
           onbuttonclick = "playSound ""cancel""; closedialog 0;";
           x = 0.534375 * safezoneW + safezoneX;
           y = 0.496558505408063 * safezoneH + safezoneY;
           w = 0.0166666666666673 * safezoneW;
           h = 0.0245821042281217 * safezoneH;
           idc = -1;
       };
       class gang : Life_RscButtonInvisible_ATM
       {
           onbuttonclick = "playSound ""bankbip""";
           x = 0.534375 * safezoneW + safezoneX;
           y = 0.431661750245821 * safezoneH + safezoneY;
           w = 0.0166666666666673 * safezoneW;
           h = 0.0245821042281217 * safezoneH;
           idc = 1002;
       };
       class withdraw : Life_RscButtonInvisible_ATM
       {
           onbuttonclick = "playSound ""bankbip"";[1] spawn the_programmer_bank_system_fnc_atm_money;";
           x = 0.534375 * safezoneW + safezoneX;
           y = 0.3992133726647 * safezoneH + safezoneY;
           w = 0.0166666666666673 * safezoneW;
           h = 0.0245821042281216 * safezoneH;
           idc = -1;
       };
       class transfert : Life_RscButtonInvisible_ATM
       {
           onbuttonclick = "playSound ""bankbip"";[] spawn the_programmer_bank_system_fnc_atm_transfertMenu";
           x = 0.344791666666666 * safezoneW + safezoneX;
           y = 0.431661750245821 * safezoneH + safezoneY;
           w = 0.0166666666666673 * safezoneW;
           h = 0.0245821042281217 * safezoneH;
           idc = 1001;
       };
   };
};