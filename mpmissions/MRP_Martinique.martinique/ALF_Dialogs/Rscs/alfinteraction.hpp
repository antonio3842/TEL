/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/
class interactionSystem 
{
    idd = 25799;
    name= "interactionSystem";
    onLoad = "uiNamespace setVariable ['interactPlayer',0]";
    movingEnable = false;
    enableSimulation = false;
    class controlsBackground {};
    class controls 
    {
        class pic1 : Life_RscPicture 
        {
            idc = 25800;
            text = "\ALF_Client2\textures\Interaction\p_i_1.paa";
            x = 0.319531 * safezoneW + safezoneX;
            y = 0.236 * safezoneH + safezoneY;
            w = 0.366094 * safezoneW;
            h = 0.594 * safezoneH;
        };
        class pic2 : pic1 
        {
            idc = 25801;
            text = "\ALF_Client2\textures\Interaction\p_i_2.paa";
        };
        class btn1: Life_RscButtonMenu {
            idc = 25802;
            text = "";
            show = false;
            colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
            x = 0.335 * safezoneW + safezoneX;
            y = 0.401 * safezoneH + safezoneY;
            w = 0.165 * safezoneW;
            h = 0.033 * safezoneH;
        };
        class btn2: btn1 {
            idc = 25803;
            y = 0.445 * safezoneH + safezoneY;
        };
        class btn3: btn1 {
            idc = 25804;
            colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
            y = 0.489 * safezoneH + safezoneY;
        };
        class btn4: btn1 {
            idc = 25805;
            y = 0.533 * safezoneH + safezoneY;
        };
        class btn5: btn1 {
            idc = 25806;
            y = 0.577 * safezoneH + safezoneY;
        };
        class btn6: btn1 {
            idc = 25807;
            y = 0.621 * safezoneH + safezoneY;
        };
        class btn7: btn1 {
            idc = 25808;
            x = 0.505156 * safezoneW + safezoneX;
            y = 0.401 * safezoneH + safezoneY;
        };
        class btn8: btn7 {
            idc = 25809;
            y = 0.445 * safezoneH + safezoneY;
        };
        class btn9: btn7 {
            idc = 25810;
            y = 0.489 * safezoneH + safezoneY;
        };
        class btn10: btn7 {
            idc = 25811;
            y = 0.533 * safezoneH + safezoneY;
        };
        class btn11: btn7 {
            idc = 25812;
            y = 0.577 * safezoneH + safezoneY;
        };
        class btn12: btn7 {
            idc = 25813;
            y = 0.621 * safezoneH + safezoneY;
        };
        class btnmenu: Life_RscButtonInvisible {
            idc = 25814;
            x = 0.663437 * safezoneW + safezoneX;
            y = 0.357 * safezoneH + safezoneY;
            w = 0.0211979 * safezoneW;
            h = 0.0392592 * safezoneH;
        };
    };
};
