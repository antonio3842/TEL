#define ARMA_COLOR {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",1}
#define GUI_GRID_H	(0.04)

//--- medical
#define IDC_MEDICAL_ST_INFO_DEFIB	3245
#define IDC_MEDICAL_BACK		3345
#define IDC_MEDICAL_O1		3346
#define IDC_MEDICAL_O2		3347
#define IDC_MEDICAL_O3		3348
#define IDC_MEDICAL_BACK_P1	3349
#define IDC_MEDICAL_BACK_P2	3350
#define IDC_MEDICAL_BACK_P3	3351
#define IDC_MEDICAL_B_COMP	3352
#define IDC_MEDICAL_I_T		3353
#define IDC_MEDICAL_I_JD		3354
#define IDC_MEDICAL_I_JG		3355
#define IDC_MEDICAL_I_BG		3356
#define IDC_MEDICAL_I_BD		3357
#define IDC_MEDICAL_I_H		3358
#define IDC_MEDICAL_B_INSUFL	3359
#define IDC_MEDICAL_B_CONTROL	3360
#define IDC_MEDICAL_B_MMASQUE	3361
#define IDC_MEDICAL_B_ACTU	3362
#define IDC_MEDICAL_B_MASQUE	3363
#define IDC_MEDICAL_BACK_P4	3380
#define IDC_MEDICAL_B_CHOC	3365
#define IDC_MEDICAL_I_P2_MASK	3366
#define IDC_MEDICAL_I_P2_BOTTLE	3367
#define IDC_MEDICAL_I_BPM		3368
#define IDC_MEDICAL_ST_SCORE	3369
#define IDC_MEDICAL_ED_DEFIB	3545
#undef IDC_MEDICAL_T_BPM
#define IDC_MEDICAL_T_BPM		3546
#define IDC_MEDICAL_T_O2		3547
#define IDC_MEDICAL_T_RESP	3548
#define IDC_MEDICAL_T_PS		3549
#define IDC_MEDICAL_T_PD		3550
#define IDC_MEDICAL_ED_O2		3551



class MEDICAL_3
{
	idd = 4203;
	onLoad = "";
    onUnLoad = "";
	class controls 
	{
		////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Matthew Way, v1.063, #Zucada)
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
	text = "cba_tex_1\MEDICAL\3\p1.paa";
	x = 0.163813 * safezoneW + safezoneX;
	y = 0.1414 * safezoneH + safezoneY;
	w = 0.285657 * safezoneW;
	h = 0.5302 * safezoneH;
};
class BACK_p2: RscPicture
{
	idc = IDC_MEDICAL_BACK_P2;
	text = "cba_tex_1\MEDICAL\3\p2.paa";
	x = 0.163814 * safezoneW + safezoneX;
	y = 0.5286 * safezoneH + safezoneY;
	w = 0.285659 * safezoneW;
	h = 0.2926 * safezoneH;
};
class BACK_p3: RscPicture
{
	idc = IDC_MEDICAL_BACK_P3;
	text = "cba_tex_1\MEDICAL\3\p3.paa";
	x = 0.510311 * safezoneW + safezoneX;
	y = 0.2272 * safezoneH + safezoneY;
	w = 0.284631 * safezoneW;
	h = 0.5456 * safezoneH;
};
class BACK_p4: RscPicture
{
	idc = IDC_MEDICAL_BACK_P4;
	text = "cba_tex_1\MEDICAL\3\p4.paa";
	x = 0.422656 * safezoneW + safezoneX;
	y = 0.665 * safezoneH + safezoneY;
	w = 0.121688 * safezoneW;
	h = 0.11 * safezoneH;
};
class B_comp: RscClickableText
{
	idc = IDC_MEDICAL_B_COMP;
	text = "cba_tex_1\MEDICAL\3\bcomp.paa";
	x = 0.191663 * safezoneW + safezoneX;
	y = 0.544 * safezoneH + safezoneY;
	w = 0.0732188 * safezoneW;
	h = 0.0352 * safezoneH;
	soundClick[] = {"",0.09,1};
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
class B_insufl: RscClickableText
{
	idc = IDC_MEDICAL_B_INSUFL;
	text = "cba_tex_1\MEDICAL\3\binsufl.paa";
	x = 0.267969 * safezoneW + safezoneX;
	y = 0.544 * safezoneH + safezoneY;
	w = 0.0732188 * safezoneW;
	h = 0.0352 * safezoneH;
	soundClick[] = {"",0.09,1};
};
class B_control: RscClickableText
{
	idc = IDC_MEDICAL_B_CONTROL;
	text = "cba_tex_1\MEDICAL\3\bcontrol.paa";
	x = 0.34428 * safezoneW + safezoneX;
	y = 0.544 * safezoneH + safezoneY;
	w = 0.0732188 * safezoneW;
	h = 0.0352 * safezoneH;
	soundClick[] = {"",0.09,1};
};
class B_masque: RscClickableText
{
	idc = IDC_MEDICAL_B_MMASQUE;
	text = "cba_tex_1\MEDICAL\3\bmmasque.paa";
	x = 0.193718 * safezoneW + safezoneX;
	y = 0.7024 * safezoneH + safezoneY;
	w = 0.0845627 * safezoneW;
	h = 0.0638 * safezoneH;
};
class B_actu: RscClickableText
{
	idc = IDC_MEDICAL_B_ACTU;
	text = "cba_tex_1\MEDICAL\3\bactu.paa";
	x = 0.193719 * safezoneW + safezoneX;
	y = 0.676 * safezoneH + safezoneY;
	w = 0.0845625 * safezoneW;
	h = 0.0352 * safezoneH;
};
class B_rmasque: RscClickableText
{
	idc = IDC_MEDICAL_B_MASQUE;
	text = "cba_tex_1\MEDICAL\3\brmasque.paa";
	x = 0.193718 * safezoneW + safezoneX;
	y = 0.7024 * safezoneH + safezoneY;
	w = 0.0845625 * safezoneW;
	h = 0.0638 * safezoneH;
};
class ED_defib: RscEdit
{
	idc = IDC_MEDICAL_ED_DEFIB;
	x = 0.438125 * safezoneW + safezoneX;
	y = 0.72 * safezoneH + safezoneY;
	w = 0.0247499 * safezoneW;
	h = 0.0176 * safezoneH;
	style = 2;
	sizeEx = 0.8 * GUI_GRID_H;
};
class B_choc: RscClickableText
{
	idc = IDC_MEDICAL_B_CHOC;
	text = "cba_tex_1\MEDICAL\3\bchoc.paa";
	x = 0.497937 * safezoneW + safezoneX;
	y = 0.7002 * safezoneH + safezoneY;
	w = 0.0309375 * safezoneW;
	h = 0.055 * safezoneH;
};
class ST_info_defib: RscStructuredText
{
	idc = IDC_MEDICAL_ST_INFO_DEFIB;
	x = 0.462875 * safezoneW + safezoneX;
	y = 0.7112 * safezoneH + safezoneY;
	w = 0.0360937 * safezoneW;
	h = 0.0352 * safezoneH;
};
class T_bpm: RscText
{
	idc = IDC_MEDICAL_T_BPM;
	text = ""; //--- ToDo: Localize;
	x = 0.583532 * safezoneW + safezoneX;
	y = 0.2998 * safezoneH + safezoneY;
	w = 0.0360937 * safezoneW;
	h = 0.055 * safezoneH;
	style = 2;
	sizeEx = 1.5 * GUI_GRID_H;
	font = "PuristaBold";
};
class T_O2: RscText
{
	idc = IDC_MEDICAL_T_O2;
	text = ""; //--- ToDo: Localize;
	x = 0.584563 * safezoneW + safezoneX;
	y = 0.4142 * safezoneH + safezoneY;
	w = 0.0360937 * safezoneW;
	h = 0.055 * safezoneH;
	style = 2;
	sizeEx = 1.5 * GUI_GRID_H;
	font = "PuristaBold";
};
class T_resp: RscText
{
	idc = IDC_MEDICAL_T_RESP;
	text = ""; //--- ToDo: Localize;
	x = 0.584563 * safezoneW + safezoneX;
	y = 0.5418 * safezoneH + safezoneY;
	w = 0.0360937 * safezoneW;
	h = 0.055 * safezoneH;
	style = 2;
	sizeEx = 1.5 * GUI_GRID_H;
	font = "PuristaBold";
};
class T_PS: RscText
{
	idc = IDC_MEDICAL_T_PS;
	text = ""; //--- ToDo: Localize;
	x = 0.584563 * safezoneW + safezoneX;
	y = 0.6672 * safezoneH + safezoneY;
	w = 0.0360937 * safezoneW;
	h = 0.033 * safezoneH;
	style = 2;
	sizeEx = 1.5 * GUI_GRID_H;
	font = "PuristaBold";
};
class T_PD: RscText
{
	idc = IDC_MEDICAL_T_PD;
	text = ""; //--- ToDo: Localize;
	x = 0.584562 * safezoneW + safezoneX;
	y = 0.7002 * safezoneH + safezoneY;
	w = 0.0360937 * safezoneW;
	h = 0.033 * safezoneH;
	style = 2;
	sizeEx = 1.5 * GUI_GRID_H;
	font = "PuristaBold";
};
class I_p2_mask: RscPicture
{
	idc = IDC_MEDICAL_I_P2_MASK;
	text = "cba_tex_1\MEDICAL\3\p2_mask.paa";
	x = 0.3185 * safezoneW + safezoneX;
	y = 0.6298 * safezoneH + safezoneY;
	w = 0.0732187 * safezoneW;
	h = 0.132 * safezoneH;
};
class I_p2_bottle: RscPicture
{
	idc = IDC_MEDICAL_I_P2_BOTTLE;
	text = "cba_tex_1\MEDICAL\3\p2_bottle.paa";
	x = 0.296844 * safezoneW + safezoneX;
	y = 0.6232 * safezoneH + safezoneY;
	w = 0.044344 * safezoneW;
	h = 0.1364 * safezoneH;
};
class ED_O2: RscEdit
{
	idc = IDC_MEDICAL_ED_O2;
	x = 0.205063 * safezoneW + safezoneX;
	y = 0.6496 * safezoneH + safezoneY;
	w = 0.0288751 * safezoneW;
	h = 0.022 * safezoneH;
};
class I_BPM: RscPicture
{
	idc = IDC_MEDICAL_I_BPM;
	text = "cba_tex_1\MEDICAL\3\bpm\rapide_1.paa";
	x = 0.621686 * safezoneW + safezoneX;
	y = 0.3306 * safezoneH + safezoneY;
	w = 0.141281 * safezoneW;
	h = 0.033 * safezoneH;
};
class ST_score: RscStructuredText
{
	idc = IDC_MEDICAL_ST_SCORE;
	text = "";
	x = 0.348407 * safezoneW + safezoneX;
	y = 0.2382 * safezoneH + safezoneY;
	w = 0.0629062 * safezoneW;
	h = 0.033 * safezoneH;
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////

    };
};

/* #Tywati
$[
	1.063,
	["medical",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,1,0],
	[-1200,"BACK",[1,"cba_tex_1\MEDICAL\background.paa",["0.190625 * safezoneW + safezoneX","-0.05 * safezoneH + safezoneY","0.582656 * safezoneW","1.056 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1201,"O1",[1,"cba_tex_1\MEDICAL\1.paa",["0.222594 * safezoneW + safezoneX","0.1898 * safezoneH + safezoneY","0.0257812 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1202,"O2",[1,"cba_tex_1\MEDICAL\2.paa",["0.2525 * safezoneW + safezoneX","0.1898 * safezoneH + safezoneY","0.0257812 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1203,"O3",[1,"cba_tex_1\MEDICAL\3.paa",["0.282406 * safezoneW + safezoneX","0.1898 * safezoneH + safezoneY","0.0257812 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[-1204,"BACK_p1",[1,"cba_tex_1\MEDICAL\3\p1.paa",["0.163813 * safezoneW + safezoneX","0.1414 * safezoneH + safezoneY","0.285657 * safezoneW","0.5302 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[-1205,"BACK_p2",[1,"cba_tex_1\MEDICAL\3\p2.paa",["0.163814 * safezoneW + safezoneX","0.5286 * safezoneH + safezoneY","0.285659 * safezoneW","0.2926 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[-1206,"BACK_p3",[1,"cba_tex_1\MEDICAL\3\p3.paa",["0.510311 * safezoneW + safezoneX","0.2272 * safezoneH + safezoneY","0.284631 * safezoneW","0.5456 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[-1219,"BACK_p4",[1,"cba_tex_1\MEDICAL\3\p4.paa",["0.422656 * safezoneW + safezoneX","0.665 * safezoneH + safezoneY","0.121688 * safezoneW","0.11 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1207,"B_comp",[1,"cba_tex_1\MEDICAL\3\bcomp.paa",["0.191663 * safezoneW + safezoneX","0.544 * safezoneH + safezoneY","0.0732188 * safezoneW","0.0352 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1208,"I_t",[1,"cba_tex_1\MEDICAL\t.paa",["0.453594 * safezoneW + safezoneX","0.3306 * safezoneH + safezoneY","0.0525937 * safezoneW","0.1804 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1209,"I_jd",[1,"cba_tex_1\MEDICAL\jd.paa",["0.453594 * safezoneW + safezoneX","0.478 * safezoneH + safezoneY","0.0257812 * safezoneW","0.187 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1210,"I_jg",[1,"cba_tex_1\MEDICAL\jg.paa",["0.479375 * safezoneW + safezoneX","0.478 * safezoneH + safezoneY","0.0257812 * safezoneW","0.187 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1211,"I_bg",[1,"cba_tex_1\MEDICAL\bg.paa",["0.5 * safezoneW + safezoneX","0.3592 * safezoneH + safezoneY","0.0257812 * safezoneW","0.187 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1212,"I_bd",[1,"cba_tex_1\MEDICAL\bd.paa",["0.431934 * safezoneW + safezoneX","0.357 * safezoneH + safezoneY","0.0257812 * safezoneW","0.187 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1213,"I_h",[1,"cba_tex_1\MEDICAL\h.paa",["0.463906 * safezoneW + safezoneX","0.291 * safezoneH + safezoneY","0.0319688 * safezoneW","0.055 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1214,"B_insufl",[1,"cba_tex_1\MEDICAL\3\binsufl.paa",["0.267969 * safezoneW + safezoneX","0.544 * safezoneH + safezoneY","0.0732188 * safezoneW","0.0352 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1215,"B_control",[1,"cba_tex_1\MEDICAL\3\bcontrol.paa",["0.34428 * safezoneW + safezoneX","0.544 * safezoneH + safezoneY","0.0732188 * safezoneW","0.0352 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1216,"B_mmasque",[1,"cba_tex_1\MEDICAL\3\bmmasque.paa",["0.193718 * safezoneW + safezoneX","0.7024 * safezoneH + safezoneY","0.0845627 * safezoneW","0.0638 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1217,"B_actu",[1,"cba_tex_1\MEDICAL\3\bactu.paa",["0.193719 * safezoneW + safezoneX","0.676 * safezoneH + safezoneY","0.0845625 * safezoneW","0.0352 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1218,"B_masque",[1,"cba_tex_1\MEDICAL\3\brmasque.paa",["0.193718 * safezoneW + safezoneX","0.7024 * safezoneH + safezoneY","0.0845625 * safezoneW","0.0638 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1400,"ED_defib",[1,"",["0.438125 * safezoneW + safezoneX","0.72 * safezoneH + safezoneY","0.0247499 * safezoneW","0.0176 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1220,"B_choc",[1,"cba_tex_1\MEDICAL\3\bchoc.paa",["0.497937 * safezoneW + safezoneX","0.7002 * safezoneH + safezoneY","0.0309375 * safezoneW","0.055 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1100,"ST_info_defib",[1,"",["0.462875 * safezoneW + safezoneX","0.7112 * safezoneH + safezoneY","0.0360937 * safezoneW","0.0352 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1401,"T_bpm",[1,"BPM",["0.583532 * safezoneW + safezoneX","0.2998 * safezoneH + safezoneY","0.0360937 * safezoneW","0.055 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1402,"T_O2",[1,"O2",["0.584563 * safezoneW + safezoneX","0.4142 * safezoneH + safezoneY","0.0360937 * safezoneW","0.055 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1403,"T_resp",[1,"resp",["0.584563 * safezoneW + safezoneX","0.5418 * safezoneH + safezoneY","0.0360937 * safezoneW","0.055 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1404,"T_PS",[1,"PS",["0.584563 * safezoneW + safezoneX","0.6672 * safezoneH + safezoneY","0.0360937 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1405,"T_PD",[1,"PD",["0.584562 * safezoneW + safezoneX","0.7002 * safezoneH + safezoneY","0.0360937 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1221,"I_p2_mask",[1,"cba_tex_1\MEDICAL\3\p2_mask.paa",["0.3185 * safezoneW + safezoneX","0.6298 * safezoneH + safezoneY","0.0732187 * safezoneW","0.132 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1222,"I_p2_bottle",[1,"cba_tex_1\MEDICAL\3\p2_bottle.paa",["0.296844 * safezoneW + safezoneX","0.6232 * safezoneH + safezoneY","0.044344 * safezoneW","0.1364 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1406,"ED_O2",[1,"",["0.205063 * safezoneW + safezoneX","0.6496 * safezoneH + safezoneY","0.0288751 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1223,"I_BPM",[1,"cba_tex_1\MEDICAL\3\bpm\rapide_1.paa",["0.621686 * safezoneW + safezoneX","0.3306 * safezoneH + safezoneY","0.141281 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1224,"ST_score",[1,"#(rgb,8,8,3)color(0,0,1,1)",["0.348407 * safezoneW + safezoneX","0.2382 * safezoneH + safezoneY","0.0629062 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/




