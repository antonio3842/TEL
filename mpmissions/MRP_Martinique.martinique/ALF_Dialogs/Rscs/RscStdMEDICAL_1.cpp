#define ARMA_COLOR {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",1}

#define GUI_GRID_H	(0.04)

//--- medical
#define IDC_MEDICAL_ST_INJURIES	3245
#define IDC_MEDICAL_ST_HIST	3246
#define IDC_MEDICAL_BACK	3345
#define IDC_MEDICAL_O1		3346
#define IDC_MEDICAL_O2		3347
#define IDC_MEDICAL_O3		3348
#define IDC_MEDICAL_BACK_P1	3349
#define IDC_MEDICAL_BACK_P2	3350
#define IDC_MEDICAL_BACK_P3	3351
#define IDC_MEDICAL_BACK_TRI	3352
#define IDC_MEDICAL_I_T		3353
#define IDC_MEDICAL_I_JD	3354
#define IDC_MEDICAL_I_JG	3355
#define IDC_MEDICAL_I_BG	3356
#define IDC_MEDICAL_I_BD	3357
#define IDC_MEDICAL_I_H		3358
#define IDC_MEDICAL_B_1		3359
#define IDC_MEDICAL_B_2		3360
#define IDC_MEDICAL_B_3		3361
#define IDC_MEDICAL_E_1		3545
#define IDC_MEDICAL_E_2		3546
#define IDC_MEDICAL_E_3		3547
#define IDC_MEDICAL_E_4		3548
#define IDC_MEDICAL_E_5		3549
#define IDC_MEDICAL_E_6		3550
#define IDC_MEDICAL_E_7		3551
#define IDC_MEDICAL_E_8		3552
#define IDC_MEDICAL_E_9		3553
#define IDC_MEDICAL_E_10	3554
#define IDC_MEDICAL_T_BPM	3745
#define IDC_MEDICAL_T_PA	3746
#define IDC_MEDICAL_T_VENT	3747
#define IDC_MEDICAL_CK_1	4945
#define IDC_MEDICAL_CK_2	4946
#define IDC_MEDICAL_CK_3	4947


class MEDICAL_1
{
	idd = 4201;
	onLoad = "";
    onUnLoad = "";
	class controls 
	{
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Matthew Way, v1.063, #Zujyca)
////////////////////////////////////////////////////////

class BACK: RscPicture
{
	idc = IDC_MEDICAL_BACK;
	text = "cba_tex_1\MEDICAL\background.paa";
	x = 0.190625 * safezoneW + safezoneX;
	y = -0.05 * safezoneH + safezoneY;
	w = 0.582656 * safezoneW;
	h = 1.056 * safezoneH;
};
class O1: RscClickableText
{
	idc = IDC_MEDICAL_O1;
	text = "cba_tex_1\MEDICAL\1.paa";
	x = 0.222594 * safezoneW + safezoneX;
	y = 0.1898 * safezoneH + safezoneY;
	w = 0.0257812 * safezoneW;
	h = 0.044 * safezoneH;
};
class O2: RscClickableText
{
	idc = IDC_MEDICAL_O2;
	text = "cba_tex_1\MEDICAL\2.paa";
	x = 0.2525 * safezoneW + safezoneX;
	y = 0.1898 * safezoneH + safezoneY;
	w = 0.0257812 * safezoneW;
	h = 0.044 * safezoneH;
};
class O3: RscClickableText
{
	idc = IDC_MEDICAL_O3;
	text = "cba_tex_1\MEDICAL\3.paa";
	x = 0.282406 * safezoneW + safezoneX;
	y = 0.1898 * safezoneH + safezoneY;
	w = 0.0257812 * safezoneW;
	h = 0.044 * safezoneH;
};
class BACK_p1: RscPicture
{
	idc = IDC_MEDICAL_BACK_P1;
	text = "cba_tex_1\MEDICAL\1\p1.paa";
	x = 0.159687 * safezoneW + safezoneX;
	y = 0.225 * safezoneH + safezoneY;
	w = 0.292878 * safezoneW;
	h = 0.2794 * safezoneH;
};
class BACK_p2: RscPicture
{
	idc = IDC_MEDICAL_BACK_P2;
	text = "cba_tex_1\MEDICAL\1\p2.paa";
	x = 0.510311 * safezoneW + safezoneX;
	y = 0.225 * safezoneH + safezoneY;
	w = 0.292876 * safezoneW;
	h = 0.2794 * safezoneH;
};
class BACK_p3: RscPicture
{
	idc = IDC_MEDICAL_BACK_P3;
	text = "cba_tex_1\MEDICAL\1\p3.paa";
	x = 0.519591 * safezoneW + safezoneX;
	y = 0.5088 * safezoneH + safezoneY;
	w = 0.273284 * safezoneW;
	h = 0.2596 * safezoneH;
};
class BACK_tri: RscPicture
{
	idc = IDC_MEDICAL_BACK_TRI;
	text = "cba_tex_1\MEDICAL\1\tri.paa";
	x = 0.196812 * safezoneW + safezoneX;
	y = 0.4296 * safezoneH + safezoneY;
	w = 0.215532 * safezoneW;
	h = 0.4202 * safezoneH;
};
class I_t: RscClickableText
{
	idc = IDC_MEDICAL_I_T;
	text = "cba_tex_1\MEDICAL\t.paa";
	x = 0.453594 * safezoneW + safezoneX;
	y = 0.3306 * safezoneH + safezoneY;
	w = 0.0525937 * safezoneW;
	h = 0.1804 * safezoneH;
};
class I_jd: RscClickableText
{
	idc = IDC_MEDICAL_I_JD;
	text = "cba_tex_1\MEDICAL\jd.paa";
	x = 0.453594 * safezoneW + safezoneX;
	y = 0.478 * safezoneH + safezoneY;
	w = 0.0257812 * safezoneW;
	h = 0.187 * safezoneH;
};
class I_jg: RscClickableText
{
	idc = IDC_MEDICAL_I_JG;
	text = "cba_tex_1\MEDICAL\jg.paa";
	x = 0.479375 * safezoneW + safezoneX;
	y = 0.478 * safezoneH + safezoneY;
	w = 0.0257812 * safezoneW;
	h = 0.187 * safezoneH;
};
class I_bg: RscClickableText
{
	idc = IDC_MEDICAL_I_BG;
	text = "cba_tex_1\MEDICAL\bg.paa";
	x = 0.5 * safezoneW + safezoneX;
	y = 0.3592 * safezoneH + safezoneY;
	w = 0.0257812 * safezoneW;
	h = 0.187 * safezoneH;
};
class I_bd: RscClickableText
{
	idc = IDC_MEDICAL_I_BD;
	text = "cba_tex_1\MEDICAL\bd.paa";
	x = 0.431934 * safezoneW + safezoneX;
	y = 0.357 * safezoneH + safezoneY;
	w = 0.0257812 * safezoneW;
	h = 0.187 * safezoneH;
};
class I_h: RscClickableText
{
	idc = IDC_MEDICAL_I_H;
	text = "cba_tex_1\MEDICAL\h.paa";
	x = 0.463906 * safezoneW + safezoneX;
	y = 0.291 * safezoneH + safezoneY;
	w = 0.0319688 * safezoneW;
	h = 0.055 * safezoneH;
};
class B_1: RscClickableText
{
	idc = IDC_MEDICAL_B_1;
	text = "cba_tex_1\MEDICAL\1\b1.paa";
	x = 0.548468 * safezoneW + safezoneX;
	y = 0.5836 * safezoneH + safezoneY;
	w = 0.0928125 * safezoneW;
	h = 0.0396 * safezoneH;
};
class B_2: RscClickableText
{
	idc = IDC_MEDICAL_B_2;
	text = "cba_tex_1\MEDICAL\1\b2.paa";
	x = 0.548468 * safezoneW + safezoneX;
	y = 0.6386 * safezoneH + safezoneY;
	w = 0.0928125 * safezoneW;
	h = 0.0396 * safezoneH;
};
class B_3: RscClickableText
{
	idc = IDC_MEDICAL_B_3;
	text = "cba_tex_1\MEDICAL\1\b3.paa";
	x = 0.557747 * safezoneW + safezoneX;
	y = 0.6914 * safezoneH + safezoneY;
	w = 0.07425 * safezoneW;
	h = 0.0396 * safezoneH;
};
class ST_INJURIES: RscStructuredText
{
	idc = IDC_MEDICAL_ST_INJURIES;
	text = "";
	x = 0.202999 * safezoneW + safezoneX;
	y = 0.2778 * safezoneH + safezoneY;
	w = 0.203157 * safezoneW;
	h = 0.209 * safezoneH;
};
class ST_HIST: RscStructuredText
{
	idc = IDC_MEDICAL_ST_HIST;
	text = "";
	x = 0.553624 * safezoneW + safezoneX;
	y = 0.2778 * safezoneH + safezoneY;
	w = 0.203157 * safezoneW;
	h = 0.209 * safezoneH;
};
class T_BPM: RscText
{
	idc = IDC_MEDICAL_T_BPM;
	text = ""; //--- ToDo: Localize;
	x = 0.651593 * safezoneW + safezoneX;
	y = 0.5924 * safezoneH + safezoneY;
	w = 0.0412501 * safezoneW;
	h = 0.0286 * safezoneH;
	style = 2;
	sizeEx = 1.1 * GUI_GRID_H;
};
class T_PA: RscText
{
	idc = IDC_MEDICAL_T_PA;
	text = ""; //--- ToDo: Localize;
	x = 0.651593 * safezoneW + safezoneX;
	y = 0.6452 * safezoneH + safezoneY;
	w = 0.0412501 * safezoneW;
	h = 0.0286 * safezoneH;
	style = 2;
	sizeEx = 0.9 * GUI_GRID_H;
};
class T_VENT: RscText
{
	idc = IDC_MEDICAL_T_VENT;
	text = ""; //--- ToDo: Localize;
	x = 0.651593 * safezoneW + safezoneX;
	y = 0.7002 * safezoneH + safezoneY;
	w = 0.0412501 * safezoneW;
	h = 0.0286 * safezoneH;
	style = 2;
	sizeEx = 1.1 * GUI_GRID_H;
};
class E_1: RscEdit
{
	idc = IDC_MEDICAL_E_1;
	x = 0.2195 * safezoneW + safezoneX;
	y = 0.566 * safezoneH + safezoneY;
	w = 0.0629063 * safezoneW;
	h = 0.022 * safezoneH;
	sizeEx = 1 * GUI_GRID_H;
};
class E_2: RscEdit
{
	idc = IDC_MEDICAL_E_2;
	x = 0.341187 * safezoneW + safezoneX;
	y = 0.566 * safezoneH + safezoneY;
	w = 0.0629063 * safezoneW;
	h = 0.022 * safezoneH;
	sizeEx = 1 * GUI_GRID_H;
};
class E_3: RscEdit
{
	idc = IDC_MEDICAL_E_3;
	x = 0.2195 * safezoneW + safezoneX;
	y = 0.5968 * safezoneH + safezoneY;
	w = 0.0165002 * safezoneW;
	h = 0.022 * safezoneH;
	sizeEx = 1 * GUI_GRID_H;
};
class E_4: RscEdit
{
	idc = IDC_MEDICAL_E_4;
	x = 0.34325 * safezoneW + safezoneX;
	y = 0.5968 * safezoneH + safezoneY;
	w = 0.040219 * safezoneW;
	h = 0.022 * safezoneH;
	sizeEx = 1 * GUI_GRID_H;
};
class E_5: RscEdit
{
	idc = IDC_MEDICAL_E_5;
	x = 0.244251 * safezoneW + safezoneX;
	y = 0.6276 * safezoneH + safezoneY;
	w = 0.052594 * safezoneW;
	h = 0.022 * safezoneH;
	sizeEx = 1 * GUI_GRID_H;
};
class E_6: RscEdit
{
	idc = IDC_MEDICAL_E_6;
	x = 0.3515 * safezoneW + safezoneX;
	y = 0.6276 * safezoneH + safezoneY;
	w = 0.052594 * safezoneW;
	h = 0.022 * safezoneH;
	sizeEx = 1 * GUI_GRID_H;
};
class E_7: RscEdit
{
	idc = IDC_MEDICAL_E_7;
	x = 0.231875 * safezoneW + safezoneX;
	y = 0.6584 * safezoneH + safezoneY;
	w = 0.121682 * safezoneW;
	h = 0.022 * safezoneH;
	sizeEx = 1 * GUI_GRID_H;
};
class E_8: RscEdit
{
	idc = IDC_MEDICAL_E_8;
	x = 0.370061 * safezoneW + safezoneX;
	y = 0.7024 * safezoneH + safezoneY;
	w = 0.0340316 * safezoneW;
	h = 0.0264 * safezoneH;
	sizeEx = 1.3 * GUI_GRID_H;
};
class E_10: RscEdit
{
	idc = IDC_MEDICAL_E_10;
	x = 0.201968 * safezoneW + safezoneX;
	y = 0.7376 * safezoneH + safezoneY;
	w = 0.148488 * safezoneW;
	h = 0.0198 * safezoneH;
	sizeEx = 0.8 * GUI_GRID_H;
};
class E_9: RscEdit
{
	idc = IDC_MEDICAL_E_9;
	x = 0.201968 * safezoneW + safezoneX;
	y = 0.72 * safezoneH + safezoneY;
	w = 0.148488 * safezoneW;
	h = 0.0198 * safezoneH;
	sizeEx = 0.8 * GUI_GRID_H;
};
class CK_1: RscCheckbox
{
	idc = IDC_MEDICAL_CK_1;
	x = 0.287562 * safezoneW + safezoneX;
	y = 0.6892 * safezoneH + safezoneY;
	w = 0.0103125 * safezoneW;
	h = 0.022 * safezoneH;
};
class CK_2: RscCheckbox
{
	idc = IDC_MEDICAL_CK_2;
	x = 0.315406 * safezoneW + safezoneX;
	y = 0.6892 * safezoneH + safezoneY;
	w = 0.0103125 * safezoneW;
	h = 0.022 * safezoneH;
};
class CK_3: RscCheckbox
{
	idc = IDC_MEDICAL_CK_3;
	x = 0.346344 * safezoneW + safezoneX;
	y = 0.6892 * safezoneH + safezoneY;
	w = 0.0103125 * safezoneW;
	h = 0.022 * safezoneH;
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////

    };
};

/* #Xaqiry
$[
	1.063,
	["medical",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,1,0],
	[-1200,"BACK",[1,"cba_tex_1\MEDICAL\background.paa",["0.190625 * safezoneW + safezoneX","-0.05 * safezoneH + safezoneY","0.582656 * safezoneW","1.056 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1201,"O1",[1,"cba_tex_1\MEDICAL\1.paa",["0.222594 * safezoneW + safezoneX","0.1898 * safezoneH + safezoneY","0.0257812 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1202,"O2",[1,"cba_tex_1\MEDICAL\2.paa",["0.2525 * safezoneW + safezoneX","0.1898 * safezoneH + safezoneY","0.0257812 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1203,"O3",[1,"cba_tex_1\MEDICAL\3.paa",["0.282406 * safezoneW + safezoneX","0.1898 * safezoneH + safezoneY","0.0257812 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[-1204,"BACK_p1",[1,"cba_tex_1\MEDICAL\1\p1.paa",["0.159687 * safezoneW + safezoneX","0.225 * safezoneH + safezoneY","0.292878 * safezoneW","0.2794 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[-1205,"BACK_p2",[1,"cba_tex_1\MEDICAL\1\p2.paa",["0.510311 * safezoneW + safezoneX","0.225 * safezoneH + safezoneY","0.292876 * safezoneW","0.2794 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[-1206,"BACK_p3",[1,"cba_tex_1\MEDICAL\1\p3.paa",["0.519591 * safezoneW + safezoneX","0.5088 * safezoneH + safezoneY","0.273284 * safezoneW","0.2596 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1207,"BACK_tri",[1,"cba_tex_1\MEDICAL\1\tri.paa",["0.196812 * safezoneW + safezoneX","0.4296 * safezoneH + safezoneY","0.215532 * safezoneW","0.4202 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1208,"I_t",[1,"cba_tex_1\MEDICAL\t.paa",["0.453594 * safezoneW + safezoneX","0.3306 * safezoneH + safezoneY","0.0525937 * safezoneW","0.1804 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1209,"I_jd",[1,"cba_tex_1\MEDICAL\jd.paa",["0.453594 * safezoneW + safezoneX","0.478 * safezoneH + safezoneY","0.0257812 * safezoneW","0.187 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1210,"I_jg",[1,"cba_tex_1\MEDICAL\jg.paa",["0.479375 * safezoneW + safezoneX","0.478 * safezoneH + safezoneY","0.0257812 * safezoneW","0.187 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1211,"I_bg",[1,"cba_tex_1\MEDICAL\bg.paa",["0.5 * safezoneW + safezoneX","0.3592 * safezoneH + safezoneY","0.0257812 * safezoneW","0.187 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1212,"I_bd",[1,"cba_tex_1\MEDICAL\bd.paa",["0.431934 * safezoneW + safezoneX","0.357 * safezoneH + safezoneY","0.0257812 * safezoneW","0.187 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1213,"I_h",[1,"cba_tex_1\MEDICAL\h.paa",["0.463906 * safezoneW + safezoneX","0.291 * safezoneH + safezoneY","0.0319688 * safezoneW","0.055 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1214,"B_1",[1,"cba_tex_1\MEDICAL\1\b1.paa",["0.548468 * safezoneW + safezoneX","0.5836 * safezoneH + safezoneY","0.0928125 * safezoneW","0.0396 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1215,"B_2",[1,"cba_tex_1\MEDICAL\1\b2.paa",["0.548468 * safezoneW + safezoneX","0.6386 * safezoneH + safezoneY","0.0928125 * safezoneW","0.0396 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1216,"B_3",[1,"cba_tex_1\MEDICAL\1\b3.paa",["0.556716 * safezoneW + safezoneX","0.6914 * safezoneH + safezoneY","0.0752813 * safezoneW","0.0396 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1100,"ST_INJURIES",[1,"",["0.202999 * safezoneW + safezoneX","0.2778 * safezoneH + safezoneY","0.203157 * safezoneW","0.209 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1101,"ST_HIST",[1,"",["0.553624 * safezoneW + safezoneX","0.2778 * safezoneH + safezoneY","0.203157 * safezoneW","0.209 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"T_BPM",[1,"test",["0.651593 * safezoneW + safezoneX","0.5924 * safezoneH + safezoneY","0.0412501 * safezoneW","0.0286 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","1.1"],[]],
	[1601,"T_PA",[1,"test",["0.651593 * safezoneW + safezoneX","0.6452 * safezoneH + safezoneY","0.0412501 * safezoneW","0.0286 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","1.1"],[]],
	[1602,"T_VENT",[1,"test",["0.651593 * safezoneW + safezoneX","0.7002 * safezoneH + safezoneY","0.0412501 * safezoneW","0.0286 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","1.1"],[]],
	[1400,"E_1",[1,"",["0.2195 * safezoneW + safezoneX","0.566 * safezoneH + safezoneY","0.0629063 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","1"],[]],
	[1401,"E_2",[1,"",["0.341187 * safezoneW + safezoneX","0.566 * safezoneH + safezoneY","0.0629063 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","1"],[]],
	[1402,"E_3",[1,"",["0.2195 * safezoneW + safezoneX","0.5968 * safezoneH + safezoneY","0.0165002 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","1"],[]],
	[1403,"E_4",[1,"",["0.34325 * safezoneW + safezoneX","0.5968 * safezoneH + safezoneY","0.040219 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","1"],[]],
	[1404,"E_5",[1,"",["0.244251 * safezoneW + safezoneX","0.6276 * safezoneH + safezoneY","0.052594 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","1"],[]],
	[1405,"E_6",[1,"",["0.3515 * safezoneW + safezoneX","0.6276 * safezoneH + safezoneY","0.052594 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","1"],[]],
	[1406,"E_7",[1,"",["0.231875 * safezoneW + safezoneX","0.6584 * safezoneH + safezoneY","0.121682 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","1"],[]],
	[1407,"E_8",[1,"",["0.370061 * safezoneW + safezoneX","0.7024 * safezoneH + safezoneY","0.0340316 * safezoneW","0.0264 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","1.5"],[]],
	[1409,"E_10",[1,"",["0.201968 * safezoneW + safezoneX","0.7376 * safezoneH + safezoneY","0.148488 * safezoneW","0.0198 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","0.8"],[]],
	[1408,"E_9",[1,"",["0.201968 * safezoneW + safezoneX","0.72 * safezoneH + safezoneY","0.148488 * safezoneW","0.0198 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","0.8"],[]],
	[2800,"CK_1",[1,"",["0.287562 * safezoneW + safezoneX","0.6892 * safezoneH + safezoneY","0.0103125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2801,"CK_2",[1,"",["0.315406 * safezoneW + safezoneX","0.6892 * safezoneH + safezoneY","0.0103125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2802,"CK_3",[1,"",["0.346344 * safezoneW + safezoneX","0.6892 * safezoneH + safezoneY","0.0103125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/





