/*
    Author: Sharywan & Jean-Baptiste
    Web site: www.the-programmer.com
    Discord: https://discord.the-programmer.com

    Terms of use:
        - This file is forbidden unless you have permission from the author. If you have this file without permission to use it please do not use it and do not share it.
        - If you have permission to use this file, you can use it on your server however it is strictly forbidden to share it.
        - Out of respect for the author please do not delete this information.
*/
class atm_money {
   idd = 7004;
   name = "atm_money";
   movingenable = 0;
   enablesimulation = 1;
   onload = "uiNamespace setVariable [""atm_keyboard"",""""];";
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
       class Button : Life_RscPicture
       {
           idc = 1006;
           text = "";
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
        class montant : Life_RscText
       {
           colorbackground[] = {0,0,0,0};
           colorText[] = {0,0,0,1};
           font= "PuristaBold";
           style = ST_CENTER;
           shadow = 0;
           text = "";
           idc = 45088;
           sizeex = 0.055;
           x = 0.412760416666667 * safezoneW + safezoneX;
           y = 0.415339233038348 * safezoneH + safezoneY;
           w = 0.075 * safezoneW;
           h = 0.04 * safezoneH;
           class Attributes {
              align = "center";
           };
       };
       class PIN9 : Life_RscButtonInvisible_ATM
       {
           onbuttonclick = "[9] call the_programmer_bank_system_fnc_atm_keyboard;";
           tooltip = "9";
           x = 0.440364583333333 * safezoneW + safezoneX;
           y = 0.675516224188791 * safezoneH + safezoneY;
           w = 0.0161458333333333 * safezoneW;
           h = 0.0196656833824973 * safezoneH;
           idc = -1;
       };
       class PIN8 : Life_RscButtonInvisible_ATM
       {
           onbuttonclick = "[8] call the_programmer_bank_system_fnc_atm_keyboard;";
           tooltip = "8";
           x = 0.42421875 * safezoneW + safezoneX;
           y = 0.675516224188791 * safezoneH + safezoneY;
           w = 0.0161458333333333 * safezoneW;
           h = 0.0196656833824973 * safezoneH;
           idc = -1;
       };
       class PIN7 : Life_RscButtonInvisible_ATM
       {
           onbuttonclick = "[7] call the_programmer_bank_system_fnc_atm_keyboard;";
           tooltip = "7";
           x = 0.408333333333333 * safezoneW + safezoneX;
           y = 0.675516224188791 * safezoneH + safezoneY;
           w = 0.0161458333333333 * safezoneW;
           h = 0.0196656833824973 * safezoneH;
           idc = -1;
       };
       class PIN6 : Life_RscButtonInvisible_ATM
       {
           onbuttonclick = "[6] call the_programmer_bank_system_fnc_atm_keyboard;";
           tooltip = "6";
           x = 0.440364583333333 * safezoneW + safezoneX;
           y = 0.658800393313668 * safezoneH + safezoneY;
           w = 0.0161458333333333 * safezoneW;
           h = 0.0196656833824973 * safezoneH;
           idc = -1;
       };
       class PIN5 : Life_RscButtonInvisible_ATM
       {
           onbuttonclick = "[5] call the_programmer_bank_system_fnc_atm_keyboard;";
           tooltip = "5";
           x = 0.42421875 * safezoneW + safezoneX;
           y = 0.658800393313668 * safezoneH + safezoneY;
           w = 0.0161458333333333 * safezoneW;
           h = 0.0196656833824973 * safezoneH;
           idc = 1005;
       };
       class PIN4 : Life_RscButtonInvisible_ATM
       {
           onbuttonclick = "[4] call the_programmer_bank_system_fnc_atm_keyboard;";
           tooltip = "4";
           x = 0.408333333333333 * safezoneW + safezoneX;
           y = 0.658800393313668 * safezoneH + safezoneY;
           w = 0.0161458333333333 * safezoneW;
           h = 0.0196656833824973 * safezoneH;
           idc = -1;
       };
       class PIN3 : Life_RscButtonInvisible_ATM
       {
           onbuttonclick = "[3] call the_programmer_bank_system_fnc_atm_keyboard;";
           tooltip = "3";
           x = 0.440364583333333 * safezoneW + safezoneX;
           y = 0.642084562438545 * safezoneH + safezoneY;
           w = 0.0161458333333333 * safezoneW;
           h = 0.0196656833824973 * safezoneH;
           idc = -1;
       };
       class PIN2 : Life_RscButtonInvisible_ATM
       {
           onbuttonclick = "[2] call the_programmer_bank_system_fnc_atm_keyboard;";
           tooltip = "2";
           x = 0.42421875 * safezoneW + safezoneX;
           y = 0.642084562438545 * safezoneH + safezoneY;
           w = 0.0161458333333333 * safezoneW;
           h = 0.0196656833824973 * safezoneH;
           idc = -1;
       };
       class PIN1 : Life_RscButtonInvisible_ATM
       {
           onbuttonclick = "[1] call the_programmer_bank_system_fnc_atm_keyboard;";
           tooltip = "1";
           x = 0.408333333333333 * safezoneW + safezoneX;
           y = 0.642084562438545 * safezoneH + safezoneY;
           w = 0.0161458333333333 * safezoneW;
           h = 0.0196656833824973 * safezoneH;
           idc = -1;
       };
       class PIN0 : Life_RscButtonInvisible_ATM
       {
           onbuttonclick = "[0] call the_programmer_bank_system_fnc_atm_keyboard;";
           tooltip = "0";
           x = 0.42421875 * safezoneW + safezoneX;
           y = 0.695181907571288 * safezoneH + safezoneY;
           w = 0.0161458333333333 * safezoneW;
           h = 0.0196656833824973 * safezoneH;
           idc = -1;
       };
       class valid_menu : Life_RscButtonInvisible_ATM
       {
           x = 0.344010416666667 * safezoneW + safezoneX;
           y = 0.501474926253687 * safezoneH + safezoneY;
           w = 0.0161458333333333 * safezoneW;
           h = 0.0196656833824973 * safezoneH;
           idc = 1001;
       };
       class valid_clavier : Life_RscButtonInvisible_ATM
       {
           x = 0.460416666666667 * safezoneW + safezoneX;
           y = 0.642084562438545 * safezoneH + safezoneY;
           w = 0.0255208333333333 * safezoneW;
           h = 0.0196656833824973 * safezoneH;
           tooltip = "";
           idc = 2001;
       };
       class cancel_menu : Life_RscButtonInvisible_ATM
       {
           onbuttonclick = "playSound ""bankbip"";closeDialog 0;";
           x = 0.534895833333333 * safezoneW + safezoneX;
           y = 0.498525073746313 * safezoneH + safezoneY;
           w = 0.0138020833333333 * safezoneW;
           h = 0.0196656833824973 * safezoneH;
           idc = 1003;
       };
       class cancel_clavier : Life_RscButtonInvisible_ATM
       {
           onbuttonclick = "playSound ""cancel"";closeDialog 0;";
           x = 0.460416666666667 * safezoneW + safezoneX;
           y = 0.675516224188791 * safezoneH + safezoneY;
           w = 0.0255208333333333 * safezoneW;
           h = 0.0196656833824973 * safezoneH;
           tooltip = "";
           idc = 2003;
       };
       class corrige : Life_RscButtonInvisible_ATM
       {
           onbuttonclick = "[] call the_programmer_bank_system_fnc_atm_keyboard;";
           x = 0.460416666666667 * safezoneW + safezoneX;
           y = 0.658800393313668 * safezoneH + safezoneY;
           w = 0.0255208333333333 * safezoneW;
           h = 0.0196656833824973 * safezoneH;
           tooltip = "";
           idc = 2002;
       };
   };
};