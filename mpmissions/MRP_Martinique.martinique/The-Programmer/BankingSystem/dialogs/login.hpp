/*
    Author: Robert
    Web site: www.the-programmer.com
    Discord: https://discord.the-programmer.com

    Terms of use:
        - This file is forbidden unless you have permission from the author. If you have this file without permission to use it please do not use it and do not share it.
        - If you have permission to use this file, you can use it on your server however it is strictly forbidden to share it.
        - Out of respect for the author please do not delete this information.
*/
class loginBank {
    idd = 5979;
    name = "loginBank";
    movingEnable = true;
    enableSimulation = true;
    class controlsBackground
    {
       class Fond : Life_RscPicture
       {
           idc = 1100;
           text = "";
           x = 0.155298 * safezoneW + safezoneX;
           y = -0.12069 * safezoneH + safezoneY;
           w = 0.693224 * safezoneW;
           h = 1.3061 * safezoneH;
       };
    };  
    class controls {
        class Bleu_1: Life_RscPicture
        {
            idc = 158;
            text = "The-Programmer\BankingSystem\textures\button.paa";
            x = 0.470748 * safezoneW + safezoneX;
            y = 0.366006 * safezoneH + safezoneY;
            w = 0.014919 * safezoneW;
            h = 0.031244 * safezoneH;
        };
        class Bleu_2: Life_RscPicture
        {
            idc = 157;
            text = "The-Programmer\BankingSystem\textures\button.paa";
            x = 0.481239 * safezoneW + safezoneX;
            y = 0.366006 * safezoneH + safezoneY;
            w = 0.014919 * safezoneW;
            h = 0.031244 * safezoneH;
        };
        class Bleu_3: Life_RscPicture
        {
            idc = 156;
            text = "The-Programmer\BankingSystem\textures\button.paa";
            x = 0.493501 * safezoneW + safezoneX;
            y = 0.366006 * safezoneH + safezoneY;
            w = 0.014919 * safezoneW;
            h = 0.031244 * safezoneH;
        };
        class Bleu_4: Life_RscPicture
        {
            idc = 159;
            text = "The-Programmer\BankingSystem\textures\button.paa";
            x = 0.504628 * safezoneW + safezoneX;
            y = 0.366006 * safezoneH + safezoneY;
            w = 0.014919 * safezoneW;
            h = 0.031244 * safezoneH;
        };
        class Button_0: Life_RscButtonInvisible_Bank
        {
            idc = 1101;
            text = "";
            onButtonClick = "[0] call the_programmer_bank_system_fnc_BankPin;";
            x = 0.445259 * safezoneW + safezoneX;
            y = 0.471147 * safezoneH + safezoneY;
            w = 0.024222 * safezoneW;
            h = 0.037376 * safezoneH;
        };
        class ButtonMenu_9: Life_RscButtonInvisible_Bank
        {
            idc = 1102;
            text = "";
            onButtonClick = "[9] call the_programmer_bank_system_fnc_BankPin;";
            x = 0.449264 * safezoneW + safezoneX;
            y = 0.511967 * safezoneH + safezoneY;
            w = 0.019339 * safezoneW;
            h = 0.03295 * safezoneH;
        };
        class Boutton_7: Life_RscButtonInvisible_Bank
        {
            idc = 1103;
            text = "";
            onButtonClick = "[7] call the_programmer_bank_system_fnc_BankPin;";
            x = 0.449231 * safezoneW + safezoneX;
            y = 0.54959 * safezoneH + safezoneY;
            w = 0.019404 * safezoneW;
            h = 0.033934 * safezoneH;
        };
        class Button_1: Life_RscButtonInvisible_Bank
        {
            idc = 1104;
            text = "";
            onButtonClick = "[1] call the_programmer_bank_system_fnc_BankPin;";
            x = 0.482424 * safezoneW + safezoneX;
            y = 0.470409 * safezoneH + safezoneY;
            w = 0.025948 * safezoneW;
            h = 0.040819 * safezoneH;
        };
        class Button_5: Life_RscButtonInvisible_Bank
        {
            idc = 1105;
            text = "";
            onButtonClick = "[5] call the_programmer_bank_system_fnc_BankPin;";
            x = 0.483677 * safezoneW + safezoneX;
            y = 0.512335 * safezoneH + safezoneY;
            w = 0.022399 * safezoneW;
            h = 0.035655 * safezoneH;
        };
        class Button_4: Life_RscButtonInvisible_Bank
        {
            idc = 1106;
            text = "";
            onButtonClick = "[4] call the_programmer_bank_system_fnc_BankPin;";
            x = 0.485338 * safezoneW + safezoneX;
            y = 0.54959 * safezoneH + safezoneY;
            w = 0.021162 * safezoneW;
            h = 0.032704 * safezoneH;
        };
        class Boutton_3: Life_RscButtonInvisible_Bank
        {
            idc = 1107;
            text = "";
            onButtonClick = "[3] call the_programmer_bank_system_fnc_BankPin;";
            x = 0.520988 * safezoneW + safezoneX;
            y = 0.47336 * safezoneH + safezoneY;
            w = 0.025915 * safezoneW;
            h = 0.040819 * safezoneH;
        };
        class Menu_8: Life_RscButtonInvisible_Bank
        {
            idc = 1108;
            text = "";
            onButtonClick = "[8] call the_programmer_bank_system_fnc_BankPin;";
            x = 0.523495 * safezoneW + safezoneX;
            y = 0.516393 * safezoneH + safezoneY;
            w = 0.021943 * safezoneW;
            h = 0.029507 * safezoneH;
        };
        class Menu_6: Life_RscButtonInvisible_Bank
        {
            idc = 1109;
            text = "";
            onButtonClick = "[6] call the_programmer_bank_system_fnc_BankPin;";
            x = 0.52483 * safezoneW + safezoneX;
            y = 0.549835 * safezoneH + safezoneY;
            w = 0.020315 * safezoneW;
            h = 0.033442 * safezoneH;
        };
        class Button_2: Life_RscButtonInvisible_Bank
        {
            idc = 1110;
            text = "";
            onButtonClick = "[2] call the_programmer_bank_system_fnc_BankPin;";
            x = 0.485891 * safezoneW + safezoneX;
            y = 0.584508 * safezoneH + safezoneY;
            w = 0.021097 * safezoneW;
            h = 0.030983 * safezoneH;
        };
        class Cancel: Life_RscButtonInvisible_Bank
        {
            idc = 1111;
            text = "";
            onButtonClick = "[-1] call the_programmer_bank_system_fnc_BankPin;";
            x = 0.526067 * safezoneW + safezoneX;
            y = 0.586967 * safezoneH + safezoneY;
            w = 0.019925 * safezoneW;
            h = 0.031966 * safezoneH;
        };
        class Connect: Life_RscButtonInvisible_Bank
        {
            idc = 1112;
            text = "";
            onButtonClick = "[-2] call the_programmer_bank_system_fnc_BankPin;";
            x = 0.445846 * safezoneW + safezoneX;
            y = 0.395563 * safezoneH + safezoneY;
            w = 0.103272 * safezoneW;
            h = 0.025420 * safezoneH;
        };
        class Forgotten: Life_RscButtonInvisible_Bank
        {
            idc = 1116;
            text = "";
            onButtonClick = "[-3] call the_programmer_bank_system_fnc_BankPin;";
            x = 0.469612 * safezoneW + safezoneX;
            y = 0.422950 * safezoneH + safezoneY;
            w = 0.048706 * safezoneW;
            h = 0.015737 * safezoneH;
        };
    };
};
