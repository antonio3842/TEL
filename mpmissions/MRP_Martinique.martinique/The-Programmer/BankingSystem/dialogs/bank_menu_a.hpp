/*
    Author: Robert
    Web site: www.the-programmer.com
    Discord: https://discord.the-programmer.com

    Terms of use:
        - This file is forbidden unless you have permission from the author. If you have this file without permission to use it please do not use it and do not share it.
        - If you have permission to use this file, you can use it on your server however it is strictly forbidden to share it.
        - Out of respect for the author please do not delete this information.
*/
class Bank_Menu_A {
    idd = 1568;
    name = "Bank_Menu_A";
    movingEnable = false;
    enableSimulation = true;
    onLoad = "[] spawn the_programmer_bank_system_fnc_bankUpdateLivret;";
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
        class Open_A: Life_RscButtonInvisible_Bank
        {
            idc = 1104;
            onButtonClick = "[""A""] spawn the_programmer_bank_system_fnc_bankCreateLivret;";
            x = 0.353291 * safezoneW + safezoneX;
            y = 0.457869 * safezoneH + safezoneY;
            w = 0.090014 * safezoneW;
            h = 0.051638 * safezoneH;

        };
        class Open_B: Life_RscButtonInvisible_Bank
        {
            idc = 1105;
            onButtonClick = "hint (['STR_FIRST_B','The_Programmer_BankingSystem','BankingSystem_localization'] call theprogrammer_core_fnc_localize);";
            x = 0.495821 * safezoneW + safezoneX;
            y = 0.458483 * safezoneH + safezoneY;
            w = 0.089696 * safezoneW;
            h = 0.052991 * safezoneH;

        };
        class Open_C: Life_RscButtonInvisible_Bank
        {
            idc = 1106;
            onButtonClick = "hint (['STR_FIRST_C','The_Programmer_BankingSystem','BankingSystem_localization'] call theprogrammer_core_fnc_localize);";
            x = 0.632792 * safezoneW + safezoneX;
            y = 0.458483 * safezoneH + safezoneY;
            w = 0.089696 * safezoneW;
            h = 0.052991 * safezoneH;

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
    };
};

