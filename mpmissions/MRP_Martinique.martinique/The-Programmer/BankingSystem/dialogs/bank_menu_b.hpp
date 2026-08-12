/*
    Author: Robert
    Web site: www.the-programmer.com
    Discord: https://discord.the-programmer.com

    Terms of use:
        - This file is forbidden unless you have permission from the author. If you have this file without permission to use it please do not use it and do not share it.
        - If you have permission to use this file, you can use it on your server however it is strictly forbidden to share it.
        - Out of respect for the author please do not delete this information.
*/
class Bank_Menu_B {
    idd = 1894;
    name = "Bank_Menu_B";
    onLoad = "[] spawn the_programmer_bank_system_fnc_bankUpdateLivret;";
    onUnload = "uiNamespace setVariable [""time_bank_menu_closed"",time]";
    movingEnable = false;
    enableSimulation = true;
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
        class Livret_B: Life_RscButtonInvisible_Bank
        {
            idc = 1105;
            x = 0.495821 * safezoneW + safezoneX;
            y = 0.458483 * safezoneH + safezoneY;
            w = 0.089696 * safezoneW;
            h = 0.052991 * safezoneH;
            onButtonClick = "[""B""] spawn the_programmer_bank_system_fnc_bankCreateLivret;";
        };
        class Livret_C: Life_RscButtonInvisible_Bank
        {
            idc = 1106;
            x = 0.632792 * safezoneW + safezoneX;
            y = 0.458483 * safezoneH + safezoneY;
            w = 0.089696 * safezoneW;
            h = 0.052991 * safezoneH;
            onButtonClick = "hint (['STR_FIRST_C','The_Programmer_BankingSystem','BankingSystem_localization'] call theprogrammer_core_fnc_localize);";
        };
        class Bank_Money_top: Life_RscStructuredText
        {
            idc = 1108;
            text = "";
            x = 0.507900 * safezoneW + safezoneX;
            y = 0.204098 * safezoneH + safezoneY;
            w = 0.083347 * safezoneW;
            h = 0.02459 * safezoneH;
            ColorBackground[] = {1,1,1,0};
            ColorText[] = {0.470588,0.972549,0,1};
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
        class Titulaire: Life_RscStructuredText
        {
            idc = 1109;
            text = "";
            x = 0.386460 * safezoneW + safezoneX;
            y = 0.199950 * safezoneH + safezoneY;
            w = 0.076184 * safezoneW;
            h = 0.01918 * safezoneH;
            ColorBackground[] = {1,1,1,0};
            ColorText[] = {1,1,1,1};
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
