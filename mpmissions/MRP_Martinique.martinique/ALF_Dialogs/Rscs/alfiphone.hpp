/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/

class ALF_iPhone_RscButtonTaxi : Life_RscButton {
	shadow = 0;
	colorShadow[] = {0, 0, 0, 0};
	colorBorder[] = {0, 0, 0, 0};
	borderSize = 0;
	offsetX = 0;
	offsetY = 0;
	offsetPressedX = 0;
	offsetPressedY = 0;
	font = "RobotoCondensed";
	sizeEx = 0.032;
};

class ALF_iPhoneMenu_Dialog {
	idd = 56400;
	name= "ALF_iPhoneMenu_Dialog";
	onLoad = "uiNamespace setVariable ['iphonemenu',0]; [] spawn { waitUntil {!isNull (findDisplay 56400)}; private _d = findDisplay 56400; { private _c = _d displayCtrl _x; if (!isNull _c) then {_c ctrlShow false}; } forEach [682570,682571,682572,682574,682575]; };";
	movingEnable = true;
	enableSimulation = false;
	class controlsBackground {};

	class controls {
		class bg1 : Life_RscPicture 
		{
			idc = 564001;
			text = "\ALF_Client2\textures\iPhone\ALF_fond_1.paa";
			x = 0.447657 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.455496 * safezoneW;
			h = 0.767101 * safezoneH;
		};
		// class bg2 : Life_RscPicture {
		// 	idc = 564002;
		// 	text = "\ALF_Client2\textures\iPhone\ALF_fond_2.paa";
		// 	x = 0.447657 * safezoneW + safezoneX;
		// 	y = 0.247 * safezoneH + safezoneY;
		// 	w = 0.455496 * safezoneW;
		// 	h = 0.767101 * safezoneH;
		// };
		// class bg3 : Life_RscPicture {
		// 	idc = 564003;
		// 	text = "\ALF_Client2\textures\iPhone\ALF_fond_3.paa";
		// 	x = 0.447657 * safezoneW + safezoneX;
		// 	y = 0.247 * safezoneH + safezoneY;
		// 	w = 0.455496 * safezoneW;
		// 	h = 0.767101 * safezoneH;
		// };
		// class bg4 : Life_RscPicture {
		// 	idc = 564004;
		// 	text = "\ALF_Client2\textures\iPhone\ALF_fond_4.paa";
		// 	x = 0.447657 * safezoneW + safezoneX;
		// 	y = 0.247 * safezoneH + safezoneY;
		// 	w = 0.455496 * safezoneW;
		// 	h = 0.767101 * safezoneH;
		// };
		// class bg5 : Life_RscPicture {
		// 	idc = 564005;
		// 	text = "\ALF_Client2\textures\iPhone\ALF_fond_5.paa";
		// 	x = 0.447657 * safezoneW + safezoneX;
		// 	y = 0.247 * safezoneH + safezoneY;
		// 	w = 0.455496 * safezoneW;
		// 	h = 0.767101 * safezoneH;
		// };
		// class bg6 : Life_RscPicture {
		// 	idc = 564006;
		// 	text = "\ALF_Client2\textures\iPhone\ALF_fond_6.paa";
		// 	x = 0.447657 * safezoneW + safezoneX;
		// 	y = 0.247 * safezoneH + safezoneY;
		// 	w = 0.455496 * safezoneW;
		// 	h = 0.767101 * safezoneH;
		// };
		// class bg7 : Life_RscPicture {
		// 	idc = 564007;
		// 	text = "\ALF_Client2\textures\iPhone\ALF_fond_7.paa";
		// 	x = 0.447657 * safezoneW + safezoneX;
		// 	y = 0.247 * safezoneH + safezoneY;
		// 	w = 0.455496 * safezoneW;
		// 	h = 0.767101 * safezoneH;
		// };
		// class bg8 : Life_RscPicture {
		// 	idc = 564008;
		// 	text = "\ALF_Client2\textures\iPhone\ALF_fond_8.paa";
		// 	x = 0.447657 * safezoneW + safezoneX;
		// 	y = 0.247 * safezoneH + safezoneY;
		// 	w = 0.455496 * safezoneW;
		// 	h = 0.767101 * safezoneH;
		// };
		// class bg9 : Life_RscPicture {
		// 	idc = 564009;
		// 	text = "\ALF_Client2\textures\iPhone\ALF_fond_9.paa";
		// 	x = 0.447657 * safezoneW + safezoneX;
		// 	y = 0.247 * safezoneH + safezoneY;
		// 	w = 0.455496 * safezoneW;
		// 	h = 0.767101 * safezoneH;
		// };
		// class bg10 : Life_RscPicture {
		// 	idc = 564010;
		// 	text = "\ALF_Client2\textures\iPhone\ALF_fond_10.paa";
		// 	x = 0.447657 * safezoneW + safezoneX;
		// 	y = 0.247 * safezoneH + safezoneY;
		// 	w = 0.455496 * safezoneW;
		// 	h = 0.767101 * safezoneH;
		// };
		// class bg11 : Life_RscPicture {
		// 	idc = 564011;
		// 	text = "\ALF_Client2\textures\iPhone\ALF_fond_11.paa";
		// 	x = 0.447657 * safezoneW + safezoneX;
		// 	y = 0.247 * safezoneH + safezoneY;
		// 	w = 0.455496 * safezoneW;
		// 	h = 0.767101 * safezoneH;
		// };
		// class bg12 : Life_RscPicture {
		// 	idc = 564012;
		// 	text = "\ALF_Client2\textures\iPhone\ALF_fond_12.paa";
		// 	x = 0.447657 * safezoneW + safezoneX;
		// 	y = 0.247 * safezoneH + safezoneY;
		// 	w = 0.455496 * safezoneW;
		// 	h = 0.767101 * safezoneH;
		// };
		// class bg13 : Life_RscPicture {
		// 	idc = 564013;
		// 	text = "\ALF_Client2\textures\iPhone\ALF_fond_13.paa";
		// 	x = 0.447657 * safezoneW + safezoneX;
		// 	y = 0.247 * safezoneH + safezoneY;
		// 	w = 0.455496 * safezoneW;
		// 	h = 0.767101 * safezoneH;
		// };
		// class bg14 : Life_RscPicture {
		// 	idc = 564014;
		// 	text = "\ALF_Client2\textures\iPhone\ALF_fond_14.paa";
		// 	x = 0.447657 * safezoneW + safezoneX;
		// 	y = 0.247 * safezoneH + safezoneY;
		// 	w = 0.455496 * safezoneW;
		// 	h = 0.767101 * safezoneH;
		// };
		// class bg15 : Life_RscPicture {
		// 	idc = 564015;
		// 	text = "\ALF_Client2\textures\iPhone\ALF_fond_15.paa";
		// 	x = 0.447657 * safezoneW + safezoneX;
		// 	y = 0.247 * safezoneH + safezoneY;
		// 	w = 0.455496 * safezoneW;
		// 	h = 0.767101 * safezoneH;
		// };
		class menu1sim : Life_RscPicture {
			idc = 56401;
			text = "\ALF_Client2\textures\iPhone\ALF_iPhone_1.paa";
			x = 0.448438 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.454324 * safezoneW;
			h = 0.766407 * safezoneH;
		};
		class menu1btntel : Life_RscButtonInvisible {
			idc = 564011;
			text = "";
			onButtonClick = "";
			x = 0.595833 * safezoneW + safezoneX;
			y = 0.900926 * safezoneH + safezoneY;
			w = 0.0291407 * safezoneW;
			h = 0.0494443 * safezoneH;
		};
		class menu1btnsms : Life_RscButtonInvisible {
			idc = 564012;
			text = "";
			onButtonClick = "";
			x = 0.639687 * safezoneW + safezoneX;
			y = 0.900167 * safezoneH + safezoneY;
			w = 0.029922 * safezoneW;
			h = 0.0501388 * safezoneH;
		};
		class menu1btncontacts : Life_RscButtonInvisible {
			idc = 564013;
			text = "";
			onButtonClick = "";
			x = 0.727578 * safezoneW + safezoneX;
			y = 0.900861 * safezoneH + safezoneY;
			w = 0.0291407 * safezoneW;
			h = 0.0501388 * safezoneH;
		};
		class menu1btnreglages : Life_RscButtonInvisible {
			idc = 564014;
			text = "";
			onButtonClick = "";
			x = 0.682656 * safezoneW + safezoneX;
			y = 0.900167 * safezoneH + safezoneY;
			w = 0.0295313 * safezoneW;
			h = 0.0501388 * safezoneH;
		};
		class menu1btntwitter : Life_RscButtonInvisible {
			idc = 564015;
			text = "";
			onButtonClick = "";
			x = 0.59570313 * safezoneW + safezoneX;
			y = 0.43923612 * safezoneH + safezoneY;
			w = 0.02929688 * safezoneW;
			h = 0.04861112 * safezoneH;
		};
		/* Taxi : zone cliquable sur l'icône Uber (ligne 2, colonne 3) */
		class menu1btntaxi : Life_RscButtonInvisible {
			idc = 564016;
			text = "";
			onButtonClick = "";
			x = 0.683411 * safezoneW + safezoneX;
			y = 0.43923612 * safezoneH + safezoneY;
			w = 0.02929688 * safezoneW;
			h = 0.04861112 * safezoneH;
		};
		class menu1nosim : Life_RscPicture {
			idc = 56402;
			text = "\ALF_Client2\textures\iPhone\ALF_iPhone_2.paa";
			x = 0.448438 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.454324 * safezoneW;
			h = 0.766407 * safezoneH;
		};
		class menu1nosimOK : Life_RscButtonInvisible {
			idc = 564021;
			text = "";
			onButtonClick = "closeDialog 0;";
			x = 0.605469 * safezoneW + safezoneX;
			y = 0.65075 * safezoneH + safezoneY;
			w = 0.139949 * safezoneW;
			h = 0.0478148 * safezoneH;
		};
		class menu1appelentrant : Life_RscPicture {
			idc = 56403;
			text = "\ALF_Client2\textures\iPhone\ALF_iPhone_4.paa";
			x = 0.448438 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.454324 * safezoneW;
			h = 0.766407 * safezoneH;
		};
		class menu1appel : Life_RscPicture {
			idc = 56404;
			text = "\ALF_Client2\textures\iPhone\ALF_iPhone_5.paa";
			x = 0.448438 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.454324 * safezoneW;
			h = 0.766407 * safezoneH;
		};
		class menu1Name : Life_RscStructuredText {
			idc = 564041;
			text = "";
			x = 0.581015 * safezoneW + safezoneX;
			y = 0.32986 * safezoneH + safezoneY;
			w = 0.18875 * safezoneW;
			h = 0.0495556 * safezoneH;
		};
		class menu1Num : Life_RscStructuredText {
			idc = 564042;
			text = "";
			x = 0.606718 * safezoneW + safezoneX;
			y = 0.375 * safezoneH + safezoneY;
			w = 0.137084 * safezoneW;
			h = 0.0320742 * safezoneH;
		};
		class menu1Time : Life_RscStructuredText {
			idc = 564043;
			text = "";
			x = 0.65151 * safezoneW + safezoneX;
			y = 0.475231 * safezoneH + safezoneY;
			w = 0.0473709 * safezoneW;
			h = 0.0228149 * safezoneH;
		};
		class menu1rouge : Life_RscButtonInvisible {
			idc = 564044;
			text = "";
			x = 0.611094 * safezoneW + safezoneX;
			y = 0.812972 * safezoneH + safezoneY;
			w = 0.036693 * safezoneW;
			h = 0.0626297 * safezoneH;
		};
		class menu1vert : Life_RscButtonInvisible {
			idc = 564045;
			text = "";
			x = 0.701328 * safezoneW + safezoneX;
			y = 0.812972 * safezoneH + safezoneY;
			w = 0.0374742 * safezoneW;
			h = 0.0626297 * safezoneH;
		};
		class menu1rouge2 : Life_RscButtonInvisible {
			idc = 564046;
			text = "";
			x = 0.657578 * safezoneW + safezoneX;
			y = 0.8095 * safezoneH + safezoneY;
			w = 0.0363023 * safezoneW;
			h = 0.0619353 * safezoneH;
		};
		class menu1volp : Life_RscButtonInvisible {
			idc = 564048;
			text = "";
			x = 0.658358 * safezoneW + safezoneX;
			y = 0.547001 * safezoneH + safezoneY;
			w = 0.0359116 * safezoneW;
			h = 0.0612407 * safezoneH;
		};
		class menu1volm : Life_RscButtonInvisible {
			idc = 564049;
			text = "";
			x = 0.709139  * safezoneW + safezoneX;
			y = 0.547695 * safezoneH + safezoneY;
			w = 0.035521 * safezoneW;
			h = 0.0605463 * safezoneH;
		};
		class menu2telephone : Life_RscPicture {
			idc = 56405;
			text = "\ALF_Client2\textures\iPhone\ALF_iPhone_3.paa";
			x = 0.448438 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.454324 * safezoneW;
			h = 0.766407 * safezoneH;
		};
		class menu2btnappel : Life_RscButtonInvisible {
			idc = 564051;
			text = "";
			x = 0.657293 * safezoneW + safezoneX;
			y = 0.778593 * safezoneH + safezoneY;
			w = 0.0355211 * safezoneW;
			h = 0.0603147 * safezoneH;
		};
		class menu2numedit : Life_RscEdit {
			idc = 564052;
			text = "";
			style = 0;
			colorBackground[] = {1,1,1,1};
			colorText[] = {0,0,0,1};
			shadow = 0;
			sizeEx = 0.05;
			x = 0.609115 * safezoneW + safezoneX;
			y = 0.405093 * safezoneH + safezoneY;
			w = 0.126667 * safezoneW;
			h = 0.0373982 * safezoneH;
		};
		class menu3contacts : Life_RscPicture {
			idc = 56406;
			text = "\ALF_Client2\textures\iPhone\ALF_iPhone_6.paa";
			x = 0.448438 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.454324 * safezoneW;
			h = 0.766407 * safezoneH;
		};
		class menu3contactslist : Life_RscListBox {
			idc = 564061;
			text = "";
			colorText[] = {1,1,1,1};
			colorSelect[] = {1,1,1,1};
			colorSelect2[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
			colorSelectBackground[] = {1,1,1,0.22};
			colorSelectBackground2[] = {1,1,1,0.22};
			font = "HelveticaLTLight";
			sizeEx = 0.065;
			x = 0.588906 * safezoneW + safezoneX;
			y = 0.406722 * safezoneH + safezoneY;
			w = 0.17276 * safezoneW;
			h = 0.544 * safezoneH;
		};
		class menu3Name : Life_RscStructuredText {
			idc = 564062;
			text = "";
			x = 0.627396 * safezoneW + safezoneX;
			y = 0.421148 * safezoneH + safezoneY;
			w = 0.134479 * safezoneW;
			h = 0.0262963 * safezoneH;
		};
		class menu3Num : Life_RscStructuredText {
			idc = 564063;
			text = "";
			x = 0.649532 * safezoneW + safezoneX;
			y = 0.3755 * safezoneH + safezoneY;
			w = 0.108281 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class menu3btnadd : Life_RscButtonInvisible {
			idc = 564064;
			text = "";
			x = 0.746719 * safezoneW + safezoneX;
			y = 0.323389 * safezoneH + safezoneY;
			w = 0.0153381 * safezoneW;
			h = 0.0252499 * safezoneH;
		};
		class menu3fiche : Life_RscPicture {
			idc = 56407;
			text = "\ALF_Client2\textures\iPhone\ALF_iPhone_7.paa";
			x = 0.448438 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.454324 * safezoneW;
			h = 0.766407 * safezoneH;
		};
		class menu3fichename : Life_RscStructuredText {
			idc = 564071;
			text = "";
			x = 0.621016 * safezoneW + safezoneX;
			y = 0.436 * safezoneH + safezoneY;
			w = 0.108672 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class menu3fichenum : Life_RscStructuredText {
			idc = 564072;
			text = "";
			x = 0.59836 * safezoneW + safezoneX;
			y = 0.577057 * safezoneH + safezoneY;
			w = 0.108672 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class menu3fichebtnsms : Life_RscButtonInvisible {
			idc = 564073;
			text = "";
			x = 0.592579 * safezoneW + safezoneX;
			y = 0.4875 * safezoneH + safezoneY;
			w = 0.038125 * safezoneW;
			h = 0.046898 * safezoneH;
		};
		class menu3fichebtnappel : Life_RscButtonInvisible {
			idc = 564074;
			text = "";
			x = 0.634767 * safezoneW + safezoneX;
			y = 0.4875 * safezoneH + safezoneY;
			w = 0.0385157 * safezoneW;
			h = 0.046898 * safezoneH;
		};
		class menu3fichebtnsms2 : Life_RscButtonInvisible {
			idc = 564075;
			text = "";
			x = 0.588932 * safezoneW + safezoneX;
			y = 0.866205 * safezoneH + safezoneY;
			w = 0.17276 * safezoneW;
			h = 0.0332405 * safezoneH;
		};
		class menu3fichebtnfiche : Life_RscButtonInvisible {
			idc = 564076;
			text = "";
			x = 0.588932 * safezoneW + safezoneX;
			y = 0.93426 * safezoneH + safezoneY;
			w = 0.17276 * safezoneW;
			h = 0.0272222 * safezoneH;
		};
		class menu3retour : Life_RscButtonInvisible {
			idc = 564077;
			text = "";
			x = 0.593984 * safezoneW + safezoneX;
			y = 0.330139 * safezoneH + safezoneY;
			w = 0.0485416 * safezoneW;
			h = 0.0144906 * safezoneH;
		};
		class menu3addcontact : Life_RscPicture {
			idc = 56408;
			text = "\ALF_Client2\textures\iPhone\ALF_iPhone_8.paa";
			x = 0.448438 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.454324 * safezoneW;
			h = 0.766407 * safezoneH;
		};
		class menu3addname : Life_RscEdit {
			idc = 564081;
			text = "";
			colorText[] = {0,0,0,1};
			colorBackground[] = {1,1,1,1};
			font = "HelveticaLTLight";
			sizeEx = 0.025;
			style = 0;
			shadow = 0;
			x = 0.648749 * safezoneW + safezoneX;
			y = 0.357 * safezoneH + safezoneY;
			w = 0.108672 * safezoneW;
			h = 0.0213056 * safezoneH;
		};
		class menu3addnum : Life_RscEdit {
			idc = 564082;
			text = "";
			colorText[] = {0,0,0,1};
			colorBackground[] = {1,1,1,1};
			font = "HelveticaLTLight";
			sizeEx = 0.025;
			style = 0;
			shadow = 0;
			x = 0.667344 * safezoneW + safezoneX;
			y = 0.392084 * safezoneH + safezoneY;
			w = 0.0864844 * safezoneW;
			h = 0.0206111 * safezoneH;
		};
		class menu3btnOK : Life_RscButtonInvisible {
			idc = 564083;
			text = "";
			x = 0.746719 * safezoneW + safezoneX;
			y = 0.323389 * safezoneH + safezoneY;
			w = 0.0153381 * safezoneW;
			h = 0.0252499 * safezoneH;
		};
		class menu3btnannuler : Life_RscButtonInvisible {
			idc = 564084;
			text = "";
			x = 0.592812 * safezoneW + safezoneX;
			y = 0.328945 * safezoneH + safezoneY;
			w = 0.00479125 * safezoneW;
			h = 0.0134444 * safezoneH;
		};
		class menuNewMessage : Life_RscPicture {
			idc = 56409;
			text = "\ALF_Client2\textures\iPhone\ALF_iPhone_9.paa";
			x = 0.448438 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.454324 * safezoneW;
			h = 0.766407 * safezoneH;
		};
		class menuNMbtnannuler : Life_RscButtonInvisible {
			idc = 564091;
			text = "";
			x = 0.729062 * safezoneW + safezoneX;
			y = 0.321695 * safezoneH + safezoneY;
			w = 0.0275782 * safezoneW;
			h = 0.0119444 * safezoneH;
		};
		class menuNMnumedit : Life_RscEdit {
			idc = 564092;
			text = "";
			colorText[] = {0,0,0,1};
			colorBackground[] = {1,1,1,1};
			font = "HelveticaLTLight";
			sizeEx = 0.035;
			style = 16;
			shadow = 0;
			x = 0.620547 * safezoneW + safezoneX;
			y = 0.399611 * safezoneH + safezoneY;
			w = 0.144766 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class menuNMnum : Life_RscStructuredText {
			idc = 564093;
			text = "";
			x = 0.620545 * safezoneW + safezoneX;
			y = 0.398611 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class menuNMsmsedit : Life_RscEdit {
			idc = 564094;
			text = "";
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
			font = "HelveticaLTLight";
			sizeEx = 0.035;
			style = 528;
			shadow = 0;
			x = 0.58164 * safezoneW + safezoneX;
			y = 0.6125 * safezoneH + safezoneY;
			w = 0.186953 * safezoneW;
			h = 0.250833 * safezoneH;
		};
		class menuNMbtnenvoyer : Life_RscButtonInvisible {
			idc = 564095;
			text = "";
			x = 0.705469 * safezoneW + safezoneX;
			y = 0.877361 * safezoneH + safezoneY;
			w = 0.0628642 * safezoneW;
			h = 0.0239814 * safezoneH;
		};
		class iPhoneDate : Life_RscStructuredText {
			idc = 564000;
			text = "";
			x = 0.589 * safezoneW + safezoneX;
			y = 0.296 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class MutePic : Life_RscPicture {
			idc = 564096;
			text = "\ALF_Client2\textures\iPhone\ALF_bouton_appel_1.paa";
			x = 0.448438 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.454324 * safezoneW;
			h = 0.766407 * safezoneH;
		};
		class MuteBtn : Life_RscButtonInvisible {
			idc = 564097;
			text = "";
			x = 0.607577 * safezoneW + safezoneX;
			y = 0.548389 * safezoneH + safezoneY;
			w = 0.035521 * safezoneW;
			h = 0.0612408 * safezoneH;
		};
		class SpeackersPic : Life_RscPicture {
			idc = 564098;
			text = "\ALF_Client2\textures\iPhone\ALF_bouton_appel_2.paa";
			x = 0.448438 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.454324 * safezoneW;
			h = 0.766407 * safezoneH;
		};
		class SpeackersBtn : Life_RscButtonInvisible {
			idc = 564099;
			text = "";
			x = 0.606405 * safezoneW + safezoneX;
			y = 0.640056 * safezoneH + safezoneY;
			w = 0.0359116 * safezoneW;
			h = 0.0612408 * safezoneH;
		};
		class menu5 : Life_RscPicture {
			idc = 565050;
			text = "\ALF_Client2\textures\iPhone\ALF_iphone_10.paa";
			x = 0.448438 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.454324 * safezoneW;
			h = 0.766407 * safezoneH;
		};
		class menu5_btn1 : Life_RscPicture {
			idc = 565053;
			text = "\ALF_Client2\textures\iPhone\ALF_bouton_reglages_OFF1.paa";
			x = 0.448438 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.454324 * safezoneW;
			h = 0.766407 * safezoneH;
		};
		class menu5_btn2 : Life_RscPicture {
			idc = 565052;
			text = "\ALF_Client2\textures\iPhone\ALF_bouton_reglages_ON1.paa";
			x = 0.448438 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.454324 * safezoneW;
			h = 0.766407 * safezoneH;
		};
		class menu5_btn3 : Life_RscPicture {
			idc = 565059;
			text = "\ALF_Client2\textures\iPhone\ALF_bouton_reglages_OFF2.paa";
			x = 0.448438 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.454324 * safezoneW;
			h = 0.766407 * safezoneH;
		};
		class menu5_btn4 : Life_RscPicture {
			idc = 565058;
			text = "\ALF_Client2\textures\iPhone\ALF_bouton_reglages_ON2.paa";
			x = 0.448438 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.454324 * safezoneW;
			h = 0.766407 * safezoneH;
		};
		class menu5_Anonbtn : Life_RscButtonInvisible {
			idc = 565051;
			text = "";
			x = 0.743906 * safezoneW + safezoneX;
			y = 0.529834 * safezoneH + safezoneY;
			w = 0.0189843 * safezoneW;
			h = 0.0202779 * safezoneH;
		};
		class menu5_viberbtn : Life_RscButtonInvisible {
			idc = 565060;
			text = "";
			x = 0.743515 * safezoneW + safezoneX;
			y = 0.486084 * safezoneH + safezoneY;
			w = 0.0185937 * safezoneW;
			h = 0.0202778 * safezoneH;
		};
		class menu5_febtn : Life_RscButtonInvisible {
			idc = 565055;
			text = "";
			x = 0.589218 * safezoneW + safezoneX;
			y = 0.629834 * safezoneH + safezoneY;
			w = 0.0611718 * safezoneW;
			h = 0.0279167 * safezoneH;
		};
		class menu5_ringbtn : Life_RscButtonInvisible {
			idc = 565057;
			text = "";
			x = 0.589218 * safezoneW + safezoneX;
			y = 0.586778 * safezoneH + safezoneY;
			w = 0.0471093 * safezoneW;
			h = 0.0272223 * safezoneH;
		};
		class menu5_fetext : Life_RscStructuredText {
			idc = 565054;
			text = "";
			x = 0.657657 * safezoneW + safezoneX;
			y = 0.633334 * safezoneH + safezoneY;
			w = 0.110625 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class menu5_ringtext : Life_RscStructuredText {
			idc = 565056;
			text = "";
			x = 0.644375 * safezoneW + safezoneX;
			y = 0.590083 * safezoneH + safezoneY;
			w = 0.12375 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class menu5_avionbtn : Life_RscButtonInvisible {
			idc = 565061;
			text = "";
			x = 0.743124 * safezoneW + safezoneX;
			y = 0.443723 * safezoneH + safezoneY;
			w = 0.0185937 * safezoneW;
			h = 0.0195834 * safezoneH;
		};
		class menu5_btn5 : Life_RscPicture {
			idc = 565062;
			text = "\ALF_Client2\textures\iPhone\ALF_bouton_reglages_OFF3.paa";
			x = 0.448438 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.454324 * safezoneW;
			h = 0.766407 * safezoneH;
		};
		class menu5_btn6 : Life_RscPicture {
			idc = 565063;
			text = "\ALF_Client2\textures\iPhone\ALF_bouton_reglages_ON3.paa";
			x = 0.448438 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.454324 * safezoneW;
			h = 0.766407 * safezoneH;
		};
		class menu_radio : Life_RscPicture {
			idc = 58256;
			text = "\ALF_Client2\textures\iPhone\ALF_iphone_radio_1.paa";
			x = 0.448438 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.454324 * safezoneW;
			h = 0.766407 * safezoneH;
		};
		class menu_radio_pic1 : Life_RscPicture {
			idc = 582500;
			text = "\ALF_Client2\textures\iPhone\ALF_bouton_radio_1.paa";
			x = 0.448438 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.454324 * safezoneW;
			h = 0.766407 * safezoneH;
		};
		class menu_radio_pic2 : Life_RscPicture {
			idc = 582501;
			text = "\ALF_Client2\textures\iPhone\ALF_bouton_radio_2.paa";
			x = 0.448438 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.454324 * safezoneW;
			h = 0.766407 * safezoneH;
		};
		class menu_radio_btn1 : Life_RscButtonInvisible {
			idc = 582502;
			text = "";
			x = 0.640234 * safezoneW + safezoneX;
			y = 0.412499 * safezoneH + safezoneY;
			w = 0.0709375 * safezoneW;
			h = 0.0286112 * safezoneH;
		};
		class menu_radio_btn2 : Life_RscButtonInvisible {
			idc = 582503;
			text = "";
			x = 0.640234 * safezoneW + safezoneX;
			y = 0.412499 * safezoneH + safezoneY;
			w = 0.0709375 * safezoneW;
			h = 0.0286112 * safezoneH;
		};
		class menu_radio_app : Life_RscButtonInvisible {
			idc = 582504;
			text = "";
			x = 0.726017 * safezoneW + safezoneX;
			y = 0.354463 * safezoneH + safezoneY;
			w = 0.0289843 * safezoneW;
			h = 0.0491018 * safezoneH;
		};
		class menu_radio_edit : Life_RscEdit {
			idc = 582505;
			text = "";
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0};
			font = "HelveticaLTLight";
			sizeEx = 0.1;
			style = 514;
			shadow = 0;
			x = 0.596223 * safezoneW + safezoneX;
			y = 0.473843 * safezoneH + safezoneY;
			w = 0.159089 * safezoneW;
			h = 0.0952778 * safezoneH;
		};
		class menu_radio_text : Life_RscStructuredText {
			idc = 582506;
			text = "";
			x = 0.613515 * safezoneW + safezoneX;
			y = 0.660249 * safezoneH + safezoneY;
			w = 0.12375 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class menu_radio_volp : Life_RscButtonInvisible {
			idc = 582507;
			text = "";
			x = 0.596874 * safezoneW + safezoneX;
			y = 0.569443 * safezoneH + safezoneY;
			w = 0.0771875 * safezoneW;
			h = 0.0515278 * safezoneH;
		};
		class menu_radio_volm : Life_RscButtonInvisible {
			idc = 582508;
			text = "";
			x = 0.676952 * safezoneW + safezoneX;
			y = 0.569443 * safezoneH + safezoneY;
			w = 0.0771875 * safezoneW;
			h = 0.0515278 * safezoneH;
		};
		class menu6pic : Life_RscPicture {
			idc = 682560;
			text = "\ALF_Client2\textures\iPhone\ALF_iphone_11.paa";
			x = 0.448438 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.454324 * safezoneW;
			h = 0.766407 * safezoneH;
		};
		class menu6smslist : Life_RscListBox {
			idc = 682561;
			text = "";
			colorText[] = {1,1,1,1};
			colorSelect[] = {1,1,1,1};
			colorSelect2[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
			colorSelectBackground[] = {1,1,1,0.22};
			colorSelectBackground2[] = {1,1,1,0.22};
			shadow = 0;
			font = "HelveticaLTLight";
			sizeEx = 0.04;
			onLBSelChanged = "call ALF_fnc_lbChangedSmsiPhone;";
			x = 0.588906 * safezoneW + safezoneX;
			y = 0.352833 * safezoneH + safezoneY;
			w = 0.173203 * safezoneW;
			h = 0.256556 * safezoneH;
		};
		class menu6smsview : Life_RscStructuredText {
			idc = 682562;
			text = "";
			x = 0.589063 * safezoneW + safezoneX;
			y = 0.609027 * safezoneH + safezoneY;
			w = 0.173203 * safezoneW;
			h = 0.256556 * safezoneH;
		};
		class menu6_btnnew : Life_RscButtonInvisible {
			idc = 682563;
			text = "";
			x = 0.746719 * safezoneW + safezoneX;
			y = 0.324778 * safezoneH + safezoneY;
			w = 0.0141664 * safezoneW;
			h = 0.0245555 * safezoneH;
		};
		class menu6_btnrep : Life_RscButtonInvisible {
			idc = 682564;
			text = "";
			x = 0.588907 * safezoneW + safezoneX;
			y = 0.899083 * safezoneH + safezoneY;
			w = 0.17276 * safezoneW;
			h = 0.0342778 * safezoneH;
		};
		class menu6_btndel : Life_RscButtonInvisible {
			idc = 682565;
			text = "";
			x = 0.588907 * safezoneW + safezoneX;
			y = 0.933805 * safezoneH + safezoneY;
			w = 0.17276 * safezoneW;
			h = 0.0280276 * safezoneH;
		};
		class menu8_recent : Life_RscPicture {
			idc = 682566;
			text = "\ALF_Client2\textures\iPhone\ALF_iphone_12.paa";
			x = 0.448438 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.454324 * safezoneW;
			h = 0.766407 * safezoneH;
		};
		class menu8_recentlb : Life_RscListBox {
			idc = 682567;
			text = "";
			colorText[] = {1,1,1,1};
			colorSelect[] = {1,1,1,1};
			colorSelect2[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
			colorSelectBackground[] = {1,1,1,0.22};
			colorSelectBackground2[] = {1,1,1,0.22};
			shadow = 0;
			font = "HelveticaLTLight";
			sizeEx = 0.04;
			x = 0.588906 * safezoneW + safezoneX;
			y = 0.352528 * safezoneH + safezoneY;
			w = 0.172891 * safezoneW;
			h = 0.512639 * safezoneH;
		};
		/*		START TWITTER		*/
		class menu10_twitter : Life_RscPicture {
			idc = 682568;
			text = "\ALF_Client2\textures\iPhone\ALF_iphone_13.paa";
			x = 0.448438 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.454324 * safezoneW;
			h = 0.766407 * safezoneH;
		};

		class tweet_group: RscControlsGroup {
			idc = 682569;
			x = safeZoneX + safeZoneW * 0.580625;
			y = safeZoneY + safeZoneH * 0.36333334;
			w = safeZoneW * 0.19;
			h = safeZoneH * 0.53333334;
			class controls {};
		};

		/*		END TWITTER		*/

		/*		START TAXI (écran style Contacts)		*/
		class menu11_taxi : Life_RscPicture {
			idc = 682570;
			text = "\ALF_Client2\textures\iPhone\ALF_iPhone_15.paa";
			x = 0.448438 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.454324 * safezoneW;
			h = 0.766407 * safezoneH;
		};
		class menu11_taxi_stat : Life_RscStructuredText {
			idc = 682571;
			text = "";
			x = 0.555 * safezoneW + safezoneX;
			y = 0.44 * safezoneH + safezoneY;
			w = 0.24 * safezoneW;
			h = 0.22 * safezoneH;
		};
		class menu11_taxi_call_shadow : Life_RscText {
			idc = 682574;
			style = 0;
			text = "";
			x = 0.59 * safezoneW + safezoneX;
			y = 0.868 * safezoneH + safezoneY;
			w = 0.17 * safezoneW;
			h = 0.052 * safezoneH;
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {0, 0, 0, 0};
		};
		/* Affichage seul (comme la fiche contact) — ne pas mettre un RscButton par-dessus */
		class menu11_taxi_call : Life_RscText {
			idc = 682572;
			text = "APPELER UN TAXI";
			style = 2;
			x = 0.59 * safezoneW + safezoneX;
			y = 0.868 * safezoneH + safezoneY;
			w = 0.17 * safezoneW;
			h = 0.052 * safezoneH;
			colorText[] = {0, 0, 0, 1};
			colorBackground[] = {1, 1, 1, 1};
		};
		/* Zone cliquable AU-DESSUS du texte (dernier = premier plan) — comme menu3fichebtnappel */
		class menu11_taxi_call_hit : Life_RscButtonInvisible {
			idc = 682575;
			text = "";
			onButtonClick = "";
			x = 0.59 * safezoneW + safezoneX;
			y = 0.868 * safezoneH + safezoneY;
			w = 0.17 * safezoneW;
			h = 0.052 * safezoneH;
		};
		/*		END TAXI		*/

		class HomeBtn : Life_RscButtonInvisible {
			idc = -1;
			text = "";
			onButtonClick = "uiNamespace setVariable ['iphonemenu',0]; call ALF_fnc_menuiPhone;";
			x = 0.638907 * safezoneW + safezoneX;
			y = 0.963389 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.011 * safezoneH;
		};
	};
};

class menu10_twitter_tweet: Life_RscControlsGroup
{
	idc = 98110;
	x = 0;
	y = 0;
	w = safeZoneW * 0.135;
	h = safeZoneH * 0.05;

	class Controls
	{
		class menu10_twitter_background: Life_RscText
		{
			idc = 98111;
			style = 128;
			x = 0;
			y = 0;
			w = safeZoneW * 0.18875;
			h = safeZoneH * 0.11111112;
			colorBackground[] = {0.6,0.8,1,0.8};
		};

		class menu10_twitter_text : Life_RscStructuredText
		{
			idc = 98112;
			style = 0+16+512;
			x = 0;
			y = 0;
			w = safeZoneW * 0.13375;
			h = safeZoneH * 0.05333334;
			sizeEx = 0.0175 * safezoneW;
			lineSpacing = 0.8;
			text = "";
			colorText[] = {0.1,0.1,0.1,0.8};
			shadow = 0;
		};
	};
};
