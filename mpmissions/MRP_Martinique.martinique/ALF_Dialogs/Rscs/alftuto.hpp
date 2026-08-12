/*
    File: alftuto.hpp
    Description: Guide tutoriel Martinique RP — 60% ecran centre
*/

#define TUTO_W 0.60 * safeZoneW
#define TUTO_H 0.60 * safeZoneH
#define TUTO_X safeZoneX + 0.20 * safeZoneW
#define TUTO_Y safeZoneY + 0.20 * safeZoneH
#define TUTO_PX(P) (TUTO_X + (P) * TUTO_W)
#define TUTO_PY(P) (TUTO_Y + (P) * TUTO_H)
#define TUTO_PW(P) ((P) * TUTO_W)
#define TUTO_PH(P) ((P) * TUTO_H)
#define TUTO_ACCENT_R 0.95
#define TUTO_ACCENT_G 0.72
#define TUTO_ACCENT_B 0.05
#define TUTO_FS_TITLE "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)"
#define TUTO_FS_SUB "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.95)"
#define TUTO_FS_TAB "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.9)"
#define TUTO_FS_BODY "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.88)"

class ALF_Tuto_Menu
{
    idd = 9903;
    movingEnable = false;
    enableSimulation = true;
    duration = 1e10;
    fadeIn = 0.15;
    onLoad = "[] spawn ALF_fnc_tuto_onMenuLoad;";
    onUnload = "[] call ALF_fnc_tuto_onMenuUnload;";

    class controls
    {
        class BG : RscText
        {
            idc = -1;
            x = TUTO_X; y = TUTO_Y;
            w = TUTO_W; h = TUTO_H;
            colorBackground[] = { 0.04, 0.05, 0.10, 0.97 };
            text = "";
        };

        class AccentTop : RscText
        {
            idc = -1;
            x = TUTO_X; y = TUTO_Y;
            w = TUTO_W; h = TUTO_PH(0.006);
            colorBackground[] = { TUTO_ACCENT_R, TUTO_ACCENT_G, TUTO_ACCENT_B, 1.0 };
            text = "";
        };

        class AccentLeft : RscText
        {
            idc = -1;
            x = TUTO_X; y = TUTO_Y;
            w = TUTO_PW(0.006); h = TUTO_H;
            colorBackground[] = { TUTO_ACCENT_R, TUTO_ACCENT_G, TUTO_ACCENT_B, 0.5 };
            text = "";
        };

        class Titre : RscText
        {
            idc = -1;
            x = TUTO_PX(0.03);
            y = TUTO_PY(0.025);
            w = TUTO_PW(0.72);
            h = TUTO_PH(0.06);
            text = "GUIDE DU CITOYEN";
            font = "PuristaMedium";
            SizeEx = TUTO_FS_TITLE;
            colorText[] = { TUTO_ACCENT_R, TUTO_ACCENT_G, TUTO_ACCENT_B, 1.0 };
            colorBackground[] = { 0, 0, 0, 0 };
            shadow = 0;
        };

        class SousTitre : RscText
        {
            idc = -1;
            x = TUTO_PX(0.03);
            y = TUTO_PY(0.085);
            w = TUTO_PW(0.72);
            h = TUTO_PH(0.04);
            text = "Martinique RP — Informations pour les nouveaux habitants";
            font = "PuristaMedium";
            SizeEx = TUTO_FS_SUB;
            colorText[] = { 0.55, 0.60, 0.75, 1.0 };
            colorBackground[] = { 0, 0, 0, 0 };
            shadow = 0;
        };

        class LogoMRP : Life_RscPictureKeepAspect
        {
            idc = 9925;
            x = TUTO_PX(0.86);
            y = TUTO_PY(0.028);
            w = TUTO_PH(0.095);
            h = TUTO_PH(0.095);
            text = "";
            colorBackground[] = { 0, 0, 0, 0 };
            shadow = 0;
        };

        class SepHeader : RscText
        {
            idc = -1;
            x = TUTO_X;
            y = TUTO_PY(0.135);
            w = TUTO_W;
            h = TUTO_PH(0.003);
            colorBackground[] = { TUTO_ACCENT_R, TUTO_ACCENT_G, TUTO_ACCENT_B, 0.30 };
            text = "";
        };

        class ComboSection : Life_RscCombo
        {
            idc = 9928;
            x = TUTO_PX(0.02);
            y = TUTO_PY(0.145);
            w = TUTO_PW(0.96);
            h = TUTO_PH(0.045);
            arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_ca.paa";
            arrowFull = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_active_ca.paa";
            colorBackground[] = { 0.08, 0.12, 0.22, 0.95 };
            colorSelectBackground[] = { 0.14, 0.22, 0.40, 1.0 };
            colorText[] = { 1, 1, 1, 1 };
            colorSelect[] = { 1, 1, 1, 1 };
            font = "PuristaMedium";
            SizeEx = TUTO_FS_TAB;
            shadow = 0;
        };

        class SepCombo : RscText
        {
            idc = -1;
            x = TUTO_X;
            y = TUTO_PY(0.195);
            w = TUTO_W;
            h = TUTO_PH(0.003);
            colorBackground[] = { TUTO_ACCENT_R, TUTO_ACCENT_G, TUTO_ACCENT_B, 0.20 };
            text = "";
        };

        class ContentGroup : Life_RscControlsGroupNoHorizontalScrollbars
        {
            idc = 9930;
            x = TUTO_PX(0.015);
            y = TUTO_PY(0.205);
            w = TUTO_PW(0.97);
            h = TUTO_PH(0.78);

            class Controls
            {
                class ContentText : Life_RscStructuredText
                {
                    idc = 9940;
                    x = 0;
                    y = 0;
                    w = 0.98;
                    h = 5.5;
                    text = "";
                    colorBackground[] = { 0, 0, 0, 0 };
                    size = TUTO_FS_BODY;
                    shadow = 0;
                };
            };
        };

        class ContentImage : Life_RscPictureKeepAspect
        {
            idc = 9941;
            x = TUTO_PX(0.08);
            y = TUTO_PY(0.24);
            w = TUTO_PW(0.84);
            h = TUTO_PH(0.70);
            text = "";
            show = 0;
            colorBackground[] = { 0, 0, 0, 0 };
            shadow = 0;
        };

        class BtnFermer : RscButton
        {
            idc = 9939;
            x = TUTO_PX(0.66);
            y = TUTO_PY(0.948);
            w = TUTO_PW(0.30);
            h = TUTO_PH(0.048);
            text = "FERMER";
            font = "PuristaMedium";
            SizeEx = TUTO_FS_TAB;
            colorText[] = { 0.95, 0.95, 0.95, 1.0 };
            colorBackground[] = { 0.10, 0.12, 0.20, 0.95 };
            colorBackgroundActive[] = { TUTO_ACCENT_R, TUTO_ACCENT_G, TUTO_ACCENT_B, 0.85 };
            colorFocused[] = { 0.14, 0.18, 0.30, 1.0 };
            shadow = 0;
            action = "closeDialog 2;";
        };
    };
};
