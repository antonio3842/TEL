/*
    Author: Robert
    Web site: www.the-programmer.com
    Discord: https://discord.the-programmer.com

    Terms of use:
        - This file is forbidden unless you have permission from the author. If you have this file without permission to use it please do not use it and do not share it.
        - If you have permission to use this file, you can use it on your server however it is strictly forbidden to share it.
        - Out of respect for the author please do not delete this information.
*/
class atm_card {
   idd = 7001;
   name = "atm_card";
   movingenable = 0;
   enablesimulation = 1;
   onload = "uiNamespace setVariable [""atm_keyboard_login"",""""];";

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
       class pin_invisible : Life_RscStructuredText
       {
           colorbackground[] = {0,0,0,0};
           colorText[] = {0,0,0,1};
           shadow = 0;
           idc = 45088;
           sizeex = 0.055;
           x = 0.42421875 * safezoneW + safezoneX;
           y = 0.449754178957719 * safezoneH + safezoneY;
           w = 0.0565104166666667 * safezoneW;
           h = 0.05 * safezoneH;
           class Attributes {align = "center";};
       };
       class PIN9 : Life_RscButtonInvisible_ATM
       {
           onbuttonclick = "[9] call the_programmer_bank_system_fnc_atm_Pin;";
           x = 0.440364583333333 * safezoneW + safezoneX;
           y = 0.675516224188791 * safezoneH + safezoneY;
           w = 0.0161458333333333 * safezoneW;
           h = 0.0196656833824973 * safezoneH;
           tooltip = "9";
           idc = -1;
       };
       class PIN8 : Life_RscButtonInvisible_ATM
       {
           onbuttonclick = "[8] call the_programmer_bank_system_fnc_atm_Pin;";
           x = 0.42421875 * safezoneW + safezoneX;
           y = 0.675516224188791 * safezoneH + safezoneY;
           w = 0.0161458333333333 * safezoneW;
           h = 0.0196656833824973 * safezoneH;
           tooltip = "8";
           idc = -1;
       };
      class PIN7 : Life_RscButtonInvisible_ATM
       {
           onbuttonclick = "[7] call the_programmer_bank_system_fnc_atm_Pin;";
           x = 0.408333333333333 * safezoneW + safezoneX;
           y = 0.675516224188791 * safezoneH + safezoneY;
           w = 0.0161458333333333 * safezoneW;
           h = 0.0196656833824973 * safezoneH;
           tooltip = "7";
           idc = -1;
       };
       class PIN6 : Life_RscButtonInvisible_ATM
       {
           onbuttonclick = "[6] call the_programmer_bank_system_fnc_atm_Pin;";
           x = 0.440364583333333 * safezoneW + safezoneX;
           y = 0.658800393313668 * safezoneH + safezoneY;
           w = 0.0161458333333333 * safezoneW;
           h = 0.0196656833824973 * safezoneH;
           tooltip = "6";
           idc = -1;
       };
       class PIN5 : Life_RscButtonInvisible_ATM
       {
           onbuttonclick = "[5] call the_programmer_bank_system_fnc_atm_Pin;";
           x = 0.42421875 * safezoneW + safezoneX;
           y = 0.658800393313668 * safezoneH + safezoneY;
           w = 0.0161458333333333 * safezoneW;
           h = 0.0196656833824973 * safezoneH;
           tooltip = "5";
           idc = 1005;
       };
       class PIN4 : Life_RscButtonInvisible_ATM
       {
           onbuttonclick = "[4] call the_programmer_bank_system_fnc_atm_Pin;";
           x = 0.408333333333333 * safezoneW + safezoneX;
           y = 0.658800393313668 * safezoneH + safezoneY;
           w = 0.0161458333333333 * safezoneW;
           h = 0.0196656833824973 * safezoneH;
           tooltip = "4";
           idc = -1;
       };
       class PIN3 : Life_RscButtonInvisible_ATM
       {
           onbuttonclick = "[3] call the_programmer_bank_system_fnc_atm_Pin;";
           x = 0.440364583333333 * safezoneW + safezoneX;
           y = 0.642084562438545 * safezoneH + safezoneY;
           w = 0.0161458333333333 * safezoneW;
           h = 0.0196656833824973 * safezoneH;
           tooltip = "3";
           idc = -1;
       };
       class PIN2 : Life_RscButtonInvisible_ATM
       {
           onbuttonclick = "[2] call the_programmer_bank_system_fnc_atm_Pin;";
           x = 0.42421875 * safezoneW + safezoneX;
           y = 0.642084562438545 * safezoneH + safezoneY;
           w = 0.0161458333333333 * safezoneW;
           h = 0.0196656833824973 * safezoneH;
           tooltip = "2";
           idc = -1;
       };
       class PIN1 : Life_RscButtonInvisible_ATM
       {
           onbuttonclick = "[1] call the_programmer_bank_system_fnc_atm_Pin;";
           x = 0.408333333333333 * safezoneW + safezoneX;
           y = 0.642084562438545 * safezoneH + safezoneY;
           w = 0.0161458333333333 * safezoneW;
           h = 0.0196656833824973 * safezoneH;
           tooltip = "1";
           idc = -1;
       };
       class PIN0 : Life_RscButtonInvisible_ATM
       {
           onbuttonclick = "[0] call the_programmer_bank_system_fnc_atm_Pin;";
           x = 0.42421875 * safezoneW + safezoneX;
           y = 0.695181907571288 * safezoneH + safezoneY;
           w = 0.0161458333333333 * safezoneW;
           h = 0.0196656833824973 * safezoneH;
           tooltip = "0";
           idc = 1003;
       };
       class Valid : Life_RscButtonInvisible_ATM
       {
           onbuttonclick = "[-2] call the_programmer_bank_system_fnc_atm_Pin;";
           x = 0.460416666666667 * safezoneW + safezoneX;
           y = 0.642084562438545 * safezoneH + safezoneY;
           w = 0.0255208333333333 * safezoneW;
           h = 0.0196656833824973 * safezoneH;
           tooltip = ""; 
           idc = 2001;
       };
       class cancel : Life_RscButtonInvisible_ATM
       {
           onbuttonclick = "playSound ""cancel""; [-3] call the_programmer_bank_system_fnc_atm_Pin;";
           x = 0.460416666666667 * safezoneW + safezoneX;
           y = 0.675516224188791 * safezoneH + safezoneY;
           w = 0.0255208333333333 * safezoneW;
           h = 0.0196656833824973 * safezoneH;
           tooltip = "";
           idc = 2003;
       };
       class Corrige : Life_RscButtonInvisible_ATM
       {
           onbuttonclick = "[-1] call the_programmer_bank_system_fnc_atm_Pin;";
           x = 0.460416666666667 * safezoneW + safezoneX;
           y = 0.658800393313668 * safezoneH + safezoneY;
           w = 0.0255208333333333 * safezoneW;
           h = 0.0196656833824973 * safezoneH;
           tooltip = "";
           idc = 2002;
       };
   };
};
