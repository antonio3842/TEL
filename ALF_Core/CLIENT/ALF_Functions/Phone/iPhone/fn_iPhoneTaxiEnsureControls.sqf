/*

	Crée / met à jour les contrôles Taxi iPhone — icône accueil + écran Uber.

	_forMenu false : icône uniquement (évite le flash à l'ouverture du téléphone).

	_forMenu true  : affiche l'écran taxi complet.

*/

params [

	["_display", displayNull, [displayNull]],

	["_forMenu", false, [false]]

];



if (isNull _display) exitWith {[]};



#define ALF_IPHONE_TAXI_X 0.683411

#define ALF_IPHONE_TAXI_Y 0.43923612

#define ALF_IPHONE_TAXI_W 0.02929688

#define ALF_IPHONE_TAXI_H 0.04861112



#define ALF_IPHONE_TAXI_MENU_TEX "\ALF_Client2\textures\iPhone\ALF_iPhone_15.paa"

#define ALF_IPHONE_TAXI_STAT_X 0.555

#define ALF_IPHONE_TAXI_STAT_Y 0.44

#define ALF_IPHONE_TAXI_STAT_W 0.24

#define ALF_IPHONE_TAXI_STAT_H 0.22

#define ALF_IPHONE_TAXI_CALL_X 0.59

#define ALF_IPHONE_TAXI_CALL_Y 0.868

#define ALF_IPHONE_TAXI_CALL_W 0.17

#define ALF_IPHONE_TAXI_CALL_H 0.052



#define ALF_IPHONE_TAXI_CALL_ACTION "[] spawn ALF_fnc_iPhoneTaxiCall;"



private _fnc_setPos = {

	params ["_ctrl", "_x", "_y", "_w", "_h"];

	_ctrl ctrlSetPosition [_x * safezoneW + safezoneX, _y * safezoneH + safezoneY, _w * safezoneW, _h * safezoneH];

	_ctrl ctrlCommit 0;

};



private _fnc_ensureBtnHome = {

	params ["_idc", "_x", "_y", "_w", "_h"];

	private _ctrl = _display displayCtrl _idc;

	if (!isNull _ctrl) exitWith {_ctrl};

	_ctrl = _display ctrlCreate ["Life_RscButtonInvisible", _idc];

	[_ctrl, _x, _y, _w, _h] call _fnc_setPos;

	_ctrl

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



private _fnc_hideTaxiScreen = {

	private _fond = _display displayCtrl 682570;

	private _stat = _display displayCtrl 682571;

	private _label = _display displayCtrl 682572;

	private _shadow = _display displayCtrl 682574;

	private _hit = _display displayCtrl 682575;

	if (!isNull _fond) then { _fond ctrlShow false; };

	if (!isNull _stat) then { _stat ctrlShow false; };

	if (!isNull _label) then { _label ctrlShow false; };

	if (!isNull _shadow) then { _shadow ctrlShow false; };

	if (!isNull _hit) then { _hit ctrlShow false; };

};



private _fnc_bringCallHitToFront = {

	params ["_display"];



	private _shadow = _display displayCtrl 682574;

	if (!isNull _shadow) then { _shadow ctrlShow false; };



	private _label = _display displayCtrl 682572;

	if (!isNull _label) then {

		[_label, ALF_IPHONE_TAXI_CALL_X, ALF_IPHONE_TAXI_CALL_Y, ALF_IPHONE_TAXI_CALL_W, ALF_IPHONE_TAXI_CALL_H] call _fnc_setPos;

		_label ctrlSetText "APPELER UN TAXI";

		_label ctrlSetTextColor [0, 0, 0, 1];

		_label ctrlSetBackgroundColor [1, 1, 1, 1];

		_label ctrlShow true;

	};



	private _oldHit = _display displayCtrl 682575;

	private _posHit = if (!isNull _oldHit) then { ctrlPosition _oldHit } else {

		[

			ALF_IPHONE_TAXI_CALL_X * safezoneW + safezoneX,

			ALF_IPHONE_TAXI_CALL_Y * safezoneH + safezoneY,

			ALF_IPHONE_TAXI_CALL_W * safezoneW,

			ALF_IPHONE_TAXI_CALL_H * safezoneH

		]

	};

	if (!isNull _oldHit) then { ctrlDelete _oldHit; };



	private _hit = _display ctrlCreate ["Life_RscButtonInvisible", 682575];

	_hit ctrlSetPosition _posHit;

	_hit ctrlCommit 0;

	_hit buttonSetAction ALF_IPHONE_TAXI_CALL_ACTION;

	_hit ctrlEnable true;

	_hit ctrlShow true;



	_hit

};



private _oldLabel = uiNamespace getVariable ["ALF_iPhone_Taxi_Label", controlNull];

if (!isNull _oldLabel) then {

	ctrlDelete _oldLabel;

	uiNamespace setVariable ["ALF_iPhone_Taxi_Label", controlNull];

};



private _oldIcon = uiNamespace getVariable ["ALF_iPhone_Taxi_Icone", controlNull];

if (!isNull _oldIcon) then {

	ctrlDelete _oldIcon;

	uiNamespace setVariable ["ALF_iPhone_Taxi_Icone", controlNull];

};



private _btnTaxi = [564016, ALF_IPHONE_TAXI_X, ALF_IPHONE_TAXI_Y, ALF_IPHONE_TAXI_W, ALF_IPHONE_TAXI_H] call _fnc_ensureBtnHome;

[_btnTaxi, ALF_IPHONE_TAXI_X, ALF_IPHONE_TAXI_Y, ALF_IPHONE_TAXI_W, ALF_IPHONE_TAXI_H] call _fnc_setPos;

_btnTaxi ctrlEnable true;

_btnTaxi buttonSetAction "uiNamespace setVariable ['iphonemenu', 11]; [] call ALF_fnc_menuiPhone;";



private _fond = _display displayCtrl 682570;

if (isNull _fond) then {

	_fond = _display ctrlCreate ["Life_RscPicture", 682570];

};

[_fond, 0.448438, 0.247, 0.454324, 0.766407] call _fnc_setPos;

_fond ctrlSetText ALF_IPHONE_TAXI_MENU_TEX;



[682571, ALF_IPHONE_TAXI_STAT_X, ALF_IPHONE_TAXI_STAT_Y, ALF_IPHONE_TAXI_STAT_W, ALF_IPHONE_TAXI_STAT_H] call _fnc_ensureText;



if (_forMenu) then {

	_fond ctrlShow true;

	[_display] call _fnc_bringCallHitToFront;

} else {

	[] call _fnc_hideTaxiScreen;

};



TRUE

