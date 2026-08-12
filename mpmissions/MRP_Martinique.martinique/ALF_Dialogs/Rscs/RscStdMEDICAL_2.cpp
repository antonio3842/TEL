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
#define IDC_MEDICAL_BACK_P5	3381
#define IDC_MEDICAL_BACK_P4	3380
#define IDC_MEDICAL_I_T		3353
#define IDC_MEDICAL_I_JD	3354
#define IDC_MEDICAL_I_JG	3355
#define IDC_MEDICAL_I_BG	3356
#define IDC_MEDICAL_I_BD	3357
#define IDC_MEDICAL_I_H		3358
#define IDC_MEDICAL_BACK_P21	3360
#define IDC_MEDICAL_BACK_P2A	3361
#define IDC_MEDICAL_BACK_P22	3362
#define IDC_MEDICAL_BACK_P23	3363
#define IDC_MEDICAL_I_SALP	3364
#define IDC_MEDICAL_I_SANP	3365
#define IDC_MEDICAL_B_PERFU	3366
#define IDC_MEDICAL_B_INJECT	3367
#define IDC_MEDICAL_B_RED	3368
#define IDC_MEDICAL_B_APPLI	3370
#define IDC_MEDICAL_BACK_P1C	3371
#define IDC_MEDICAL_BACK_P1A	3372
#define IDC_MEDICAL_BACK_P1B	3373
#define IDC_MEDICAL_B_STOP	3374
#define IDC_MEDICAL_ED_MED_VAL	3545
#define IDC_MEDICAL_LB_MED	3645
#define IDC_MEDICAL_LB_PERF	3646
#define IDC_MEDICAL_T_MED	3746
#define IDC_MEDICAL_T_PERF_SANG	3747
#define IDC_MEDICAL_T_PERF_SAL	3748
#define IDC_MEDICAL_CB_BAND	4245
#define IDC_MEDICAL_CB_ATL	4246
#define IDC_MEDICAL_CB_INJURIE	4247



class MEDICAL_2
{
	idd = 4202;
	onLoad = "";
    onUnLoad = "";
	class controls 
	{
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Matthew Way, v1.063, #Zydici)
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
class BACK_p4: RscPicture
{
	idc = IDC_MEDICAL_BACK_P4;
	text = "cba_tex_1\MEDICAL\2\p2.paa";
	x = 0.513407 * safezoneW + safezoneX;
	y = 0.5066 * safezoneH + safezoneY;
	w = 0.285653 * safezoneW;
	h = 0.2706 * safezoneH;
};
class BACK_p3: RscPicture // p1 but fuck
{
	idc = IDC_MEDICAL_BACK_P3;
	text = "cba_tex_1\MEDICAL\2\p1.paa";
	x = 0.162782 * safezoneW + safezoneX;
	y = 0.5044 * safezoneH + safezoneY;
	w = 0.286684 * safezoneW;
	h = 0.2728 * safezoneH;
};
class BACK_p1a: RscPicture
{
	idc = IDC_MEDICAL_BACK_P1A;
	text = "cba_tex_1\MEDICAL\2\p1a.paa";
	x = 0.177219 * safezoneW + safezoneX;
	y = 0.5264 * safezoneH + safezoneY;
	w = 0.156748 * safezoneW;
	h = 0.2728 * safezoneH;
};
class BACK_p1b: RscPicture
{
	idc = IDC_MEDICAL_BACK_P1B;
	text = "cba_tex_1\MEDICAL\2\p1b.paa";
	x = 0.291687 * safezoneW + safezoneX;
	y = 0.654 * safezoneH + safezoneY;
	w = 0.132002 * safezoneW;
	h = 0.1188 * safezoneH;
};
class BACK_p1c: RscPicture
{
	idc = IDC_MEDICAL_BACK_P1C;
	text = "cba_tex_1\MEDICAL\2\p1c.paa";
	x = 0.291687 * safezoneW + safezoneX;
	y = 0.544 * safezoneH + safezoneY;
	w = 0.132002 * safezoneW;
	h = 0.1474 * safezoneH;
};
class BACK_p5: RscPicture
{
	idc = IDC_MEDICAL_BACK_P5;
	text = "cba_tex_1\MEDICAL\2\p5.paa";
	x = 0.413373 * safezoneW + safezoneX;
	y = 0.7024 * safezoneH + safezoneY;
	w = 0.135095 * safezoneW;
	h = 0.0638 * safezoneH;
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
class ST_INJURIES: RscStructuredText
{
	idc = IDC_MEDICAL_ST_INJURIES;
	x = 0.202999 * safezoneW + safezoneX;
	y = 0.2778 * safezoneH + safezoneY;
	w = 0.203157 * safezoneW;
	h = 0.209 * safezoneH;
};
class ST_HIST: RscStructuredText
{
	idc = IDC_MEDICAL_ST_HIST;
	x = 0.553624 * safezoneW + safezoneX;
	y = 0.2778 * safezoneH + safezoneY;
	w = 0.203157 * safezoneW;
	h = 0.209 * safezoneH;
};
class BACK_p21: RscPicture
{
	idc = IDC_MEDICAL_BACK_P21;
	text = "cba_tex_1\MEDICAL\2\p21.paa";
	x = 0.55775 * safezoneW + safezoneX;
	y = 0.5638 * safezoneH + safezoneY;
	w = 0.117563 * safezoneW;
	h = 0.1342 * safezoneH;
};
class BACK_p2a: RscPicture
{
	idc = IDC_MEDICAL_BACK_P2A;
	text = "cba_tex_1\MEDICAL\2\p2a.paa";
	x = 0.671187 * safezoneW + safezoneX;
	y = 0.5286 * safezoneH + safezoneY;
	w = 0.0928124 * safezoneW;
	h = 0.264 * safezoneH;
};
class BACK_p23: RscPicture
{
	idc = IDC_MEDICAL_BACK_P23;
	text = "cba_tex_1\MEDICAL\2\p23.paa";
	x = 0.551562 * safezoneW + safezoneX;
	y = 0.6892 * safezoneH + safezoneY;
	w = 0.125812 * safezoneW;
	h = 0.066 * safezoneH;
};
class I_salp: RscClickableText
{
	idc = IDC_MEDICAL_I_SALP;
	text = "cba_tex_1\MEDICAL\2\salp.paa";
	x = 0.703156 * safezoneW + safezoneX;
	y = 0.6826 * safezoneH + safezoneY;
	w = 0.0360937 * safezoneW;
	h = 0.0638 * safezoneH;
};
class I_sanp: RscClickableText
{
	idc = IDC_MEDICAL_I_SANP;
	text = "cba_tex_1\MEDICAL\2\sanp.paa";
	x = 0.703156 * safezoneW + safezoneX;
	y = 0.5924 * safezoneH + safezoneY;
	w = 0.0360937 * safezoneW;
	h = 0.0638 * safezoneH;
};
class b_perfu: RscClickableText
{
	idc = IDC_MEDICAL_B_PERFU;
	text = "cba_tex_1\MEDICAL\2\bperfu.paa";
	x = 0.352544 * safezoneW + safezoneX;
	y = 0.6408 * safezoneH + safezoneY;
	w = 0.0577503 * safezoneW;
	h = 0.0286 * safezoneH;
};
class b_stop: RscClickableText
{
	idc = IDC_MEDICAL_B_STOP;
	text = "cba_tex_1\MEDICAL\2\bstop.paa";
	x = 0.428849 * safezoneW + safezoneX;
	y = 0.7068 * safezoneH + safezoneY;
	w = 0.136118 * safezoneW;
	h = 0.0638 * safezoneH;
};
class b_inject: RscClickableText
{
	idc = IDC_MEDICAL_B_INJECT;
	text = "cba_tex_1\MEDICAL\2\binject.paa";
	x = 0.352544 * safezoneW + safezoneX;
	y = 0.72 * safezoneH + safezoneY;
	w = 0.056719 * safezoneW;
	h = 0.0286 * safezoneH;
};
class b_red: RscClickableText
{
	idc = IDC_MEDICAL_B_RED;
	text = "cba_tex_1\MEDICAL\2\bred.paa";
	x = 0.551562 * safezoneW + safezoneX;
	y = 0.7134 * safezoneH + safezoneY;
	w = 0.061875 * safezoneW;
	h = 0.033 * safezoneH;
};
class b_appli: RscClickableText
{
	idc = IDC_MEDICAL_B_APPLI;
	text = "cba_tex_1\MEDICAL\2\bappli.paa";
	x = 0.581469 * safezoneW + safezoneX;
	y = 0.6254 * safezoneH + safezoneY;
	w = 0.0629063 * safezoneW;
	h = 0.033 * safezoneH;
};
class CB_band: RscCombo
{
	idc = IDC_MEDICAL_CB_BAND;
	x = 0.559813 * safezoneW + safezoneX;
	y = 0.6584 * safezoneH + safezoneY;
	w = 0.112406 * safezoneW;
	h = 0.0264 * safezoneH;
	sizeEx = 0.9 * GUI_GRID_H;
};
class CB_injurie: RscCombo
{
	idc = IDC_MEDICAL_CB_INJURIE;
	x = 0.559813 * safezoneW + safezoneX;
	y = 0.5968 * safezoneH + safezoneY;
	w = 0.112405 * safezoneW;
	h = 0.0264 * safezoneH;
	sizeEx = 0.9 * GUI_GRID_H;
};
class LB_med: RscListbox
{
	idc = IDC_MEDICAL_LB_MED;
	x = 0.206094 * safezoneW + safezoneX;
	y = 0.5704 * safezoneH + safezoneY;
	w = 0.095907 * safezoneW;
	h = 0.1386 * safezoneH;
	sizeEx = 0.7 * GUI_GRID_H;
};
class LB_perf: RscListbox
{
	idc = IDC_MEDICAL_LB_PERF;
	x = 0.312312 * safezoneW + safezoneX;
	y = 0.5704 * safezoneH + safezoneY;
	w = 0.0897187 * safezoneW;
	h = 0.0682 * safezoneH;
	sizeEx = 0.6 * GUI_GRID_H;
};
class T_med: RscText
{
	idc = IDC_MEDICAL_T_MED;
	text = ""; //--- ToDo: Localize;
	x = 0.312312 * safezoneW + safezoneX;
	y = 0.6804 * safezoneH + safezoneY;
	w = 0.0897184 * safezoneW;
	h = 0.0198 * safezoneH;
	style = 2;
	sizeEx = 0.9 * GUI_GRID_H;
};
class ED_med_val: RscEdit
{
	idc = IDC_MEDICAL_ED_MED_VAL;
	x = 0.3515 * safezoneW + safezoneX;
	y = 0.7046 * safezoneH + safezoneY;
	w = 0.0257814 * safezoneW;
	h = 0.0132 * safezoneH;
	sizeEx = 0.8 * GUI_GRID_H;
};
class T_perf_sang: RscText
{
	idc = IDC_MEDICAL_T_PERF_SANG;
	text = "??"; //--- ToDo: Localize;
	x = 0.704187 * safezoneW + safezoneX;
	y = 0.5748 * safezoneH + safezoneY;
	w = 0.0350625 * safezoneW;
	h = 0.0154 * safezoneH;
	style = 2;
	sizeEx = 0.9 * GUI_GRID_H;
};
class T_perf_sal: RscText
{
	idc = IDC_MEDICAL_T_PERF_SAL;
	text = "??"; //--- ToDo: Localize;
	x = 0.704806 * safezoneW + safezoneX;
	y = 0.66368 * safezoneH + safezoneY;
	w = 0.0350625 * safezoneW;
	h = 0.0154 * safezoneH;
	style = 2;
	sizeEx = 0.9 * GUI_GRID_H;
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////

    };
};

/* #Zujalo
$[
	1.063,
	["medical",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,1,0],
	[-1200,"BACK",[1,"cba_tex_1\MEDICAL\background.paa",["0.190625 * safezoneW + safezoneX","-0.05 * safezoneH + safezoneY","0.582656 * safezoneW","1.056 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[-1204,"BACK_p1",[1,"cba_tex_1\MEDICAL\1\p1.paa",["0.159687 * safezoneW + safezoneX","0.225 * safezoneH + safezoneY","0.292878 * safezoneW","0.2794 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1227,"BACK_p1a",[1,"cba_tex_1\MEDICAL\2\p1a.paa",["0.177219 * safezoneW + safezoneX","0.5264 * safezoneH + safezoneY","0.156748 * safezoneW","0.2728 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1228,"BACK_p1b",[1,"cba_tex_1\MEDICAL\2\p1b.paa",["0.291687 * safezoneW + safezoneX","0.654 * safezoneH + safezoneY","0.132002 * safezoneW","0.1188 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1226,"BACK_p1c",[1,"cba_tex_1\MEDICAL\2\p1c.paa",["0.291687 * safezoneW + safezoneX","0.544 * safezoneH + safezoneY","0.132002 * safezoneW","0.1474 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[-1205,"BACK_p2",[1,"cba_tex_1\MEDICAL\1\p2.paa",["0.510311 * safezoneW + safezoneX","0.225 * safezoneH + safezoneY","0.292876 * safezoneW","0.2794 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[-1207,"BACK_p4",[1,"cba_tex_1\MEDICAL\2\p2.paa",["0.513407 * safezoneW + safezoneX","0.5066 * safezoneH + safezoneY","0.285653 * safezoneW","0.2706 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[-1214,"BACK_p3",[1,"cba_tex_1\MEDICAL\2\p1.paa",["0.162782 * safezoneW + safezoneX","0.5044 * safezoneH + safezoneY","0.286684 * safezoneW","0.2728 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1201,"O1",[1,"cba_tex_1\MEDICAL\1.paa",["0.222594 * safezoneW + safezoneX","0.1898 * safezoneH + safezoneY","0.0257812 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1202,"O2",[1,"cba_tex_1\MEDICAL\2.paa",["0.2525 * safezoneW + safezoneX","0.1898 * safezoneH + safezoneY","0.0257812 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1203,"O3",[1,"cba_tex_1\MEDICAL\3.paa",["0.282406 * safezoneW + safezoneX","0.1898 * safezoneH + safezoneY","0.0257812 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1208,"I_t",[1,"cba_tex_1\MEDICAL\t.paa",["0.453594 * safezoneW + safezoneX","0.3306 * safezoneH + safezoneY","0.0525937 * safezoneW","0.1804 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1209,"I_jd",[1,"cba_tex_1\MEDICAL\jd.paa",["0.453594 * safezoneW + safezoneX","0.478 * safezoneH + safezoneY","0.0257812 * safezoneW","0.187 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1210,"I_jg",[1,"cba_tex_1\MEDICAL\jg.paa",["0.479375 * safezoneW + safezoneX","0.478 * safezoneH + safezoneY","0.0257812 * safezoneW","0.187 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1211,"I_bg",[1,"cba_tex_1\MEDICAL\bg.paa",["0.5 * safezoneW + safezoneX","0.3592 * safezoneH + safezoneY","0.0257812 * safezoneW","0.187 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1212,"I_bd",[1,"cba_tex_1\MEDICAL\bd.paa",["0.431934 * safezoneW + safezoneX","0.357 * safezoneH + safezoneY","0.0257812 * safezoneW","0.187 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1213,"I_h",[1,"cba_tex_1\MEDICAL\h.paa",["0.463906 * safezoneW + safezoneX","0.291 * safezoneH + safezoneY","0.0319688 * safezoneW","0.055 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1100,"ST_INJURIES",[1,"",["0.202999 * safezoneW + safezoneX","0.2778 * safezoneH + safezoneY","0.203157 * safezoneW","0.209 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1101,"ST_HIST",[1,"",["0.553624 * safezoneW + safezoneX","0.2778 * safezoneH + safezoneY","0.203157 * safezoneW","0.209 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1215,"BACK_p21",[1,"cba_tex_1\MEDICAL\2\p21.paa",["0.55775 * safezoneW + safezoneX","0.5638 * safezoneH + safezoneY","0.117563 * safezoneW","0.1342 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1216,"BACK_p2a",[1,"cba_tex_1\MEDICAL\2\p2a.paa",["0.671187 * safezoneW + safezoneX","0.5286 * safezoneH + safezoneY","0.0928124 * safezoneW","0.264 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1218,"BACK_p23",[1,"cba_tex_1\MEDICAL\2\p23.paa",["0.551562 * safezoneW + safezoneX","0.6892 * safezoneH + safezoneY","0.128906 * safezoneW","0.066 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1219,"I_salp",[1,"cba_tex_1\MEDICAL\2\salp.paa",["0.703156 * safezoneW + safezoneX","0.6826 * safezoneH + safezoneY","0.0360937 * safezoneW","0.0638 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1220,"I_sanp",[1,"cba_tex_1\MEDICAL\2\sanp.paa",["0.703156 * safezoneW + safezoneX","0.5924 * safezoneH + safezoneY","0.0360937 * safezoneW","0.0638 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1221,"b_perfu",[1,"cba_tex_1\MEDICAL\2\bperfu.paa",["0.352544 * safezoneW + safezoneX","0.72 * safezoneH + safezoneY","0.056719 * safezoneW","0.0286 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1222,"b_inject",[1,"cba_tex_1\MEDICAL\2\binject.paa",["0.35048 * safezoneW + safezoneX","0.6408 * safezoneH + safezoneY","0.0577503 * safezoneW","0.0286 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1223,"b_red",[1,"cba_tex_1\MEDICAL\2\bred.paa",["0.551562 * safezoneW + safezoneX","0.7134 * safezoneH + safezoneY","0.061875 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1225,"b_appli",[1,"cba_tex_1\MEDICAL\2\bappli.paa",["0.581469 * safezoneW + safezoneX","0.6254 * safezoneH + safezoneY","0.0629063 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2100,"CB_band",[1,"",["0.559813 * safezoneW + safezoneX","0.6584 * safezoneH + safezoneY","0.112406 * safezoneW","0.0264 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","1"],[]],
	[2102,"CB_injurie",[1,"",["0.559813 * safezoneW + safezoneX","0.5968 * safezoneH + safezoneY","0.112405 * safezoneW","0.0264 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","0.9"],[]],
	[1500,"LB_med",[1,"",["0.206094 * safezoneW + safezoneX","0.5704 * safezoneH + safezoneY","0.095907 * safezoneW","0.1386 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","1"],[]],
	[1501,"LB_perf",[1,"",["0.312312 * safezoneW + safezoneX","0.5704 * safezoneH + safezoneY","0.0897187 * safezoneW","0.0682 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","1"],[]],
	[1601,"T_med",[1,"truc",["0.312312 * safezoneW + safezoneX","0.6804 * safezoneH + safezoneY","0.0897184 * safezoneW","0.0198 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","1"],[]],
	[1400,"ED_med_val",[1,"",["0.3515 * safezoneW + safezoneX","0.7046 * safezoneH + safezoneY","0.0257814 * safezoneW","0.0132 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","1"],[]],
	[1602,"T_perf_sang",[1,"truc",["0.704187 * safezoneW + safezoneX","0.5748 * safezoneH + safezoneY","0.0350625 * safezoneW","0.0154 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","1"],[]],
	[1603,"T_perf_sal",[1,"truc",["0.704806 * safezoneW + safezoneX","0.66368 * safezoneH + safezoneY","0.0350625 * safezoneW","0.0154 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","1"],[]],
	[1206,"BACK_p5",[1,"cba_tex_1\MEDICAL\2\p5.paa",["0.413373 * safezoneW + safezoneX","0.7024 * safezoneH + safezoneY","0.135095 * safezoneW","0.0638 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1229,"b_stop",[1,"cba_tex_1\MEDICAL\2\bstop.paa",["0.428849 * safezoneW + safezoneX","0.7068 * safezoneH + safezoneY","0.136118 * safezoneW","0.0638 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/