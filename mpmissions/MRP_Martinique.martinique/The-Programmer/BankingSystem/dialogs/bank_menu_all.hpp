/*
    Author: Robert
    Web site: www.the-programmer.com
    Discord: https://discord.the-programmer.com

    Terms of use:
        - This file is forbidden unless you have permission from the author. If you have this file without permission to use it please do not use it and do not share it.
        - If you have permission to use this file, you can use it on your server however it is strictly forbidden to share it.
        - Out of respect for the author please do not delete this information.
*/
class Bank_Menu_all {
   idd = 1645;
   name = "Bank_Menu_all";
   movingenable = false;
   enablesimulation = true;
   onload = "[] spawn the_programmer_bank_system_fnc_bankUpdateLivret;";
   onUnload = "uiNamespace setVariable [""time_bank_menu_closed"",time]";
   class controlsBackground
   {
       class Fond : Life_RscPicture
       {
           idc = 1102;
           text = "";
           x = 0.155298 * safezoneW + safezoneX;
           y = -0.12069 * safezoneH + safezoneY;
           w = 0.693224 * safezoneW;
           h = 1.3061 * safezoneH;
       };
   };
   class controls {
       class Bank_Money_top : Life_RscStructuredText
       {
           idc = 1108;
           text = "ALED";
           style = 0;
           x = 0.507900 * safezoneW + safezoneX;
           y = 0.204098 * safezoneH + safezoneY;
           w = 0.083347 * safezoneW;
           h = 0.02459 * safezoneH;
           colorbackground[] = {1,1,1,0};
           colortext[] = {0.470588,0.972549,0,1};
       };
        class Titulaire : Life_RscStructuredText
       {
           idc = 1109;
           text = "";
           x = 0.385939166666667 * safezoneW + safezoneX;
           y = 0.202299852507375 * safezoneH + safezoneY;
           w = 0.076184 * safezoneW;
           h = 0.01918 * safezoneH;
           colorbackground[] = {1,1,1,0};
           colortext[] = {1,1,1,1};
       };
       class Numero_Compte_A : Life_RscStructuredText
       {
           idc = 1132;
           text = "";
           x = 0.394604 * safezoneW + safezoneX;
           y = 0.394672 * safezoneH + safezoneY;
           w = 0.057172 * safezoneW;
           h = 0.021639 * safezoneH;
           colorbackground[] = {1,1,1,0};
           colortext[] = {1,1,1,1};
       };
       class Plafond_A : Life_RscStructuredText
       {
           idc = 1646;
           x = 0.364583333333333 * safezoneW + safezoneX;
           y = 0.520566440511308 * safezoneH + safezoneY;
           h = 0.0243829891838742 * safezoneH;
           w = 0.065625 * safezoneW;
       };
       class Withdraw_A : Life_RscButtonInvisible_Bank
       {
           idc = 1112;
           text = "";
           onbuttonclick = "[""A""] call the_programmer_bank_system_fnc_bankWithdrawLivret;";
           x = 0.352698 * safezoneW + safezoneX;
           y = 0.584996125860373 * safezoneH + safezoneY;
           w = 0.032197833333333 * safezoneW;
           h = 0.0266066273353004 * safezoneH;
       };
       class Deposit_A : Life_RscButtonInvisible_Bank
       {
           idc = 1113;
           text = "";
           onbuttonclick = "[""A""] call the_programmer_bank_system_fnc_bankDeposit;";
           x = 0.410112833333334 * safezoneW + safezoneX;
           y = 0.584996125860373 * safezoneH + safezoneY;
           w = 0.0320746666666664 * safezoneW;
           h = 0.0266066273353004 * safezoneH;
       };
       class Edit_1114 : Life_RscEdit
       {
           idc = 8653;
           text = "";
           x = 0.361260333333333 * safezoneW + safezoneX;
           y = 0.554994115044248 * safezoneH + safezoneY;
           w = 0.068241 * safezoneW;
           h = 0.025081 * safezoneH;
           colorbackground[] = {1,1,1,0};
           colortext[] = {1,1,1,1};
       };
       class Interest_A : Life_RscStructuredText
       {
           idc = 1111;
           text = "";
           x = 0.3651675 * safezoneW + safezoneX;
           y = 0.438198010816126 * safezoneH + safezoneY;
           w = 0.061989 * safezoneW;
           h = 0.022131 * safezoneH;
       };
       class Capital_A : Life_RscStructuredText
       {
           idc = 984;
           text = "";
           x = 0.364176 * safezoneW + safezoneX;
           y = 0.478776230088496 * safezoneH + safezoneY;
           w = 0.06251 * safezoneW;
           h = 0.023114 * safezoneH;
       };
       class Numero_B : Life_RscStructuredText
       {
           idc = 1114;
           text = "";
           x = 0.537072 * safezoneW + safezoneX;
           y = 0.394672 * safezoneH + safezoneY;
           w = 0.06251 * safezoneW;
           h = 0.021147 * safezoneH;
           colorbackground[] = {1,1,1,0};
           colortext[] = {1,1,1,1};
       };
       class Interet_B : Life_RscStructuredText
       {
           idc = 1115;
           text = "";
           x = 0.5079 * safezoneW + safezoneX;
           y = 0.438198010816126 * safezoneH + safezoneY;
           w = 0.06251 * safezoneW;
           h = 0.022622 * safezoneH;
           colorbackground[] = {1,1,1,0};
           colortext[] = {1,1,1,1};
       };
       class Capital_B : Life_RscStructuredText
       {
           idc = 988;
           text = "";
           x = 0.5079 * safezoneW + safezoneX;
           y = 0.478776230088496 * safezoneH + safezoneY;
           w = 0.06251 * safezoneW;
           h = 0.021639 * safezoneH;
           colorbackground[] = {1,1,1,0};
           colortext[] = {1,1,1,1};
       };
       class Edit_B : Life_RscEdit
       {
           idc = 1117;
           text = "";
           x = 0.5024305 * safezoneW + safezoneX;
           y = 0.554994115044248 * safezoneH + safezoneY;
           w = 0.068241 * safezoneW;
           h = 0.025081 * safezoneH;
           colorbackground[] = {1,1,1,0};
           colortext[] = {1,1,1,1};
       };
       class Retirer_B : Life_RscButtonInvisible_Bank
       {
           idc = 1118;
           text = "";
           onbuttonclick = "[""B""] call the_programmer_bank_system_fnc_bankWithdrawLivret;";
           x = 0.495397833333333 * safezoneW + safezoneX;
           y = 0.584996125860373 * safezoneH + safezoneY;
           w = 0.0322063333333337 * safezoneW;
           h = 0.0266066273353004 * safezoneH;
       };
       class Deposit_B : Life_RscButtonInvisible_Bank
       {
           idc = 1119;
           text = "";
           onbuttonclick = "[""B""] call the_programmer_bank_system_fnc_bankDeposit;";
           x = 0.552083333333333 * safezoneW + safezoneX;
           y = 0.584996125860373 * safezoneH + safezoneY;
           w = 0.0322916666666667 * safezoneW;
           h = 0.0266066273353004 * safezoneH;
       };
        class Plafond_B : Life_RscStructuredText
       {
           idc = 1647;
           x = 0.5079 * safezoneW + safezoneX;
           y = 0.520566440511308 * safezoneH + safezoneY;
           h = 0.0243829891838742 * safezoneH;
           w = 0.0656250000000001 * safezoneW;
       };
       class Numero_C : Life_RscStructuredText
       {
           idc = 1127;
           text = "";
           x = 0.681108 * safezoneW + safezoneX;
           y = 0.394672 * safezoneH + safezoneY;
           w = 0.061989 * safezoneW;
           h = 0.023114 * safezoneH;
           colorbackground[] = {1,1,1,0};
           colortext[] = {1,1,1,1};
       };
       class Interet_C : Life_RscStructuredText
       {
           idc = 1128;
           text = "";
           x = 0.652196 * safezoneW + safezoneX;
           y = 0.438198010816126 * safezoneH + safezoneY;
           w = 0.06251 * safezoneW;
           h = 0.023114 * safezoneH;
           colorbackground[] = {1,1,1,0};
           colortext[] = {1,1,1,1};
       };
       class capital_c : Life_RscStructuredText
       {
           idc = 1126;
           text = "";
           x = 0.652196 * safezoneW + safezoneX;
           y = 0.478776230088496 * safezoneH + safezoneY;
           w = 0.06251 * safezoneW;
           h = 0.022622 * safezoneH;
           colorbackground[] = {1,1,1,0};
           colortext[] = {1,1,1,1};
       };
       class Edit_C : Life_RscEdit
       {
           idc = 1121;
           text = "";
           x = 0.646987666666666 * safezoneW + safezoneX;
           y = 0.554994115044248 * safezoneH + safezoneY;
           w = 0.068241 * safezoneW;
           h = 0.025081 * safezoneH;
           colorbackground[] = {1,1,1,0};
           colortext[] = {1,1,1,1};
       };
       class Retirer_C : Life_RscButtonInvisible_Bank
       {
           idc = 1122;
           text = "";
           onbuttonclick = "[""C""] call the_programmer_bank_system_fnc_bankWithdrawLivret;";
           x = 0.638131166666667 * safezoneW + safezoneX;
           y = 0.584996125860373 * safezoneH + safezoneY;
           w = 0.0321813333333334 * safezoneW;
           h = 0.0266066273353004 * safezoneH;
       };
       class Deposer_C : Life_RscButtonInvisible_Bank
       {
           idc = 1129;
           text = "";
           x = 0.695171833333334 * safezoneW + safezoneX;
           y = 0.584996125860373 * safezoneH + safezoneY;
           w = 0.0329531666666664 * safezoneW;
           h = 0.026557 * safezoneH;
           onbuttonclick = "[""C""] call the_programmer_bank_system_fnc_bankDeposit;";
       };
       class Plafond_C : Life_RscStructuredText
       {
           idc = 1648;
           x = 0.652196 * safezoneW + safezoneX;
           y = 0.520566440511308 * safezoneH + safezoneY;
           h = 0.0243829891838742 * safezoneH;
           w = 0.0656250000000001 * safezoneW;
       };
       class Liquide: Life_RscStructuredText
        {
            idc = 985;
            text = "";
            x = 0.253755 * safezoneW + safezoneX;
            y = 0.382622 * safezoneH + safezoneY;
            w = 0.070 * safezoneW;
            h = 0.019672 * safezoneH;
            ColorText[] = {1,1,1,1};
        };
        class ArmaBank : Life_RscStructuredText
       {
           idc = 1000;
           x = 0.253755 * safezoneW + safezoneX;
           y = 0.278468534906588 * safezoneH + safezoneY;
           w = 0.070 * safezoneW;
           h = 0.019672 * safezoneH;
       };
       class Synthese : Life_RscStructuredText
       {
           idc = 1001;
           x = 0.253755 * safezoneW + safezoneX;
           y = 0.230088495575221 * safezoneH + safezoneY;
           w = 0.070 * safezoneW;
           h = 0.019672 * safezoneH;
       };
       class Money_bank_left: Life_RscStructuredText
        {
            idc = 1110;
            text = "";
            x = 0.253755 * safezoneW + safezoneX;
            y = 0.338270 * safezoneH + safezoneY;
            w = 0.070 * safezoneW;
            h = 0.019672 * safezoneH;
            ColorBackground[] = {1,1,1,0};
        };
   };
};
