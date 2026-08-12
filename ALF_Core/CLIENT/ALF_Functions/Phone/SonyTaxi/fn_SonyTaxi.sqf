/*
	File: fn_SonyTaxi.sqf
	Uber/Taxi tablettes Sony — même logique que iPhone (fetch, plus proche, ALF_fnc_iPhoneTaxiCall).
	[_display, "icon"] : active le bouton Uber du dialog (logo sur Sony_Menu.paa)
	[_display, "menu"]  : écran sony_uber.paa + APPELER UN TAXI
*/
params [
	["_display", displayNull, [displayNull]],
	["_mode", "icon", [""]]
];

if (isNull _display) exitWith {};

disableSerialization;

#define ALF_SONY_TAXI_TEX "\ALF_Client2\textures\sony\sony_uber.paa"
#define ALF_SONY_TAXI_FOND_X 0.200937
#define ALF_SONY_TAXI_FOND_Y 0.027
#define ALF_SONY_TAXI_FOND_W 0.587812
#define ALF_SONY_TAXI_FOND_H 1
#define ALF_SONY_TAXI_STAT_X 0.35
#define ALF_SONY_TAXI_STAT_Y 0.43
#define ALF_SONY_TAXI_STAT_W 0.28
#define ALF_SONY_TAXI_STAT_H 0.22
#define ALF_SONY_TAXI_CALL_X 0.41
#define ALF_SONY_TAXI_CALL_Y 0.70
#define ALF_SONY_TAXI_CALL_W 0.17
#define ALF_SONY_TAXI_CALL_H 0.052
#define ALF_SONY_TAXI_CALL_BORDER_X (ALF_SONY_TAXI_CALL_X - 0.002)
#define ALF_SONY_TAXI_CALL_BORDER_Y (ALF_SONY_TAXI_CALL_Y - 0.003)
#define ALF_SONY_TAXI_CALL_BORDER_W (ALF_SONY_TAXI_CALL_W + 0.004)
#define ALF_SONY_TAXI_CALL_BORDER_H (ALF_SONY_TAXI_CALL_H + 0.006)
#define ALF_SONY_TAXI_CALL_INSET 0.0012
#define ALF_SONY_TAXI_CALL_INNER_X (ALF_SONY_TAXI_CALL_X + ALF_SONY_TAXI_CALL_INSET)
#define ALF_SONY_TAXI_CALL_INNER_Y (ALF_SONY_TAXI_CALL_Y + ALF_SONY_TAXI_CALL_INSET)
#define ALF_SONY_TAXI_CALL_INNER_W (ALF_SONY_TAXI_CALL_W - 2 * ALF_SONY_TAXI_CALL_INSET)
#define ALF_SONY_TAXI_CALL_INNER_H (ALF_SONY_TAXI_CALL_H - 2 * ALF_SONY_TAXI_CALL_INSET)
#define ALF_SONY_TAXI_CALL_TEXT_H 0.03
#define ALF_SONY_TAXI_CALL_TEXT_Y (ALF_SONY_TAXI_CALL_Y + (ALF_SONY_TAXI_CALL_H - ALF_SONY_TAXI_CALL_TEXT_H) / 2)
#define ALF_SONY_TAXI_ICON_X 0.222
#define ALF_SONY_TAXI_ICON_Y 0.312
#define ALF_SONY_TAXI_ICON_W 0.10
#define ALF_SONY_TAXI_ICON_H 0.14
#define ALF_SONY_IDC_ICON 682579
#define ALF_SONY_IDC_FOND 682580
#define ALF_SONY_IDC_STAT 682581
#define ALF_SONY_IDC_CALL_BORDER 682584
#define ALF_SONY_IDC_CALL_BOX 682582
#define ALF_SONY_IDC_CALL_TXT 682583
#define ALF_SONY_IDC_HIT 682585
#define ALF_SONY_TAXI_CALL_ACTION "[] spawn ALF_fnc_iPhoneTaxiCall;"

private _idd = ctrlIDD _display;
private _cfg = switch (_idd) do {
	case 20520: { ["sonypm", 14, "ALF_fnc_menuSonyPM", 39000, 39155] };
	case 38999: { ["sonyp", 14, "ALF_fnc_menuSonyP", 39000, 39155] };
	case 32999: { ["sony", 19, "ALF_fnc_menuSony", 33000, 33192] };
	default { [] };
};

if (_cfg isEqualTo []) exitWith {};

_cfg params ["_menuVar", "_menuIndex", "_menuFn", "_homeIdc", "_uberIdc"];

private _fnc_setPos = {
	params ["_ctrl", "_x", "_y", "_w", "_h"];
	_ctrl ctrlSetPosition [_x * safezoneW + safezoneX, _y * safezoneH + safezoneY, _w * safezoneW, _h * safezoneH];
	_ctrl ctrlCommit 0;
};

private _fnc_ensureText = {
	params ["_idc", "_x", "_y", "_w", "_h"];
	private _ctrl = _display displayCtrl _idc;
	if (isNull _ctrl) then {
		_ctrl = _display ctrlCreate ["Life_RscStructuredText", _idc];
	};
	[_ctrl, _x, _y, _w, _h] call _fnc_setPos;
	_ctrl
};

// Rectangle blanc (682582) + texte centré par-dessus (682583) — 2 calques comme iPhone
private _fnc_setCallButtonLook = {
	params ["_peutAppeler"];
	private _bg = if (_peutAppeler) then {[1, 1, 1, 1]} else {[0.92, 0.92, 0.92, 1]};
	private _hex = if (_peutAppeler) then {"#000000"} else {"#737373"};

	private _box = _display displayCtrl ALF_SONY_IDC_CALL_BOX;
	if (!isNull _box) then {
		_box ctrlSetText "";
		_box ctrlSetBackgroundColor _bg;
	};

	private _txt = _display displayCtrl ALF_SONY_IDC_CALL_TXT;
	if (!isNull _txt) then {
		_txt ctrlSetBackgroundColor [0, 0, 0, 0];
		_txt ctrlSetStructuredText parseText format [
			"<t align='center' color='%1' font='PuristaMedium'>APPELER UN TAXI</t>",
			_hex
		];
	};
};

private _fnc_hideTaxiScreen = {
	{
		private _c = _display displayCtrl _x;
		if (!isNull _c) then {
			_c ctrlShow false;
			_c ctrlEnable false;
		};
	} forEach [ALF_SONY_IDC_FOND, ALF_SONY_IDC_STAT, ALF_SONY_IDC_CALL_BORDER, ALF_SONY_IDC_CALL_BOX, ALF_SONY_IDC_CALL_TXT, ALF_SONY_IDC_HIT];
};

private _fnc_bringCallHitToFront = {
	params [["_peutAppeler", true]];

	{
		private _c = _display displayCtrl _x;
		if (!isNull _c) then { ctrlDelete _c; };
	} forEach [ALF_SONY_IDC_CALL_BORDER, ALF_SONY_IDC_CALL_BOX, ALF_SONY_IDC_CALL_TXT, ALF_SONY_IDC_HIT];

	private _border = _display ctrlCreate ["Life_RscText", ALF_SONY_IDC_CALL_BORDER];
	[
		_border,
		ALF_SONY_TAXI_CALL_BORDER_X,
		ALF_SONY_TAXI_CALL_BORDER_Y,
		ALF_SONY_TAXI_CALL_BORDER_W,
		ALF_SONY_TAXI_CALL_BORDER_H
	] call _fnc_setPos;
	_border ctrlSetText "";
	_border ctrlSetBackgroundColor [1, 1, 1, 1];
	_border ctrlShow true;

	private _box = _display ctrlCreate ["Life_RscText", ALF_SONY_IDC_CALL_BOX];
	[
		_box,
		ALF_SONY_TAXI_CALL_INNER_X,
		ALF_SONY_TAXI_CALL_INNER_Y,
		ALF_SONY_TAXI_CALL_INNER_W,
		ALF_SONY_TAXI_CALL_INNER_H
	] call _fnc_setPos;
	_box ctrlSetText "";
	_box ctrlShow true;

	private _txt = _display ctrlCreate ["Life_RscStructuredText", ALF_SONY_IDC_CALL_TXT];
	[
		_txt,
		ALF_SONY_TAXI_CALL_X,
		ALF_SONY_TAXI_CALL_TEXT_Y,
		ALF_SONY_TAXI_CALL_W,
		ALF_SONY_TAXI_CALL_TEXT_H
	] call _fnc_setPos;
	_txt ctrlShow true;

	[_peutAppeler] call _fnc_setCallButtonLook;

	private _hit = _display ctrlCreate ["Life_RscButtonInvisible", ALF_SONY_IDC_HIT];
	[
		_hit,
		ALF_SONY_TAXI_CALL_X,
		ALF_SONY_TAXI_CALL_Y,
		ALF_SONY_TAXI_CALL_W,
		ALF_SONY_TAXI_CALL_H
	] call _fnc_setPos;
	_hit buttonSetAction ALF_SONY_TAXI_CALL_ACTION;
	_hit ctrlEnable true;
	_hit ctrlShow true;
	_hit
};

private _fnc_hideAllExceptTaxi = {
	private _keep = [ALF_SONY_IDC_FOND, ALF_SONY_IDC_STAT, ALF_SONY_IDC_CALL_BORDER, ALF_SONY_IDC_CALL_BOX, ALF_SONY_IDC_CALL_TXT, ALF_SONY_IDC_HIT, _homeIdc];
	{
		if (ctrlIDC _x in _keep) then {
			if (ctrlIDC _x isEqualTo _homeIdc) then { _x ctrlShow true; };
		} else {
			_x ctrlShow false;
		};
	} forEach allControls _display;
};

private _fnc_updateMenu = {
	private _statut = _display displayCtrl ALF_SONY_IDC_STAT;
	if (isNull _statut) exitWith {};

	private _lists = [] call ALF_fnc_iPhoneTaxiFetchLists;
	private _enLigneData = _lists # 0;
	private _appelablesData = (_lists # 1) select { (_x param [1, ""]) != "" };

	private _nombreLigne = count _enLigneData;
	private _nombreAppel = count _appelablesData;
	private _moiEnService = player getVariable ["MRP_Taxi_EnService", false];
	private _peutAppeler = !_moiEnService && { _nombreAppel > 0 };

	if (_moiEnService && { _nombreLigne isEqualTo 0 }) then {
		_nombreLigne = 1;
	};

	private _texteProche = "";
	if (!_moiEnService && { _nombreAppel > 0 }) then {
		private _nearest = [_appelablesData, player] call ALF_fnc_taxiPickNearest;
		private _pick = _nearest # 0;
		private _dist = _nearest # 1;
		if (_pick isEqualType [] && { count _pick >= 1 }) then {
			private _u = _pick # 0;
			private _nom = _pick param [2, ""];
			if (_nom isEqualTo "") then { _nom = name _u; };
			private _distTxt = [_dist] call ALF_fnc_taxiFormatDistance;
			_texteProche = format [
				"<br/><br/>" +
				"<t align='center' shadow='0' size='0.9' color='#999999' font='HelveticaLTLight'>CHAUFFEUR LE PLUS PROCHE</t><br/>" +
				"<t align='center' shadow='0' size='1.35' color='#FFFFFF' font='HelveticaLTLight'>%1</t><br/><br/>" +
				"<t align='center' shadow='0' size='1.05' color='#B8E6C8' font='HelveticaLTLight'>À %2 de vous</t>",
				_nom,
				_distTxt
			];
		};
	};

	private _texte = if (_nombreLigne > 0) then {
		if (_moiEnService && { _nombreAppel isEqualTo 0 }) then {
			format [
				"<t align='center' shadow='0' size='1.5' color='#FFFFFF' font='HelveticaLTLight'>Taxi en ligne : %1</t><br/><t align='center' shadow='0' size='1.1' color='#CCCCCC' font='HelveticaLTLight'>Vous êtes en service</t><br/><t align='center' shadow='0' size='1' color='#AAAAAA' font='HelveticaLTLight'>Appel impossible — vous êtes taxi</t>",
				_nombreLigne
			]
		} else {
			format [
				"<t align='center' shadow='0' size='1.5' color='#FFFFFF' font='HelveticaLTLight'>Taxi en ligne : %1</t>%2",
				_nombreLigne,
				_texteProche
			]
		};
	} else {
		"<t align='center' shadow='0' size='1.4' color='#FF6666' font='HelveticaLTLight'>Aucun taxi en ligne</t>"
	};

	_statut ctrlSetStructuredText parseText _texte;
	_statut ctrlShow true;

	_peutAppeler
};

private _actionOpen = format [
	"uiNamespace setVariable ['%1',%2]; [] call %3;",
	_menuVar,
	_menuIndex,
	_menuFn
];

private _fnc_showIconBtn = {
	params ["_show"];
	private _hppBtn = _display displayCtrl _uberIdc;
	if (!isNull _hppBtn) then {
		_hppBtn ctrlEnable _show;
		if (_show) then {
			_hppBtn buttonSetAction _actionOpen;
		} else {
			_hppBtn buttonSetAction "";
		};
		_hppBtn ctrlShow _show;
	};
	private _old = _display displayCtrl ALF_SONY_IDC_ICON;
	if (!isNull _old) then { ctrlDelete _old; };
	if (!_show) exitWith {};
	private _btn = _display ctrlCreate ["Life_RscButtonInvisible", ALF_SONY_IDC_ICON];
	[_btn, ALF_SONY_TAXI_ICON_X, ALF_SONY_TAXI_ICON_Y, ALF_SONY_TAXI_ICON_W, ALF_SONY_TAXI_ICON_H] call _fnc_setPos;
	_btn ctrlEnable true;
	_btn ctrlShow true;
	_btn buttonSetAction _actionOpen;
};

if (_mode isEqualTo "hide") exitWith {
	[] call _fnc_hideTaxiScreen;
	[false] call _fnc_showIconBtn;
};

private _fond = _display displayCtrl ALF_SONY_IDC_FOND;
if (isNull _fond) then {
	_fond = _display ctrlCreate ["Life_RscPicture", ALF_SONY_IDC_FOND];
};
[_fond, ALF_SONY_TAXI_FOND_X, ALF_SONY_TAXI_FOND_Y, ALF_SONY_TAXI_FOND_W, ALF_SONY_TAXI_FOND_H] call _fnc_setPos;
_fond ctrlSetText ALF_SONY_TAXI_TEX;

[ALF_SONY_IDC_STAT, ALF_SONY_TAXI_STAT_X, ALF_SONY_TAXI_STAT_Y, ALF_SONY_TAXI_STAT_W, ALF_SONY_TAXI_STAT_H] call _fnc_ensureText;

if (_mode isEqualTo "menu") then {
	[] call _fnc_hideAllExceptTaxi;
	// Fond recréé puis stat puis bouton = bon ordre d'affichage (bouton blanc visible)
	if (!isNull _fond) then { ctrlDelete _fond; };
	_fond = _display ctrlCreate ["Life_RscPicture", ALF_SONY_IDC_FOND];
	[_fond, ALF_SONY_TAXI_FOND_X, ALF_SONY_TAXI_FOND_Y, ALF_SONY_TAXI_FOND_W, ALF_SONY_TAXI_FOND_H] call _fnc_setPos;
	_fond ctrlSetText ALF_SONY_TAXI_TEX;
	_fond ctrlShow true;
	private _statCtrl = _display displayCtrl ALF_SONY_IDC_STAT;
	if (!isNull _statCtrl) then { ctrlDelete _statCtrl; };
	[ALF_SONY_IDC_STAT, ALF_SONY_TAXI_STAT_X, ALF_SONY_TAXI_STAT_Y, ALF_SONY_TAXI_STAT_W, ALF_SONY_TAXI_STAT_H] call _fnc_ensureText;
	private _peutAppeler = [] call _fnc_updateMenu;
	[_peutAppeler] call _fnc_bringCallHitToFront;
} else {
	[] call _fnc_hideTaxiScreen;
	private _onAccueil = (uiNamespace getVariable [_menuVar, 0]) isEqualTo 0;
	private _peutUber = _onAccueil && {!ALF_Phone_inCall} && {!ALF_Phone_Ring} && {!ALF_Phone_tryCall};
	[_peutUber] call _fnc_showIconBtn;
};

TRUE
