/////////////////////////////////////////////////////////////////
/////////// This File was Edited by GUI D3V by Shinji ///////////
/////////////////////////////////////////////////////////////////
class ByScream_RscText {
    x = 0;
    y = 0;
    h = 0.037;
    w = 0.3;
    type = 0;
    style = 0;
    shadow = 1;
    colorShadow[] = {0, 0, 0, 0.5};
    font = "RobotoCondensed";
    SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
    text = "";
    colorText[] = {1, 1, 1, 1.0};
    colorBackground[] = {0, 0, 0, 0};
    linespacing = 1;
    tooltipColorText[] = {1,1,1,1};
    tooltipColorBox[] = {1,1,1,1};
    tooltipColorShade[] = {0,0,0,0.65};
};
class ByScream_RscProgress
{
    type = 8;
    style = 0;
    x = 0.344;
    y = 0.619;
    w = 0.313726;
    h = 0.0261438;
    texture = "";
    shadow = 2;
    colorFrame[] = {0, 0, 0, 1};
    colorBackground[] = {0,0,0,0.7};
    colorBar[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
};
class ByScream_RscPicture {
    shadow = 0;
    type = 0;
    style = 48;
    sizeEx = 0.023;
    font = "RobotoCondensed";
    colorBackground[] = {};
    colorText[] = {};
    x = 0;
    y = 0;
    w = 0.2;
    h = 0.15;
    tooltipColorText[] = {1,1,1,1};
    tooltipColorBox[] = {1,1,1,1};
    tooltipColorShade[] = {0,0,0,0.65};
};
class ByScream_RscShortcutButton {
    idc = -1;
    style = 0;
    default = 0;
    shadow = 1;
    w = 0.183825;
    h = "((((safezoneW / safezoneH) min 1.2) / 1.2) / 20)";
    color[] = {1,1,1,1.0};
    colorFocused[] = {1,1,1,1.0};
    color2[] = {0.95,0.95,0.95,1};
    colorDisabled[] = {1,1,1,0.25};
    colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",1};
    colorBackgroundFocused[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",1};
    colorBackground2[] = {1,1,1,1};
    animTextureDefault = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
    animTextureNormal = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
    animTextureDisabled = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
    animTextureOver = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\over_ca.paa";
    animTextureFocused = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\focus_ca.paa";
    animTexturePressed = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\down_ca.paa";
    periodFocus = 1.2;
    periodOver = 0.8;
    class HitZone
    {
        left = 0.0;
        top = 0.0;
        right = 0.0;
        bottom = 0.0;
    };
    class ShortcutPos
    {
        left = 0;
        top = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 20) - (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
        w = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1) * (3/4)";
        h = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
    };
    class TextPos
    {
        left = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1) * (3/4)";
        top = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 20) - (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
        right = 0.005;
        bottom = 0.0;
    };
    period = 0.4;
    font = "RobotoCondensed";
    size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
    sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
    text = "";
    soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1};
    soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1};
    soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1};
    soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1};
    action = "";
    class Attributes
    {
        font = "RobotoCondensed";
        color = "#E5E5E5";
        align = "left";
        shadow = "true";
    };
    class AttributesImage
    {
        font = "RobotoCondensed";
        color = "#E5E5E5";
        align = "left";
    };
};

class ByScream_RscButtonMenu : ByScream_RscShortcutButton {
    idc = -1;
    type = 16;
    style = "0x02 + 0xC0";
    default = 0;
    shadow = 0;
    x = 0;
    y = 0;
    w = 0.095589;
    h = 0.039216;
    animTextureNormal = "#(argb,8,8,3)color(1,1,1,1)";
    animTextureDisabled = "#(argb,8,8,3)color(1,1,1,1)";
    animTextureOver = "#(argb,8,8,3)color(1,1,1,1)";
    animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
    animTexturePressed = "#(argb,8,8,3)color(1,1,1,1)";
    animTextureDefault = "#(argb,8,8,3)color(1,1,1,1)";
    colorBackground[] = {0,0,0,0.8};
    colorBackgroundFocused[] = {1,1,1,1};
    colorBackground2[] = {0.75,0.75,0.75,1};
    color[] = {1,1,1,1};
    colorFocused[] = {0,0,0,1};
    color2[] = {0,0,0,1};
    colorText[] = {1,1,1,1};
    colorDisabled[] = {1,1,1,0.25};
    period = 1.2;
    periodFocus = 1.2;
    periodOver = 1.2;
    size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
    sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
    tooltipColorText[] = {1,1,1,1};
    tooltipColorBox[] = {1,1,1,1};
    tooltipColorShade[] = {0,0,0,0.65};
    class TextPos
    {
        left = "0.25 * (((safezoneW / safezoneH) min 1.2) / 40)";
        top = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
        right = 0.005;
        bottom = 0.0;
    };
    class Attributes
    {
        font = "RobotoCondensedLight";
        color = "#E5E5E5";
        align = "left";
        shadow = "false";
    };
    class ShortcutPos
    {
        left = "(6.25 * (((safezoneW / safezoneH) min 1.2) / 40)) - 0.0225 - 0.005";
        top = 0.005;
        w = 0.0225;
        h = 0.03;
    };
    soundEnter[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundEnter",0.09,1};
    soundPush[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundPush",0.09,1};
    soundClick[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundClick",0.09,1};
    soundEscape[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundEscape",0.09,1};
    textureNoShortcut = "";
};

class ByScream_RscButtonMenu_Invisible : ByScream_RscButtonMenu {
    colorbackground[] = {1,1,1,0};
    colorbackgroundfocused[] = {1,1,1,0};
    colorbackground2[] = {1,1,1,0};
    color[] = {1,1,1,0};
    colorfocused[] = {1,1,1,0};
    color2[] = {1,1,1,0};
    colortext[] = {1,1,1,0};
    colordisabled[] = {1,1,1,0};
    colorsecondary[] = {1,1,1,0};
    colorfocusedsecondary[] = {1,1,1,0};
    color2secondary[] = {1,1,1,0};
    colordisabledsecondary[] = {1,1,1,0};
    tooltipcolortext[] = {1,1,1,0};
    tooltipcolorbox[] = {1,1,1,0};
    tooltipcolorshade[] = {1,1,1,0};
};

class ByScream_Incendie_V3_Pompe {
   idd = 15651;
   name = "ByScream_Incendie_V3_Pompe";
   movingenable = false;
   enablesimulation = true;
   class controlsBackground
   {
    class fond : ByScream_RscPicture
       {
           text = "MRP_Incendie\dialogs\pompe.paa";
           x = 0.245833333333333 * safezoneW + safezoneX;
           y = 0.0607779980178394 * safezoneH + safezoneY;
           w = 0.50625 * safezoneW;
           h = 0.9 * safezoneH;
           idc = -1;
       };
   };
   class controls
   {
       
       class reservoir_eau : ByScream_RscProgress
       {
            w = 0.3015625 * safezoneW;
            h = 0.03 * safezoneH;
            idc = 1001;
            x = 0.371354166666667 * safezoneW + safezoneX;
            y = 0.515227948463826 * safezoneH + safezoneY;
            colorFrame[] = {0, 0, 0, 0};
            colorBackground[] = {0,0,0,0};
            colorbar[] = {0,0.749019607843137,1,1};
       };
       class bar_sortie : ByScream_RscText
       {
            idc = 1002;
            colortext[] = {0,0,0,1};
            text = "4 bars";
            x = 0.3453125 * safezoneW + safezoneX;
            y = 0.335 * safezoneH + safezoneY;
            h = 0.037 * safezoneH;
            w = 0.108333333333333 * safezoneW;
            shadow = 0;
            SizeEx = "0.06";
       };
       class bar_entree : ByScream_RscText
       {
            idc = 1003;
            colortext[] = {0,0,0,1};
            text = "0.1 bars";
            x = 0.5125 * safezoneW + safezoneX;
            y = 0.335 * safezoneH + safezoneY;
            h = 0.037 * safezoneH;
            w = 0.108333333333333 * safezoneW;
            shadow = 0;
            SizeEx = "0.06";
       };
       class bouton_plus : ByScream_RscButtonMenu_Invisible
       {
           x = 0.5125 * safezoneW + safezoneX;
           y = 0.758390017839445 * safezoneH + safezoneY;
           w = 0.0244791666666664 * safezoneW;
           h = 0.039216 * safezoneH;
           idc = 1004;
           tooltip = "Augmenter la pression en sortie de la pompe";
           tooltipcolortext[] = {1,1,1,1};
            tooltipcolorbox[] = {1,1,1,1};
            tooltipcolorshade[] = {0,0,0,1};
            action = "[+1] spawn ALF_fnc_incendie_changerPressionPompe";
       };
       class bouton_moins : ByScream_RscButtonMenu_Invisible
       {
           x = 0.54296875 * safezoneW + safezoneX;
           y = 0.758390017839445 * safezoneH + safezoneY;
           w = 0.0244791666666664 * safezoneW;
           h = 0.039216 * safezoneH;
           idc = 1005;
           tooltip = "Baisser la pression en sortie de la pompe";
           tooltipcolortext[] = {1,1,1,1};
            tooltipcolorbox[] = {1,1,1,1};
            tooltipcolorshade[] = {0,0,0,1};
            action = "[-1] spawn ALF_fnc_incendie_changerPressionPompe";
       };
       class bouton_on : ByScream_RscButtonMenu_Invisible
       {
           x = 0.66640625 * safezoneW + safezoneX;
           y = 0.758390017839445 * safezoneH + safezoneY;
           w = 0.0244791666666664 * safezoneW;
           h = 0.039216 * safezoneH;
           idc = 1006;
           tooltip = "Allumer ou éteindre la pompe";
           tooltipcolortext[] = {1,1,1,1};
            tooltipcolorbox[] = {1,1,1,1};
            tooltipcolorshade[] = {0,0,0,1};
            action = "[0] spawn ALF_fnc_incendie_changerPressionPompe";
       };
   };
};
/////////////////////////////////////////////////////////////////
////////////////////////// FILE END /////////////////////////////
/////////////////////////////////////////////////////////////////
