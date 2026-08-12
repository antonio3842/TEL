/*
    Author: Robert
    Web site: www.the-programmer.com
    Discord: https://discord.the-programmer.com

    Terms of use:
        - This file is forbidden unless you have permission from the author. If you have this file without permission to use it please do not use it and do not share it.
        - If you have permission to use this file, you can use it on your server however it is strictly forbidden to share it.
        - Out of respect for the author please do not delete this information.
*/
class terminal_2 {
    idd = 14257;
    name = "terminal_2";
    movingEnable = false;
    enableSimulation = true;

    class controlsBackground {
        class Picturebox_1119: Life_RscPicture
        {
            idc = 1119;
            text = "";
            x = 0.269664 * safezoneW + safezoneX;
            y = 0.072457 * safezoneH + safezoneY;
            w = 0.429255 * safezoneW;
            h = 0.767251 * safezoneH;
        };
        class Picturebox_1100: Life_RscPicture
        {
            idc = 1100;
            text = "";
            x = 0.269664 * safezoneW + safezoneX;
            y = 0.072457 * safezoneH + safezoneY;
            w = 0.429255 * safezoneW;
            h = 0.767251 * safezoneH;
        };
    };
    class controls {
        class PIN_1: Life_RscButtonInvisible_Bank
        {
            idc = 1101;
            x = 0.425445 * safezoneW + safezoneX;
            y = 0.511153 * safezoneH + safezoneY;
            w = 0.030082 * safezoneW;
            h = 0.022745 * safezoneH;
            onButtonClick = "[""1""] call the_programmer_bank_system_fnc_terminal_pin;";

        };
        class PIN_2: Life_RscButtonInvisible_Bank
        {
            idc = 1102;

            x = 0.466076 * safezoneW + safezoneX;
            y = 0.513922 * safezoneH + safezoneY;
            w = 0.028910 * safezoneW;
            h = 0.022518 * safezoneH;
            onButtonClick = "[""2""] call the_programmer_bank_system_fnc_terminal_pin;";

        };
        class PIN_3: Life_RscButtonInvisible_Bank
        {
            idc = 1103;
            x = 0.503874 * safezoneW + safezoneX;
            y = 0.511016 * safezoneH + safezoneY;
            w = 0.030668 * safezoneW;
            h = 0.023970 * safezoneH;
            onButtonClick = "[""3""] call the_programmer_bank_system_fnc_terminal_pin;";

        };
        class PIN_4: Life_RscButtonInvisible_Bank
        {
            idc = 1104;
            x = 0.425543 * safezoneW + safezoneX;
            y = 0.547518 * safezoneH + safezoneY;
            w = 0.030277 * safezoneW;
            h = 0.020702 * safezoneH;
            onButtonClick = "[""4""] call the_programmer_bank_system_fnc_terminal_pin;";
        };
        class PIN_5: Life_RscButtonInvisible_Bank
        {
            idc = 1105;
            x = 0.465880 * safezoneW + safezoneX;
            y = 0.549152 * safezoneH + safezoneY;
            w = 0.029886 * safezoneW;
            h = 0.026150 * safezoneH;
            onButtonClick = "[""5""] call the_programmer_bank_system_fnc_terminal_pin;";

        };
        class PIN_6: Life_RscButtonInvisible_Bank
        {
            idc = 1106;
            x = 0.504753 * safezoneW + safezoneX;
            y = 0.546973 * safezoneH + safezoneY;
            w = 0.029691 * safezoneW;
            h = 0.024697 * safezoneH;
            onButtonClick = "[""6""] call the_programmer_bank_system_fnc_terminal_pin;";

        };
        class PIN_7: Life_RscButtonInvisible_Bank
        {
            idc = 1107;
            x = 0.425641 * safezoneW + safezoneX;
            y = 0.582929 * safezoneH + safezoneY;
            w = 0.030863 * safezoneW;
            h = 0.022518 * safezoneH;
            onButtonClick = "[""7""] call the_programmer_bank_system_fnc_terminal_pin;";

        };
        class PIN_8: Life_RscButtonInvisible_Bank
        {
            idc = 1108;
            x = 0.465392 * safezoneW + safezoneX;
            y = 0.583292 * safezoneH + safezoneY;
            w = 0.029496 * safezoneW;
            h = 0.022518 * safezoneH;
            onButtonClick = "[""8""] call the_programmer_bank_system_fnc_terminal_pin;";
        };
        class PIN_9: Life_RscButtonInvisible_Bank
        {
            idc = 1109;
            x = 0.503190 * safezoneW + safezoneX;
            y = 0.582929 * safezoneH + safezoneY;
            w = 0.030472 * safezoneW;
            h = 0.023970 * safezoneH;
            onButtonClick = "[""9""] call the_programmer_bank_system_fnc_terminal_pin;";
        };
        class PIN_0: Life_RscButtonInvisible_Bank
        {
            idc = 1124;
            x = 0.465294 * safezoneW + safezoneX;
            y = 0.620702 * safezoneH + safezoneY;
            w = 0.028519 * safezoneW;
            h = 0.025786 * safezoneH;
            onButtonClick = "[""0""] call the_programmer_bank_system_fnc_terminal_pin;";
        };
        class CANCEL: Life_RscButtonInvisible_Bank
        {
            idc = 1110;
            x = 0.427399 * safezoneW + safezoneX;
            y = 0.651936 * safezoneH + safezoneY;
            w = 0.030472 * safezoneW;
            h = 0.026876 * safezoneH;
            onButtonClick = "closeDialog 0;";
        };
        class RETURN: Life_RscButtonInvisible_Bank
        {
            idc = 1111;
            x = 0.464513 * safezoneW + safezoneX;
            y = 0.657021 * safezoneH + safezoneY;
            w = 0.030472 * safezoneW;
            h = 0.022518 * safezoneH;
            onButtonClick = "[""-4""] call the_programmer_bank_system_fnc_terminal_pin;";
        };
        class VALIDATE: Life_RscButtonInvisible_Bank
        {
            idc = 1112;
            x = 0.502506 * safezoneW + safezoneX;
            y = 0.654479 * safezoneH + safezoneY;
            w = 0.027933 * safezoneW;
            h = 0.024697 * safezoneH;
            onButtonClick = "[""-3""] call the_programmer_bank_system_fnc_terminal_pin;";
        };
        class inserez_enter_wait: Life_RscStructuredText
        {
            idc = 1114;
            text = "";
            x = 0.421636 * safezoneW + safezoneX;
            y = 0.358111 * safezoneH + safezoneY;
            w = 0.117495 * safezoneW;
            h = 0.029055 * safezoneH;
        };
        class code_title: Life_RscStructuredText
        {
            idc = 1116;
            text = "";
            x = 0.421636 * safezoneW + safezoneX;
            y = 0.358111 * safezoneH + safezoneY;
            w = 0.117495 * safezoneW;
            h = 0.029055 * safezoneH;
        };
        class prix_code: Life_RscStructuredText
        {
            idc = 1115;
            text = "";
            x = 0.422223 * safezoneW + safezoneX;
            y = 0.395884 * safezoneH + safezoneY;
            w = 0.116128 * safezoneW;
            h = 0.029055 * safezoneH;
        };
        class Button_1122: Life_RscButton
        {
            idc = 1122;
            x = -0.01679 * safezoneW + safezoneX;
            y = 0.262227 * safezoneH + safezoneY;
            w = 0.046881 * safezoneW;
            h = 0.014527 * safezoneH;
        };
    };
};